local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
require('scene.objects.pipe')

if arg[2] == "debug" then
    require("lldebugger").start()
end
-- Load game window
function love.load()
    -- Create world and objects
    World = love.physics.newWorld(0, 10, false)
    WorldTime = 0
    bird:init(World, 25, love.graphics.getHeight() / 2)
    -- Set initial values
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()
    Score = 0
end
-- Update game
function love.update(dt)
    -- Move background
    WorldTime = WorldTime + dt
    World.update(World, WorldTime)
    bird:update(dt)
    cloud.updateCloud()

    if love.keyboard.isDown("r") or love.keyboard.isDown("escape") then
        -- TODO Return to main menu
    end
end
-- Draw objects, background
function love.draw()
    -- Background
    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    love.graphics.draw(cloud.cloud1, cloud.cloud1X, cloud.cloud1Y)
    love.graphics.draw(cloud.cloud2, cloud.cloud2X, cloud.cloud2Y)
    -- Set score
    love.graphics.setNewFont(48)
    love.graphics.print(Score, Width / 2, Height / 10)
    -- Set bird
    bird:draw()

end