local collision = {}

function collision:_bodyHasFixture(body, targetFixture)
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

function collision:checkBirdCollision(world, bird, pipe)
    -- Check pipe collision
    for _, contact in ipairs(world:getContacts()) do
        local fixtureA, fixtureB = contact:getFixtures()
        if fixtureA and fixtureB then
            local isBirdContact = (fixtureA == bird.fixture or fixtureB == bird.fixture)
            if isBirdContact then
                for _, pair in ipairs(pipe.pairs) do
                    if collision:_bodyHasFixture(pair.topBody, fixtureA) or collision:_bodyHasFixture(pair.topBody, fixtureB) then
                        return true
                    end

                    if collision:_bodyHasFixture(pair.bottomBody, fixtureA) or collision:_bodyHasFixture(pair.bottomBody, fixtureB) then
                        return true
                    end
                end
            end
        end
    end
    -- Check border collision
    local _, y = bird.body:getPosition()
    local radius = bird.shape:getRadius()
    if y + radius > love.graphics.getHeight() or y - radius < 0 then
        return true
    end

    return false
end

return collision