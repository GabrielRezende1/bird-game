local storage = require('game.storage')
local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
local pipe = require('scene.objects.pipe')

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

local function bodyHasFixture(body, targetFixture)
    local fixtures = body:getFixtures()
    if fixtures and type(fixtures) ~= "table" then
        fixtures = {fixtures}
    end

    if fixtures then
        for _, fixture in ipairs(fixtures) do
            if fixture == targetFixture then
                return true
            end
        end
    end

    return false
end

local function checkBirdPipeCollision()
    for _, contact in ipairs(world:getContacts()) do
        local fixtureA, fixtureB = contact:getFixtures()
        if fixtureA and fixtureB then
            local isBirdContact = (fixtureA == bird.fixture or fixtureB == bird.fixture)
            if isBirdContact then
                for _, pair in ipairs(pipe.pairs) do
                    if bodyHasFixture(pair.topBody, fixtureA) or bodyHasFixture(pair.topBody, fixtureB) then
                        return true
                    end

                    if bodyHasFixture(pair.bottomBody, fixtureA) or bodyHasFixture(pair.bottomBody, fixtureB) then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function love.update(dt)
    world:update(dt)
    bird:update(dt)
    pipe:update(dt)
    cloud.updateCloud()

    if checkBirdPipeCollision() then
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