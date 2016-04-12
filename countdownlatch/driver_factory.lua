local DriverFactory = {}

function DriverFactory:factory(driver_type, connection, name, value)
    if driver_type == "redis" then
        local redis_driver = require "framework.concurrent.countdownlatch.driver.redis"
        return redis_driver:new(connection, name, value)
    end
end

return DriverFactory
