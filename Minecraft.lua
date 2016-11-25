local classic = require 'classic'
local image = require 'image'
-- Do not install if luasocket missing
local hasSocket, socket = pcall(require, 'socket')
if not hasSocket then
  return nil
end
-- Do not require libMalmoLua for install
local hasLibMalmoLua, libMalmoLua = pcall(require, 'libMalmoLua')

local Minecraft, super = classic.class('Minecraft', Env)

local function sleep(sec)
  socket.select(nil, nil, sec)
end

-- Constructor
function Minecraft:_init(opts)
  -- Check libaMalmoLua is available locally
  if not hasLibMalmoLua then
    print("Requires libMalmoLua.so")
    os.exit()
  end
  
  opts = opts or {}
  self.height = opts.height * opts.zoom
  self.width = opts.width * opts.zoom

  self.mission_xml = opts.mission_xml or [[<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<Mission xmlns="http://ProjectMalmo.microsoft.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <About>
    <Summary>Cliff walking mission based on Sutton and Barto.</Summary>
  </About>
  
  <ModSettings>
    <MsPerTick>25</MsPerTick>
  </ModSettings>

  <ServerSection>
      <ServerInitialConditions>
            <Time>
                <StartTime>6000</StartTime>
                <AllowPassageOfTime>false</AllowPassageOfTime>
            </Time>
            <Weather>clear</Weather>
            <AllowSpawning>false</AllowSpawning>
      </ServerInitialConditions>
    <ServerHandlers>
      <FlatWorldGenerator generatorString="3;7,220*1,5*3,2;3;,biome_1"/>
      <DrawingDecorator>
        <!-- coordinates for cuboid are inclusive -->
        <DrawCuboid x1="-2" y1="46" z1="-2" x2="7" y2="50" z2="18" type="air" />            <!-- limits of our arena -->
        <DrawCuboid x1="-2" y1="45" z1="-2" x2="7" y2="45" z2="18" type="lava" />           <!-- lava floor -->
        <DrawCuboid x1="1"  y1="45" z1="1"  x2="3" y2="45" z2="12" type="sandstone" />      <!-- floor of the arena -->
        <DrawCuboid x1="4"  y1="45" z1="1"  x2="4" y2="45" z2="2"  type="cobblestone" />    <!-- the starting marker -->
        <DrawCuboid x1="4"  y1="45" z1="12" x2="4" y2="45" z2="11" type="lapis_block" />    <!-- the destination marker -->
        <DrawItem    x="4"   y="46"  z="12" type="diamond" />                               <!-- another destination marker -->
      </DrawingDecorator>
      <ServerQuitFromTimeUp timeLimitMs="1000000"/>
      <ServerQuitWhenAnyAgentFinishes/>
    </ServerHandlers>
  </ServerSection>

  <AgentSection mode="Survival">
    <Name>Cristina</Name>
    <AgentStart>
      <Placement x="4.5" y="46.0" z="1.5" pitch="30" yaw="0"/>
    </AgentStart>
    <AgentHandlers>
      <ObservationFromFullStats/>
      <VideoProducer want_depth="false">
          <Width>640</Width>
          <Height>480</Height>
      </VideoProducer>
      <ContinuousMovementCommands turnSpeedDegs="180">
          <ModifierList type="deny-list">
            <command>attack</command>
          </ModifierList>
      </ContinuousMovementCommands>
      <RewardForMissionEnd rewardForDeath="-100">
		  <Reward description="found_goal" reward="100"/>
      </RewardForMissionEnd>   
      <RewardForSendingCommand reward="-1"/>
      <MissionQuitCommands quitDescription="give_up"/>
      <AgentQuitFromTouchingBlockType>
          <Block description="found_goal" type="lapis_block"/>
      </AgentQuitFromTouchingBlockType>
    </AgentHandlers>
  </AgentSection>

</Mission>
]]

  self.actions = opts.actions or {"turn 0.3", "turn -0.3"}

  self.agent_host = AgentHost()

  -- Load mission XML from provided file
  if opts.mission_xml then
    print("Loading mission XML from: " .. self.mission_xml)
    local f = assert(io.open(self.mission_xml, "r"), "Error loading mission")
    self.mission_xml = f:read("*a")
  end
end

-- returned states are RGB images
function Minecraft:getStateSpec()
  return {'real', {3, self.height, self.width}, {0, 1}}
end

function Minecraft:getActionSpec()
  return {'int', 1, {1, #self.actions}}
end

-- Min and max reward
function Minecraft:getRewardSpec()
  return nil, nil
end

-- process video input from the world
function Minecraft:processFrames(world_video_frames)
  local proc_frames = {}

  for frame in world_video_frames do
    local ti = torch.FloatTensor(3, self.height, self.width)
    getTorchTensorFromPixels(frame, tonumber(torch.cdata(ti, true)))
    ti:div(255)
    table.insert(proc_frames, ti)
  end

  return proc_frames
end

function Minecraft:getRewards(world_rewards)
  local proc_rewards = {}

  for reward in world_rewards do
    table.insert(proc_rewards, reward:getValue())
  end

  return proc_rewards
end

-- Start new mission
function Minecraft:start()

  local world_state = self.agent_host:peekWorldState()
	
  -- check if a previous mission is still running before starting a new one
  if world_state.is_mission_running then
	  self.agent_host:sendCommand("quit")
	  sleep(0.5)
  end	

  local mission = MissionSpec(self.mission_xml, true)
  local mission_record = MissionRecordSpec()
  
  -- Request video
  mission:requestVideo(self.height, self.width)
  
  -- Add holes for interest
  for z = 3, 10, 2 do
    local x = torch.random(1, 3)
    mission:drawBlock(x, 45, z, "lava")
  end

  -- Channels, height, width of input frames
  local channels = mission:getVideoChannels(0)
  local height = mission:getVideoHeight(0)
  local width = mission:getVideoWidth(0)

  assert(channels == 3, "No RGB video output")
  assert(height == self.height or width == self.width, "Video output dimensions don't match those requested")

  local status, err = pcall(function() self.agent_host:startMission( mission, mission_record ) end)
  if not status then
    print("Error starting mission: "..err)
    os.exit(1)
  end

  io.write("Waiting for mission to start")
  local world_state = self.agent_host:getWorldState()
  while not world_state.has_mission_begun do
    io.write(".")
    io.flush()
    sleep(0.05)
    world_state = self.agent_host:getWorldState()
    for error in world_state.errors do
      print("Error: "..error.text)
    end
  end
  io.write("\n")
  
  sleep(0.5)
  
  while world_state.number_of_video_frames_since_last_state < 1 do
	sleep(0.05)
    world_state = self.agent_host:peekWorldState()
  end	
  
  self.proc_frames = self:processFrames(world_state.video_frames)
  
  self.rewards = self:getRewards(world_state.rewards)
  
  self.agent_host:sendCommand("move 0.3") -- start moving
  
  sleep(0.05)

  -- Return first state
  return self.proc_frames[1]
end

-- Select an action
function Minecraft:step(action)

  -- Do something
  local action = self.actions[action]
  
  self.agent_host:sendCommand(action)

  -- Wait for command to be received and world state to change
  sleep(0.05)

  -- Check the world state
  local world_state = self.agent_host:peekWorldState()
  
  -- Zero previous reward
  self.rewards[1] = 0
  -- Receive a reward
  local max_retries = 5
  while world_state.number_of_rewards_since_last_state < 1 and max_retries >= 0 do
    sleep(0.05)
    world_state = self.agent_host:peekWorldState()
    max_retries = max_retries - 1
  end
  if max_retries >= 0 then 
    self.rewards = self:getRewards(world_state.rewards)
  else
	print(max_retries)
  end
  
  -- Zero previous frame
  self.proc_frames[1]:zero()
  local max_retries = 5
  while world_state.number_of_video_frames_since_last_state < 1 and max_retries >= 0 do
	sleep(0.05)
    world_state = self.agent_host:peekWorldState()
    max_retries = max_retries - 1
  end
  if max_retries >= 0 then
    self.proc_frames = self:processFrames(world_state.video_frames)
  else
	print(max_retries)
  end

  local terminal = not world_state.is_mission_running
  
  world_state = self.agent_host:getWorldState()
  
  if terminal then
	sleep(0.5)
  end

  return self.rewards[1], self.proc_frames[1], terminal
end

return Minecraft
