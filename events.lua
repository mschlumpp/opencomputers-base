local event = require("event")

while true do
  p1, p2, p3, p4, p5 = event.pull()
  print(tostring(p1) .. ":" .. tostring(p2) .. ":" .. tostring(p3) .. ":" .. tostring(p4) .. ":" .. tostring(p5))
end

