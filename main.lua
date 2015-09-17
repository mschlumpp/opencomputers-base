dofile("uHUD/uhud.lua")
dofile("sidebar.lua")

local os = require("os")

local myHUD = HUD:new("openperipheral_bridge")
local myStats = Sidebar:new(myHUD, "Base", 6, 20)

function main()
   mystats:addInfo("Pablo deaths", "9000")

   while true do
      mystats:tick()

      os.sleep(1)
   end
end
