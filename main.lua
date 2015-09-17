dofile("uHUD/uhud.lua")
dofile("sidebar.lua")

local os = require("os")

local myHUD = HUD:new("openperipheral_bridge")
local myStats = Sidebar:new(myHUD, "Base", 6, 20)

local pablodeaths = 0

function main()
   myStats:addInfo("Pablo deaths", tostring(pablodeaths))

   while true do
      pablodeaths = pablodeaths + 1
      myStats:setInfo("Pablo deaths", tostring(pablodeaths))

      myStats:tick()

      os.sleep(1)
   end
end

main()
