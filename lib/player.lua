-- Define module
local M = {}

function M.new(instance, options)
    physics.addBody(
        instance,
        "dynamic",
        {
            radius = 15.7,
            density = 3,
            bounce = .5,
            friction = 1
        }
    )

    instance.isFixedRotation = false
    instance.angularDamping = 20

    local max, left, right = 1000, 0, 0

    local function keyDown(event)
        print("player keyDown event.keyName", event.keyName)

        if (event.phase == "down") then
            -- right
            if (event.keyName == "d") then
                -- instance:applyLinearImpulse(20, 0, instance.x, instance.y)
                left = 150
            -- instance:applyForce(250, 0, instance.x, instance.y)
            end

            -- right
            if (event.keyName == "a") then
                -- instance:applyLinearImpulse(-20, 0, instance.x, instance.y)
                right = -150
            end

            -- jump
            if (event.keyName == "w") then
                instance:applyLinearImpulse(0, -50, instance.x, instance.y)
            end

            -- big
            if (event.keyName == "space") then
                -- instance:applyLinearImpulse(-20, 0, instance.x, instance.y)
                instance.xScale = 2 
                instance.yScale = 2 
            end
        elseif (event.phase == "up") then
            left = 0
            right = 0
        end
    end

    Runtime:addEventListener("key", keyDown)

    local function enterFrame()
        -- Do this every frame
        local vx, vy = instance:getLinearVelocity()
        local dx = left + right
        
        if (dx < 0 and vx > -max) or (dx > 0 and vx < max) then
            instance:applyForce(dx or 0, 0, instance.x, instance.y)
        end
    end

    Runtime:addEventListener("enterFrame", enterFrame)

    return instance
end

return M
