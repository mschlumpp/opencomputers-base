Notification = Widget:subclass("Notification")

function Notification:initialize(name, x, y, width, height, title, body, fg, bg, progresscolor, opacity)
  Widget.initialize(self, name, x, y, width, height)
  self.title = title
  self.body = body
  self.fg = fg
  self.bg = bg
  self.progresscolor = progresscolor
  self.opacity = opacity
  
  self.progress = 0
  self.bodyparts = {}
end

function Notification:createComponents(bridge)
  -- Progress
  self.components[1] = bridge.addBox(self.x, self.y, self.width * self.progress, 1, self.progresscolor, self.opacity)
  self.components[1].setZ(-1)
  -- Background
  self.components[2] = bridge.addBox(self.x, self.y, self.width, self.height, self.bg, self.opacity)
  self.components[2].setZ(-2)
  -- Text
  local charlen = textWidthScale(bridge, "M", 0.5)
  
  -- Title
  self.components[3] = bridge.addText(self.x + 2, self.y + 3, self.title, self.fg)
  self.components[3].setScale(0.57)
  
  -- Body
  local wrapped = wrapText(self.body, self.width / charlen)
  
  local ydiff = 9
  for i,line in ipairs(wrapped) do
    self.components[3+i] = bridge.addText(self.x + 2, self.y + ydiff, line, self.fg)
    self.components[3+i].setScale(0.5)
    ydiff = ydiff + 5
  end
end

function Notification:setProgress(val)
  self.progress = val
  self.components[1].setWidth(self.width * self.progress)
end
