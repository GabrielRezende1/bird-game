local bird = {}

function bird:init(world, x, y)
    self.sprite = love.graphics.newImage("assets/sprites/bird.png")
    self.x = x or 25
    self.y = y or love.graphics.getHeight() / 2

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)

    self.body:setFixedRotation(true)
    self.body:setGravityScale(1)

    self.quads = {
        love.graphics.newQuad(0, 0, 16, 16, self.sprite:getWidth(), self.sprite:getHeight()),
        love.graphics.newQuad(16, 0, 16, 16, self.sprite:getWidth(), self.sprite:getHeight())
    }

    self.frame = 1
    self.flapTimer = 0
    self.flapDuration = 0.15
    self.wasPressed = false
    self.maxTilt = math.rad(35)
    self.tilt = 0
    self.tiltSpeed = 6
end

function bird:update(dt)
    local height = love.graphics.getHeight()
    local spaceDown = love.keyboard.isDown("space")
    local m1 = love.mouse.isDown(1)

    if (spaceDown or m1) and not self.wasPressed then
        self.frame = 2
        self.flapTimer = self.flapDuration
        self.body:setLinearVelocity(0, 0)
        self.body:applyLinearImpulse(0, -100)
    end

    if self.flapTimer > 0 then
        self.flapTimer = self.flapTimer - dt
        if self.flapTimer <= 0 then
            self.frame = 1
        end
    end

    self.wasPressed = spaceDown or m1

    local _, vy = self.body:getLinearVelocity()
    local targetTilt = 0

    if vy < -20 then
        targetTilt = -self.maxTilt
    elseif vy > 20 then
        targetTilt = self.maxTilt
    end

    self.tilt = self.tilt + (targetTilt - self.tilt) * math.min(dt * self.tiltSpeed, 1)

    local x, y = self.body:getPosition()
    if y + 16 > height then
        self.body:setPosition(x, height / 2)
        self.body:setLinearVelocity(0, 0)
        love.load()
    elseif y - 16 < 0 then
        self.body:setPosition(x, height / 2)
        self.body:setLinearVelocity(0, 0)
        love.load()
    end
end

function bird:draw()
    local x, y = self.body:getPosition()
    love.graphics.draw(self.sprite, self.quads[self.frame], x, y, self.tilt, 1, 1, 8, 8)
end

return bird