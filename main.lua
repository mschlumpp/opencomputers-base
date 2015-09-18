dofile("uHUD/uhud.lua")
dofile("sidebar.lua")

local os = require("os")
local keyboard = require("keyboard")
local event = require("event")
local math = require("math")
local computer = require("computer")

local myHUD = HUD:new("openperipheral_bridge")
local myStats = Sidebar:new(myHUD, "Base", 6, 20)

local state = {
   uptime = 0,
   hour = 0,
   minute = 0,
}

function updateState()
  state.uptime = computer.uptime()
end

function updateHUD()
  myStats:setInfo("Uptime", tostring(state.uptime))
  myStats:tick()
  myHUD:sync()
end

function timerCallback()
  updateState()
  updateHUD()
end

function dispatchEvent(handlers, eventID, ...)
  if handlers[eventID] then
    handlers[eventID](...)
  end
end

function main()
  local running = true

  event.timer(0.5, timerCallback, math.huge)
  local handlers = {
    "key_up" = function(address, char, code, playername)
      if char == "t" then
        running = false
      end
    end
  }

  while running do
    dispatchEvent(handlers, event.pull())
  end
end

main()
