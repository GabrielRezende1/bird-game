local bird = {}

function bird:init(world, x, y)
    -- Bird image
    self.image = love.graphics.newImage("assets/sprites/bird.png")
    -- Bird position
    self.x = x or 25
    self.y = y or love.graphics.getHeight() / 2
    -- Bird creation in the world
    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newRectangleShape(17, 12)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    -- Bird initial set
    self.body.setMass(self.body, 10)
    self.shape.computeMass(self.shape, 1)
end

function bird:update(dt)
    local height = love.graphics.getHeight()
    -- Limit bird position on the screen
    if self.y + 16 > height then
        self.y = height / 2
    elseif self.y - 16 < 0 then
        self.y = height / 2
    end
    -- Move bird (fly)
    love.keyboard.setKeyRepeat(false)
    if love.keyboard.isDown("space") then
        self.y = self.y - 10
    end
end

function bird:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return bird