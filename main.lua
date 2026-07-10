local cloud = require('scene.rooms.cloud')
local bird = require('scene.objects.bird')
local pipe = require('scene.objects.pipe')

if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    World = love.physics.newWorld(0, 2000, false)
    bird:init(World)
    pipe:init(World)

    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()
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
    for _, contact in ipairs(World:getContacts()) do
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
    World:update(dt)
    bird:update(dt)
    pipe:update(dt)
    cloud.updateCloud()

    if checkBirdPipeCollision() then
        love.load()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    love.graphics.draw(cloud.cloud1, cloud.cloud1X, cloud.cloud1Y)
    love.graphics.draw(cloud.cloud2, cloud.cloud2X, cloud.cloud2Y)

    love.graphics.setNewFont(48)
    love.graphics.print(Score, Width / 2, Height / 10)

    bird:draw()
    pipe:draw()
end