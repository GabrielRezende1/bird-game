local storage = require('game.storage')
local score = require('game.score')
local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
local pipe = require('scene.objects.pipe')
local collision = require('game.collision')
local menu = require('game.menu')

if arg[2] == "debug" then
    require("lldebugger").start()
end

local world = love.physics.newWorld(0, 2000, false)

function love.load()
    world = love.physics.newWorld(0, 2000, false)
    score:init()
    score:load(storage:loadScore())
    bird:init(world)
    pipe:init(world)
    cloud:init(world)
    menu:init()
end

function love.update(dt)
    if menu.state == "menu" then
        menu:update(dt)
        return
    end

    world:update(dt)
    bird:update(dt)
    pipe:update(dt, score)
    cloud:update(dt)

    if collision:checkBirdPipeCollision(world, bird, pipe) then
        storage:saveScore(score.score)
        menu.state = "menu"
        love.load()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)

    if menu.state == "menu" then
        menu:draw()
        return
    end

    score:draw()
    cloud:draw()
    bird:draw()
    pipe:draw()
end