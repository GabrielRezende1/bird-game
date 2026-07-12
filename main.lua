local storage = require('game.storage')
local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
local pipe = require('scene.objects.pipe')
local collision = require('game.collision')
local menu = require('game.menu')

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
    cloud:init(world)
    menu:init()
    Score = 0
end

function love.update(dt)
    if menu.state == "menu" then
        menu:update(dt)
        return
    end

    world:update(dt)
    bird:update(dt)
    pipe:update(dt)
    cloud:update(dt)

    if collision:checkBirdPipeCollision(world, bird, pipe) then
        storage:saveScore(Score)
        menu.state = "menu"
        love.load()
    end
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    love.graphics.setBackgroundColor(0.5, 0.5, 1)

    love.graphics.setNewFont(48)
    love.graphics.print(Score, width / 2, height / 10)
    love.graphics.setNewFont(24)
    love.graphics.print("Best: " .. highscore, 0, 0)

    if menu.state == "menu" then
        menu:draw()
        return
    end

    cloud:draw()
    bird:draw()
    pipe:draw()
end