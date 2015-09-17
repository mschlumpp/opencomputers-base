function wrapText(str, limit)
  local out = {}
  local line = ""
  local lastword = ""
  local column = 0
  limit = math.floor(limit)
  for i = 1, #str do
    local c = str:sub(i,i)
    if c == " " then
      if column > limit then
        table.insert(out, line)
        line = lastword
        column = 0
        lastword = " "
      else
        line = line .. lastword .. " "
        lastword = ""
      end
    else
      lastword = lastword .. c
      column = column + 1
    end
  end
  line = line .. lastword
  table.insert(out, line)
  return out
end

function strBool(b)
  if b then
    return "yes"
  else
    return "no"
  end
end

function textWidthScale(bridge, text, scale)
  return bridge.getStringWidth(text) * scale
end

function round(number, idp)
    local mult = 10^(idp or 1)
    return math.floor(number * mult + 0.5) / mult
end

function shortenNumber(number, pl)
    local n = tonumber(number)
    if not pl then
      pl = 1
    end
    if n > math.pow(10, 6) then
      n = round(n / math.pow(10, 6), pl)
      return string.format("%." .. tostring(pl) .. "fM", n)
    elseif n > math.pow(10, 3) then
       n = round(n / math.pow(10, 3), pl)
       return string.format("%." .. tostring(pl) .. "fk", n)
    end
    return tostring(round(n, 1))
end
