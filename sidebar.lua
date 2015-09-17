Sidebar = class("BarList")

function Sidebar:initialize(hud, title, x, y)
  self.hud = hud
  self.title = title
  self.x = x
  self.y = y

  self.width = 73

  self.info = {}
  self.bars = {}
  self.notifications = {}
  self.lastYDiff = 0
end

function Sidebar:addInfo(name, value)
  local info = {}

  info["label"] = Label:new("infolabel_" .. name, 1, 1, name, 0xEEEEEE)
  self.hud:addWidget(info["label"])
  info["label"]:setTextScale(0.5)

  info["text"] = Label:new("infotext_" .. name, 1, 1, value, 0xDDDDDD)
  self.hud:addWidget(info["text"])
  info["text"]:setTextScale(0.5)

  self.info[name] = info
  self:recalcPositions()
end

function Sidebar:setInfo(name, value)
  self.info[name]["text"]:setText(value)
  self:recalcPositions()
end
function Sidebar:removeInfo(name)

end

function Sidebar:addBar(name, value, label, lowWarning, highWarning)
  if not lowWarning then
    lowWarning = 0
  end
  if not highWarning then
    highWarning = 1.1
  end

  local bar = {}
  local labelName = Label:new("name_" .. name, 1, 1, name, 0xEEEEEE) -- Use dummy positions
  self.hud:addWidget(labelName)
  labelName:setTextScale(0.5)

  local bar = HorizontalBar:new("bar_" .. name, 1, 1, self.width, 6, 0x00FF61, 0x000000, 0x222222, 0.6)
  self.hud:addWidget(bar)

  local lbl = Label:new("lbl_" .. name, 2, 2, label, 0xDDDDDD)
  self.hud:addWidget(lbl)
  lbl:setTextScale(0.5)

  bar[1] = labelName
  bar[2] = bar
  bar[3] = lowWarning
  bar[4] = highWarning
  bar[5] = lbl
  self.bars[name] = bar

  self:setBarValue(name, value)

  self:recalcPositions()
end

function Sidebar:setBarValue(name, value)
  local bar = self.bars[name]
  if value < bar[3] then
    bar[2]:setFG(0xFF0000, 0.8)
  elseif value > bar[4] then
    bar[2]:setFG(0xFF0000, 0.8)
  else
    bar[2]:setFG(0x00FF61)
  end
  bar[2]:setValue(value)
  self:recalcPositions()
end

function Sidebar:setBarLabel(name, label)
  local bar = self.bars[name]
  bar[5]:setText(label)
  self:recalcPositions()
end

function Sidebar:removeBar(name)
  local bar = self.bars[name]
  self.hud:removeWidget(bar[1].name)
  self.hud:removeWidget(bar[2].name)
  self.bars[name] = null
  self:recalcPositions()
end

function Sidebar:addNotification(title, body, hideDelay)
  local item = {}
  local noti = Notification:new("noti_" ..  title .. tostring(os.time()), 1, 1, self.width, 30, title, body, 0xFFFFFF, 0x222222, 0x00FF61, 0.8)
  self.hud:addWidget(noti)
  item["noti"] = noti
  item["current"] = 0
  item["delay"] = hideDelay
  table.insert(self.notifications, item)
  self:recalcPositions()
end

function Sidebar:removeNotification(index)
  local noti = self.notifications[index]
  self.hud:removeWidget(noti["noti"].name)
  table.remove(self.notifications, index)
  self:recalcPositions()
end

function Sidebar:tick()
  for i,v in ipairs(self.notifications) do
    v["current"] = v["current"] + 1
    v["noti"]:setProgress(v["current"] / v["delay"])
    if v["current"] > v["delay"] then
      self:removeNotification(i)
    end
  end
end

function Sidebar:recalcPositions()
  self.lastYDiff = 0
  for k,v in pairs(self.info) do
    v["label"]:setPosition(self.x, self.y + self.lastYDiff)
    local textWidth = textWidthScale(self.hud.bridge, v["text"].text, 0.5)
    v["text"]:setPosition(self.x + self.width - textWidth, self.y + self.lastYDiff)
    self.lastYDiff = self.lastYDiff + 6
  end
  for k,v in pairs(self.bars) do
    v[1]:setPosition(self.x, self.y + self.lastYDiff)
    local labelWidth = textWidthScale(self.hud.bridge, v[5].text, 0.5)
    v[5]:setPosition(self.x + self.width - labelWidth, self.y + self.lastYDiff)
    self.lastYDiff = self.lastYDiff + 5
    v[2]:setPosition(self.x, self.y + self.lastYDiff)
    self.lastYDiff = self.lastYDiff + 6 + 1 -- height + spacing for next bar
  end
  self.lastYDiff = self.lastYDiff + 1
  for i,v in ipairs(self.notifications) do
    v["noti"]:setPosition(self.x, self.y + self.lastYDiff)
    self.lastYDiff = self.lastYDiff + v["noti"].height + 2
  end
end
