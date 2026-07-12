local pipe = {}

function pipe:init(world)
    self.world = world
    self.sprite = love.graphics.newImage("assets/sprites/pipe.png")
    self.bodyQuad = love.graphics.newQuad(0, 0, 16, 16, self.sprite:getWidth(), self.sprite:getHeight())
    self.headQuad = love.graphics.newQuad(0, 16, 16, 16, self.sprite:getWidth(), self.sprite:getHeight())

    self.pairs = {}
    self.spawnTimer = 0
    self.spawnInterval = 1.4
    self.speed = 180
    self.gapHeight = 96
    self.pipeWidth = 16
end

function pipe:_createColumn(x, y, height)
    local body = love.physics.newBody(self.world, x, y, "kinematic")
    body:setFixedRotation(true)
    body:setGravityScale(0)
    body:setLinearVelocity(-self.speed, 0)

    local shape = love.physics.newRectangleShape(16, height)
    love.physics.newFixture(body, shape, 1)

    return body
end

function pipe:_spawnPair()
    local x = love.graphics.getWidth() + self.pipeWidth
    local minGapY = 64
    local maxGapY = love.graphics.getHeight() - self.gapHeight - minGapY
    local gapY = math.random(minGapY / 16, maxGapY / 16) * 16

    local topHeight = gapY
    local bottomHeight = love.graphics.getHeight() - (gapY + self.gapHeight)

    local topBody = self:_createColumn(x, topHeight / 2, topHeight)
    local bottomBody = self:_createColumn(x, gapY + self.gapHeight + bottomHeight / 2, bottomHeight)

    table.insert(self.pairs, {
        x = x,
        gapY = gapY,
        gapHeight = self.gapHeight,
        topBody = topBody,
        bottomBody = bottomBody,
        scored = false,
    })
end

function pipe:update(dt, score)
    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer >= self.spawnInterval then
        self:_spawnPair()
        self.spawnTimer = 0
    end

    for i = #self.pairs, 1, -1 do
        local pair = self.pairs[i]
        local x = pair.topBody:getX()
        -- Bird X position is being hard coded
        if not pair.scored and x + self.pipeWidth < 25 then
            pair.scored = true
            score.score = score.score + 1
        end

        if x + self.pipeWidth < -20 then
            pair.topBody:destroy()
            pair.bottomBody:destroy()
            table.remove(self.pairs, i)
        end
    end
end

function pipe:draw()
    for _, pair in ipairs(self.pairs) do
        local x, _ = pair.topBody:getPosition()
        local topHeight = pair.gapY
        local topHeadY = topHeight - 8
        local bottomHeadY = pair.gapY + pair.gapHeight
        local screenH = love.graphics.getHeight()

        for y = 8, topHeight - 24, 16 do
            love.graphics.draw(self.sprite, self.bodyQuad, x, y, 0, 1, 1, 8, 8)
        end
        love.graphics.draw(self.sprite, self.headQuad, x, topHeadY, 0, 1, 1, 8, 8)

        for y = bottomHeadY + 16, screenH - 8, 16 do
            love.graphics.draw(self.sprite, self.bodyQuad, x, y, math.pi, 1, 1, 8, 8)
        end
        love.graphics.draw(self.sprite, self.headQuad, x, bottomHeadY, math.pi, 1, 1, 8, 8)
    end
end

return pipe

