# Atari + Minecraft ![Space Invader](http://www.rw-designer.com/cursor-view/74522.png)

To run with Minecraft environment (requires Project Malmo):

1) Install dependencies:
   - `luarocks install luasocket`
   - Add `libMalmoLua.so` to `LUA_CPATH`, and the level schemas should be exported to `MALMO_XSD_PATH`. 
     For example, if MalmoPlatform is in `/home/username`, add the following to the end of your `~/.bashrc`:
     - `export LUA_CPATH='/home/username/MalmoPlatform/Torch_Examples/?.so;'$LUA_CPATH`  
     - `export MALMO_XSD_PATH=/home/username/MalmoPlatform`
  
2) (Optional) Modify DQN-related settings in `run_minecraft.sh`.
   The default settings work well but you can disable recurrent network
   (`-recurrent false`) if you find it runs too slow on your system.
  
3) (Optional) Place a mission XML file in the same folder as `main.lua`,
   add `-mission mission_file.xml` to `run_minecraft.sh` if you do so.
   
4) Run a Malmo client:
   - Go to the folder where you unzipped Malmo, then:
     - `cd Minecraft`
     - `./launchClient.sh`
   
5) `./run_minecraft.sh`

If you have [rlenvs](https://github.com/Kaixhin/rlenvs) installed you can use the Minecraft
environment I have included there by replacing `-env Minecraft` with 
`-env rlenvs.Minecraft`. 
Make sure to follow the instrunctions there for installing Minecraft dependencies.
