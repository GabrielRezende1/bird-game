local cloud = {}

function cloud:init(world)
    self.world = world
    self.sprite = love.graphics.newImage("assets/sprites/cloud.png")
    self.quads = {
        love.graphics.newQuad(0, 0, 32, 16, self.sprite:getWidth(), self.sprite:getHeight()),
        love.graphics.newQuad(0, 16, 32, 16, self.sprite:getWidth(), self.sprite:getHeight())
    }

    self.clouds = {}
    self.spawnTimer = 0
    self.spawnInterval = 2.5
    self.speed = 40
end

function cloud:_spawnCloud()
    local x = love.graphics.getWidth() + 32
    local y = math.random(20, 120)
    local cloudType = math.random(1, 2)

    local body = love.physics.newBody(self.world, x, y, "kinematic")
    body:setFixedRotation(true)
    body:setGravityScale(0)
    body:setLinearVelocity(-self.speed, 0)

    local shape = love.physics.newRectangleShape(32, 16)
    love.physics.newFixture(body, shape, 1)

    table.insert(self.clouds, {
        body = body,
        cloudType = cloudType
    })
end

function cloud:update(dt)
    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer >= self.spawnInterval then
        self:_spawnCloud()
        self.spawnTimer = 0
    end

    for i = #self.clouds, 1, -1 do
        local cloud = self.clouds[i]
        local x = cloud.body:getX()
        if x + 32 < -50 then
            cloud.body:destroy()
            table.remove(self.clouds, i)
        end
    end
end

function cloud:draw()
    for _, cloud in ipairs(self.clouds) do
        local x, y = cloud.body:getPosition()
        love.graphics.draw(self.sprite, self.quads[cloud.cloudType], x, y, 0, 1, 1, 0, 0)
    end
end

return cloud
