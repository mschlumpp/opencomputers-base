local component = require("component")

HUD = class("HUD")

function HUD:initialize(address)
  self.bridge = component[address]
  self.bridge.clear()
  self.widgets = {}
end

function HUD:addWidget(widget)
  if not instanceOf(Widget, widget) then
    print("HUD:addWidget: widget is not a Widget")
    return "Just nope"
  end
  widget:createComponents(self.bridge)
  self.widgets[widget.name] = widget
end

function HUD:removeWidget(name)
  local w = self.widgets[name]
  w:INTERNALdestroyComponents()
  self.widgets[name] = nil
end

function HUD:sync()
   self.bridge.sync()
end
