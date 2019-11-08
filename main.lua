local tiled = require("com.ponywolf.ponytiled")
local json = require("json")
local filename = "maps/level01.json"
local physics = require("physics")
local player

physics.start()
physics.setGravity(0, 32)

local mapData = json.decodeFile(system.pathForFile(filename, system.ResourceDirectory))
local map = tiled.new(mapData, "maps")

map.extensions = "lib."
map:extend("player")
player = map:findObject("player")

-- map.xScale = 0.75
-- map.yScale = 0.75

--map.x, map.y = display.contentCenterX - map.designedWidth / 2, display.contentCenterY - map.designedHeight / 2

-- local camera_time = 0

local function enterFrame(event)
    -- -- move camera zoom every 5 seconds
    -- time = math.floor(event.time / 2000)
    -- if (time ~= camera_time) then
    --     camera_time = time

    -- end

    -- move map
    local x, y = player:localToContent(0, 0)
    x, y = display.contentCenterX - x, display.contentCenterY - y
    map.x, map.y = math.min(map.x + x, -48), map.y + y

    -- print("map.x", map.x)
end
Runtime:addEventListener("enterFrame", enterFrame)

local function zoomCamera()
    local speed = math.max(player:getLinearVelocity())
    local scale = (-.0005 * speed) + 1
    print("tick", speed, scale)
    -- map.xScale, map.yScale = scale, scale

    transition.to(
        map,
        {
            xScale = scale,
            yScale = scale,
            time = 5000,
            transition = easing.outBack,
            onComplete = zoomCamera
        }
    )
end

zoomCamera()

-- function player:collision(event)
--     print("collide")
-- end
-- player:addEventListener("collision")
