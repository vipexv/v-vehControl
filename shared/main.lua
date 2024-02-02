local currentResourceName = GetCurrentResourceName()

---@param coords vector
---@param text string
---@param sprite number
---@param colour number
---@param scale number
---@param temporaryBlip boolean
---@return number
function AddBlip(coords, text, sprite, colour, scale, temporaryBlip)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(blip, sprite)
  SetBlipColour(blip, colour)
  SetBlipDisplay(blip, 2)
  SetBlipAlpha(blip, 255)
  SetBlipScale(blip, scale)
  SetBlipAsShortRange(blip, false)
  PulseBlip(blip)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
  if temporaryBlip then
    SetTimeout(600 * 1000, function()
      RemoveBlip(blip)
      print(("(DEBUG) Blip removed after 600 seconds since the temporaryBlip boolean was set to true once the AddBlip function was called."))
    end)
  end
  return blip
end

function Debug(...)
  if not Config.Debug then return end

  local args <const> = { ... }

  local appendStr = ''
  for _, v in ipairs(args) do
    appendStr = appendStr .. ' ' .. tostring(v)
  end
  local msgTemplate = '^3[%s]^0%s'
  local finalMsg = msgTemplate:format(currentResourceName, appendStr)
  print(finalMsg)
end
