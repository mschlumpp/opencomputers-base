Label = Widget:subclass("Label")

function Label:initialize(name, x, y, text, color)
  Widget.initialize(self, name, x, y, 0, 0)
  self.text = text
  self.color = color
  self.scale = 1
end

function Label:createComponents(bridge)
  self.components[1] = bridge.addText(self.x, self.y, self.text, self.color)
end

function Label:setText(text)
  self.text = text
  self.components[1].setText(self.text)
end

function Label:setColor(color)
  self.color = color
  self.components[1].setColor(self.color)
end

function Label:setTextScale(scale)
  self.scale = scale
  self.components[1].setScale(scale)
end

function Label:setObjectAnchor(horizontal, vertical)
   self.components[1].setObjectAnchor(horizontal, vertical)
end
