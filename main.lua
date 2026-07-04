local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
require('scene.objects.pipe')

if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    World = love.physics.newWorld(0, 1000, false)
    bird:init(World, 25, love.graphics.getHeight() / 2)

    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()
    Score = 0
end

function love.update(dt)
    World:update(dt)
    bird:update(dt)
    cloud.updateCloud(dt)

    if love.keyboard.isDown("r") or love.keyboard.isDown("escape") then
        -- TODO Return to main menu
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    love.graphics.draw(cloud.cloud1, cloud.cloud1X, cloud.cloud1Y)
    love.graphics.draw(cloud.cloud2, cloud.cloud2X, cloud.cloud2Y)

    love.graphics.setNewFont(48)
    love.graphics.print(Score, Width / 2, Height / 10)

    bird:draw()
end