Widget = class("Widget")

function Widget:initialize(name, x, y, width, height)
  self.name = name
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.components = {}
end

function Widget:getSize()
  return self.width, self.height
end

function Widget:createComponents(bridge)

end

function Widget:setPosition(x, y)
  local xdiff = x - self.x
  local ydiff = y - self.y

  for i,v in ipairs(self.components) do
    local nx = v.getX() + xdiff
    local ny = v.getY() + ydiff
    v.setX(nx)
    v.setY(ny)
  end

  self.x = x
  self.y = y
end

function Widget:INTERNALdestroyComponents()
  for i,v in ipairs(self.components) do
    v.delete()
  end
  self.components = {}
end
