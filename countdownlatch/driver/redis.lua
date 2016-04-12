local RedisDriver = {}

RedisDriver.__index = RedisDriver

function RedisDriver:new(connection, name, value)
    local obj = setmetatable({
        connection = connection,
    }, RedisDriver)

    obj:init(name, value)

    return obj
end

function RedisDriver:init(name, value)
    self.connection:query("set", name, value)
end

function RedisDriver:countdown(name)
    local ret = self.connection:query({"decr", name})
    if ret <= 0 then
        return false
    end
    return true
end

return RedisDriver
