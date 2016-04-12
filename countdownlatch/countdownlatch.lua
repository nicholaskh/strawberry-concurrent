local CountdownLatch = {}

CountdownLatch.__index = CountdownLatch

function CountdownLatch:new(name, value, driver_type, connection)
    local driver = driver_factory:factory(driver_type, connection, name, value)
    return setmetatable({
        name = name,
        value = value,
        driver = driver,
    }, CountdownLatch)
end

-- TODO add local cache
function CountdownLatch:countdown()
    return self.driver:countdown(self.name)
end

return CountdownLatch
