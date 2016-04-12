local lrucache = require "resty.lrucache"
local cache = lrucache.new(1)
cache:set("closed", false)

local CountdownLatch = {}

CountdownLatch.__index = CountdownLatch

function CountdownLatch:new(name, value, driver_type, connection)
    local DriverFactory = require "framework.concurrent.countdownlatch.driver_factory"
    local driver = DriverFactory:factory(driver_type, connection, name, value)
    return setmetatable({
        name = name,
        value = value,
        driver = driver,
    }, CountdownLatch)
end

function CountdownLatch:countdown()
    if cache:get("closed") then
        return false
    end
    local succ = self.driver:countdown(self.name)
    if not succ then
        cache:set("closed", true)
    end
    return succ
end

return CountdownLatch
