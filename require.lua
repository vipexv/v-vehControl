-- I really don't like doing this, but this logic is originally from the ox_lib resource, all i did was migrate this to my resource template to utilize in my future projects.

---@diagnostic disable: lowercase-global
local loaded = {}
Class = {}

package = {
    loaded = setmetatable({}, {
        __index = loaded,
        __metatable = false,
    }),
    path = './?.lua;'
}

cache = {
    resource = GetCurrentResourceName()
}

local _require = require

---@param filePath string
---@param env? table
---@return any
function Class.load(filePath, env)
    local modpath = filePath:gsub('%.', '/')
    local resourceSrc = cache.resource

    for path in package.path:gmatch('[^;]+') do
        local scriptPath = path:gsub('?', modpath):gsub('%.+%/+', '')
        local resourceFile = LoadResourceFile(resourceSrc, scriptPath)

        if resourceFile then
            local chunk, err = load(resourceFile, ('@@%s/%s'):format(resourceSrc, scriptPath), 't', env or _ENV)

            if not chunk or err then
                error(err or 'an unknown error occurred', 2)
            end

            return chunk()
        end
    end

    error(('cannot load file at path %s'):format(modpath))
end

function Class.loadJson(filePath)
    local modpath = filePath:gsub('%.', '/')
    local resourceSrc = cache.resource
    local scriptPath = ('%s.json'):format(modpath)
    local resourceFile = LoadResourceFile(resourceSrc, scriptPath)

    if resourceFile then
        return json.decode(resourceFile)
    end

    error(('cannot load json file at path %s'):format(modpath))
end

function Class.require(modname)
    if type(modname) ~= 'string' then return end

    local modpath = modname:gsub('%.', '/')
    local module = loaded[modname]

    if module then return module end

    local success, result = pcall(_require, modname)

    if success then
        loaded[modname] = result
        return result
    end

    local resourceSrc = cache.resource

    if not modpath:find('^@') then
        modname = ('@%s.%s'):format(resourceSrc, modname)
    end

    if not module then
        if module == false then
            error(("^1circular-dependency occurred when loading module '%s'^0"):format(modname), 2)
        end

        if not resourceSrc then
            resourceSrc = modpath:gsub('^@(.-)/.+', '%1')
            modpath = modpath:sub(#resourceSrc + 3)
        end

        for path in package.path:gmatch('[^;]+') do
            local scriptPath = path:gsub('?', modpath):gsub('%.+%/+', '')
            local resourceFile = LoadResourceFile(resourceSrc, scriptPath)

            if resourceFile then
                loaded[modname] = false
                scriptPath = ('@@%s/%s'):format(resourceSrc, scriptPath)

                local chunk, err = load(resourceFile, scriptPath)

                if err or not chunk then
                    loaded[modname] = nil
                    return error(err or ("unable to load module '%s'"):format(modname), 3)
                end

                module = chunk(modname) or true
                loaded[modname] = module

                return module
            end
        end

        return error(result, 2)
    end

    return module
end

require = Class.require
