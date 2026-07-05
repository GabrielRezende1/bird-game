local bird = {}

function bird:init(world, x, y)
    self.image = love.graphics.newImage("assets/sprites/bird.png")
    self.x = x or 25
    self.y = y or love.graphics.getHeight() / 2

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newRectangleShape(17, 12)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)

    self.body:setFixedRotation(true)
    self.body:setGravityScale(1)
    self.wasSpaceDown = false
end

function bird:update(dt)
    local height = love.graphics.getHeight()
    local spaceDown = love.keyboard.isDown("space")

    if spaceDown and not self.wasSpaceDown then
        self.body:setLinearVelocity(0, 0)
        self.body:applyLinearImpulse(0, -100)
    end

    self.wasSpaceDown = spaceDown

    local x, y = self.body:getPosition()
    if y + 16 > height then
        self.body:setPosition(x, height / 2)
        self.body:setLinearVelocity(0, 0)
    elseif y - 16 < 0 then
        self.body:setPosition(x, height / 2)
        self.body:setLinearVelocity(0, 0)
    end
end

function bird:draw()
    local x, y = self.body:getPosition()
    love.graphics.draw(self.image, x, y)
end

return bird