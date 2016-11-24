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
  self.height = 336
  self.width = 336

  self.mission_xml = opts.mission_xml or [[<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<Mission xmlns="http://ProjectMalmo.microsoft.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <About>
      <Summary>Mind your step! Moving around an area to find a goal or get out of it</Summary>
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
          <DrawCuboid colour="PINK" type="stained_glass" x1="-21" x2="21" y1="226" y2="226" z1="-21" z2="21"/>
          <DrawCuboid type="emerald_block" x1="-20" x2="20" y1="226" y2="226" z1="-20" z2="20"/>
        </DrawingDecorator>
        <DrawingDecorator>
          <DrawBlock type="lava" x="8" y="226" z="10"/>
          <DrawBlock type="redstone_block" x="-7" y="226" z="12"/>
          <DrawBlock type="obsidian" x="-14" y="226" z="8"/>
          <DrawBlock type="lava" x="-15" y="226" z="15"/>
          <DrawBlock type="lava" x="10" y="226" z="-11"/>
          <DrawBlock type="redstone_block" x="-2" y="226" z="4"/>
          <DrawBlock type="obsidian" x="-3" y="226" z="-7"/>
          <DrawBlock type="lava" x="-17" y="226" z="-13"/>
          <DrawBlock type="obsidian" x="1" y="226" z="2"/>
          <DrawBlock type="redstone_block" x="-4" y="226" z="-10"/>
          <DrawBlock type="redstone_block" x="-6" y="226" z="3"/>
          <DrawBlock type="obsidian" x="2" y="226" z="-1"/>
          <DrawBlock type="redstone_block" x="-13" y="226" z="-10"/>
          <DrawBlock type="obsidian" x="2" y="226" z="10"/>
          <DrawBlock type="lava" x="-19" y="226" z="1"/>
          <DrawBlock type="redstone_block" x="-1" y="226" z="-18"/>
          <DrawBlock type="obsidian" x="-20" y="226" z="16"/>
          <DrawBlock type="lava" x="-1" y="226" z="-4"/>
          <DrawBlock type="redstone_block" x="3" y="226" z="13"/>
          <DrawBlock type="lava" x="-8" y="226" z="-13"/>
          <DrawBlock type="obsidian" x="-3" y="226" z="-12"/>
          <DrawBlock type="redstone_block" x="7" y="226" z="2"/>
          <DrawBlock type="lava" x="-10" y="226" z="12"/>
          <DrawBlock type="lava" x="2" y="226" z="-18"/>
          <DrawBlock type="lava" x="16" y="226" z="-12"/>
          <DrawBlock type="lava" x="0" y="226" z="7"/>
          <DrawBlock type="lava" x="12" y="226" z="11"/>
          <DrawBlock type="redstone_block" x="15" y="226" z="-20"/>
          <DrawBlock type="obsidian" x="-12" y="226" z="-1"/>
          <DrawBlock type="obsidian" x="-20" y="226" z="17"/>
          <DrawBlock type="obsidian" x="-7" y="226" z="-13"/>
          <DrawBlock type="lava" x="18" y="226" z="16"/>
          <DrawBlock type="obsidian" x="9" y="226" z="-20"/>
          <DrawBlock type="lava" x="20" y="226" z="-18"/>
          <DrawBlock type="obsidian" x="-1" y="226" z="14"/>
          <DrawBlock type="lava" x="-10" y="226" z="-9"/>
          <DrawBlock type="obsidian" x="18" y="226" z="12"/>
          <DrawBlock type="redstone_block" x="15" y="226" z="-19"/>
          <DrawBlock type="obsidian" x="17" y="226" z="-3"/>
          <DrawBlock type="obsidian" x="-4" y="226" z="4"/>
          <DrawBlock type="obsidian" x="1" y="226" z="7"/>
          <DrawBlock type="lava" x="20" y="226" z="4"/>
          <DrawBlock type="lava" x="1" y="226" z="10"/>
          <DrawBlock type="obsidian" x="11" y="226" z="19"/>
          <DrawBlock type="lava" x="0" y="226" z="-8"/>
          <DrawBlock type="redstone_block" x="-11" y="226" z="-15"/>
          <DrawBlock type="redstone_block" x="-9" y="226" z="-15"/>
          <DrawBlock type="lava" x="-18" y="226" z="-3"/>
          <DrawBlock type="lava" x="-15" y="226" z="-1"/>
          <DrawBlock type="lava" x="5" y="226" z="-4"/>
          <DrawBlock type="redstone_block" x="16" y="226" z="-20"/>
          <DrawBlock type="obsidian" x="-5" y="226" z="20"/>
          <DrawBlock type="obsidian" x="9" y="226" z="-20"/>
          <DrawBlock type="lava" x="5" y="226" z="-20"/>
          <DrawBlock type="redstone_block" x="-15" y="226" z="-15"/>
          <DrawBlock type="lava" x="16" y="226" z="-5"/>
          <DrawBlock type="redstone_block" x="17" y="226" z="-14"/>
          <DrawBlock type="lava" x="7" y="226" z="-1"/>
          <DrawBlock type="redstone_block" x="15" y="226" z="5"/>
          <DrawBlock type="obsidian" x="-4" y="226" z="-17"/>
          <DrawBlock type="obsidian" x="-9" y="226" z="-1"/>
          <DrawBlock type="obsidian" x="-1" y="226" z="15"/>
          <DrawBlock type="redstone_block" x="-19" y="226" z="8"/>
          <DrawBlock type="lava" x="-7" y="226" z="-8"/>
          <DrawBlock type="obsidian" x="-14" y="226" z="-2"/>
          <DrawBlock type="obsidian" x="-15" y="226" z="-15"/>
          <DrawBlock type="lava" x="6" y="226" z="-10"/>
          <DrawBlock type="lava" x="5" y="226" z="18"/>
          <DrawBlock type="redstone_block" x="9" y="226" z="-20"/>
        </DrawingDecorator>
        <ServerQuitFromTimeUp description="out_of_time" timeLimitMs="30000"/>
        <ServerQuitWhenAnyAgentFinishes description=""/>
      </ServerHandlers>
    </ServerSection>
    
    <AgentSection mode="Survival">
      <Name>The Hungry Caterpillar</Name>
      <AgentStart>
        <Placement pitch="0" x="0.5" y="227.0" yaw="0" z="0.5"/>
        <Inventory/>
      </AgentStart>
      <AgentHandlers>
        <VideoProducer want_depth="false">
          <Width>640</Width>
          <Height>480</Height>
        </VideoProducer>
        <RewardForTouchingBlockType>
          <Block behaviour="oncePerBlock" cooldownInMs="1000" reward="0.1" type="obsidian"/>
        </RewardForTouchingBlockType>
        <RewardForMissionEnd rewardForDeath="-1">
          <Reward description="out_of_time" reward="-0.9"/>
          <Reward description="out_of_arena" reward="0.1"/>
          <Reward description="found_goal" reward="0.4"/>
        </RewardForMissionEnd>
        <ContinuousMovementCommands turnSpeedDegs="180">
          <ModifierList type="deny-list">
            <command>attack</command>
          </ModifierList>
        </ContinuousMovementCommands>
      <MissionQuitCommands quitDescription="give_up"/>
	  <RewardForSendingCommand reward="0"/>
        <AgentQuitFromTouchingBlockType>
          <Block description="out_of_arena" type="stained_glass"/>
          <Block description="found_goal" type="redstone_block"/>
        </AgentQuitFromTouchingBlockType>
      </AgentHandlers>
    </AgentSection>
    
  </Mission>
]]

  self.actions = opts.actions or {"turn 0.5", "turn -0.5"}

  self.agent_host = AgentHost()

  -- Load mission XML from provided file
  if opts.mission_xml then
    print("Loading mission XML from: " .. self.mission_xml)
    local f = assert(io.open(self.mission_xml, "r"), "Error loading mission")
    self.mission_xml = f:read("*a")
  end
end

function Minecraft:getDisplaySpec()
  return {'real', {3, self.height, self.width}, {0, 1}} 
end

function Minecraft:getDisplay()
  return self.proc_frames[1]
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
  
  for i = 1, 100 do
	local x = torch.random(-20, 20)
	sleep(1e-3)
	local z = torch.random(-20, 20)
	sleep(1e-3)
	mission:drawBlock(x, 226, z, "lava")
  end

  -- Request video
  mission:requestVideo(self.height, self.width)

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
    print("test")
  end	
  
  self.proc_frames = self:processFrames(world_state.video_frames)
  
  self.rewards = self:getRewards(world_state.rewards)
  
  self.agent_host:sendCommand("move 0.5") -- start moving
  
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
