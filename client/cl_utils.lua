---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function UIMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

function ToggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    UIMessage('setVisible', shouldShow)
    Debug("(func) [ToggleNuiFrame] \n (param) shouldShow: ", shouldShow)
end

---@param coords vector3
---@return boolean
---@return table
function Get2DCoordFrom3DCoord(coords)
    if not coords then return false, {} end
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    return onScreen, { left = tostring(x * 100) .. "%", top = tostring(y * 100) .. "%" }
end

function ShowFloatingText(coords, msg)
    AddTextEntry('floatingTextNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('floatingTextNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end
