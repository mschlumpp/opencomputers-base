HorizontalBar = Widget:subclass("HorizontalBar")

function HorizontalBar:initialize(name, x, y, width, height, fg, bg, bordercolor, opacity)
  Widget.initialize(self, name, x, y, width, height)
  self.fg = fg
  self.bg = bg
  self.bordercolor = bordercolor
  self.opacity = opacity
  
  self.value = 0

  self.borderpx = 1
  self.innerwidth = self.width - self.borderpx * 2
  self.innerheight = self.height - self.borderpx * 2
end

function HorizontalBar:createComponents(bridge)
  -- Border
  self.components[1] = bridge.addBox(self.x, self.y, self.width, self.height, self.bordercolor, self.opacity)
  self.components[1].setZIndex(-1)
  -- Background
  self.components[2] = bridge.addBox(self.x + self.borderpx, self.y + self.borderpx, self.innerwidth, self.innerheight, self.bg, self.opacity)
  self.components[2].setZIndex(0)
  -- Foreground
  self.components[3] = bridge.addBox(self.x + self.borderpx, self.y + self.borderpx, self.innerwidth * self.value, self.innerheight, self.fg, self.opacity)
  self.components[3].setZIndex(1)
end

-- Value should be beetween 0.0 and 1.0
function HorizontalBar:setValue(value)
  self.value = value
  self.components[3].setWidth(self.innerwidth * self.value)  
end

function HorizontalBar:setFG(color, opacity)
  self.fg = color
  self.components[3].setColor(color)
  if opacity then
    self.components[3].setOpacity(opacity)
  else
    self.components[3].setOpacity(self.opacity)
  end
end