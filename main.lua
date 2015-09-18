dofile("uHUD/uhud.lua")
dofile("sidebar.lua")

local os = require("os")
local keyboard = require("keyboard")
local event = require("event")
local math = require("math")
local computer = require("computer")
local component = require("component")

local myHUD = HUD:new("openperipheral_bridge")
local myStats = Sidebar:new(myHUD, "Base", 6, 20)
local meController = component.me_controller

local state = {
   uptime = 0,
   hour = 0,
   minute = 0,
   energy = 0,
   max_energy = computer.maxEnergy(),
   iron_amount = 0,
}

function updateState()
  state.uptime = computer.uptime()
  state.energy = computer.energy()

  local items = meController.getAvailableItems()
  for i, item in ipairs(items) do
    if item.fingerprint.id == "minecraft:iron_ingot" then
      state.iron_amount = item.size
    end
  end
end

function initHUD()
  myStats:addBar("Computer Energy", 0, "", 400 / state.max_energy)
end

function updateHUD()
  myStats:setInfo("Uptime", tostring(state.uptime))
  myStats:setInfo("Iron Ingots", tostring(state.iron_amount))

  myStats:setBarLabel("Computer Energy", string.format("%.2f", state.energy))
  myStats:setBarValue("Computer Energy", state.energy / state.max_energy)

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
  print("Press 't' to stop program.")

  local running = true

  local tid = event.timer(0.5, timerCallback, math.huge)
  local handlers = {
    key_up = function(address, char, code, playername)
      if char == 116 then
        running = false
      end
    end
  }

  initHUD()
  while running do
    dispatchEvent(handlers, event.pull())
  end
  event.cancel(tid)
end

main()
