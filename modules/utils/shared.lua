local utility = {}

---@param ... any
function utility.Debug(...)
    if not Config.Debug then return end

    local args <const> = { ... }
    local append = ""

    for _, v in ipairs(args) do
        append = append .. " " .. tostring(v)
    end

    local template = "^3[%s]^0%s"
    local message = template:format(GetCurrentResourceName(), append)
    print(message)
end

return utility
