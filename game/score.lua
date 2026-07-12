local score = {}

function score:init()
    self.score = 0
    self.highScore = 0

    self.scoreX = love.graphics.getWidth() / 2
    self.scoreY = love.graphics.getHeight() / 10
    self.highScoreX = 0
    self.highScoreY = 0
end

function score:load(loadFunction)
    self.highScore = loadFunction
end

function score:draw()
    love.graphics.setNewFont(48)
    love.graphics.print(self.score, self.scoreX, self.scoreY)
    love.graphics.setNewFont(24)
    love.graphics.print("Best: " .. self.highScore, self.highScoreX, self.highScoreY)
end

return score