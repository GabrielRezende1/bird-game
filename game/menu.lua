local menu = {}

function menu:init()
    self.state = "menu"
    self.buttonWidth = 160
    self.buttonHeight = 48
    self.buttonY = love.graphics.getHeight() / 2 + 20
    self.startButtonX = love.graphics.getWidth() / 2 - self.buttonWidth / 2
    self.quitButtonX = love.graphics.getWidth() / 2 - self.buttonWidth / 2
    self.startButtonHover = false
    self.quitButtonHover = false
end

function menu:update(dt)
    if self.state == "menu" then
        if love.keyboard.isDown("space") or love.keyboard.isDown("return") then
            self.state = "play"
        end
        if love.keyboard.isDown("escape") then
            love.event.quit()
        end
    end

    local mouseX, mouseY = love.mouse.getPosition()
    if mouseX >= self.startButtonX and mouseX <= self.startButtonX + self.buttonWidth and
    mouseY >= self.buttonY and mouseY <= self.buttonY + self.buttonHeight then
        self.startButtonHover = true
    elseif mouseX >= self.quitButtonX and mouseX <= self.quitButtonX + self.buttonWidth and
    mouseY >= self.buttonY + 70 and mouseY <= self.buttonY + 70 + self.buttonHeight then
        self.quitButtonHover = true
    else
        self.startButtonHover = false
        self.quitButtonHover = false
    end

    if love.mouse.isDown(1) then
        if mouseX >= self.startButtonX and mouseX <= self.startButtonX + self.buttonWidth and
            mouseY >= self.buttonY and mouseY <= self.buttonY + self.buttonHeight then
            self.state = "play"
        elseif mouseX >= self.quitButtonX and mouseX <= self.quitButtonX + self.buttonWidth and
            mouseY >= self.buttonY + 70 and mouseY <= self.buttonY + 70 + self.buttonHeight then
            love.event.quit()
        end
    end
end

function menu:draw()
    love.graphics.setColor(1, 1, 0, 1)
    love.graphics.setNewFont(48)
    love.graphics.print("Clap Bird", love.graphics.getWidth() / 2 - 110, 80)

    love.graphics.setNewFont(24)
    if self.startButtonHover then
        love.graphics.setColor(0.8, 0.8, 0, 1)
    else
        love.graphics.setColor(1, 1, 0, 1)
    end
    love.graphics.rectangle("fill", self.startButtonX, self.buttonY, self.buttonWidth, self.buttonHeight)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Start", self.startButtonX + 48, self.buttonY + 12)

    if self.quitButtonHover then
        love.graphics.setColor(0.8, 0.8, 0, 1)
    else
        love.graphics.setColor(1, 1, 0, 1)
    end
    love.graphics.rectangle("fill", self.quitButtonX, self.buttonY + 70, self.buttonWidth, self.buttonHeight)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Quit", self.quitButtonX + 54, self.buttonY + 82)
    love.graphics.setColor(1, 1, 1, 1)
end

return menu
