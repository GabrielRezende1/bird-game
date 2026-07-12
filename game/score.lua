local score = {}

function score:init()
    self.score = 0
    self.highScore = 0

    self.scoreX = love.graphics.getWidth() / 2
    self.scoreY = love.graphics.getHeight() / 10
    self.highScoreX = self.scoreX - 120
    self.highScoreY = love.graphics.getHeight() - 56
end

function score:load(loadFunction)
    self.highScore = loadFunction
end

function score:draw(menuState)
    love.graphics.setNewFont(36)
    love.graphics.setColor(0, 0, 0, 1)
    if menuState == "menu" then
        love.graphics.print("Highscore: " .. self.highScore, self.highScoreX, self.highScoreY)
        return
    end
    love.graphics.print(self.score, self.scoreX, self.scoreY)
    love.graphics.setNewFont(24)
    love.graphics.print("Best: " .. self.highScore, 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

end

return score