local storage = require('game.storage')
local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
local pipe = require('scene.objects.pipe')
local collision = require('game.collision')

if arg[2] == "debug" then
    require("lldebugger").start()
end

local world = love.physics.newWorld(0, 2000, false)
local highscore = 0

function love.load()
    highscore = storage:loadScore()
    world = love.physics.newWorld(0, 2000, false)
    bird:init(world)
    pipe:init(world)
    Score = 0
end

function love.update(dt)
    world:update(dt)
    bird:update(dt)
    pipe:update(dt)
    cloud.updateCloud()

    if collision:checkBirdPipeCollision(world, bird, pipe) then
        storage:saveScore(Score)
        love.load()
    end
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    love.graphics.draw(cloud.cloud1, cloud.cloud1X, cloud.cloud1Y)
    love.graphics.draw(cloud.cloud2, cloud.cloud2X, cloud.cloud2Y)

    love.graphics.setNewFont(48)
    love.graphics.print(Score, width / 2, height / 10)
    love.graphics.setNewFont(24)
    love.graphics.print("Best: " .. highscore, 0, 0)

    bird:draw()
    pipe:draw()
end