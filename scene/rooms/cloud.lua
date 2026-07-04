local c = {}

c.cloud1 = love.graphics.newImage("assets/sprites/cloud1.png")
c.cloud2 = love.graphics.newImage("assets/sprites/cloud2.png")

c.cloud1X = love.graphics.getWidth()
c.cloud1Y = love.graphics.getHeight() / 10
c.cloud2X = love.graphics.getWidth()
c.cloud2Y = love.graphics.getHeight() / 10

c.cloudMove = true
c.cloud1Tick = 0
c.cloud2Tick = 0
c.cloud2Interval = 0

function c.updateCloud()
    --Cloud1
    if c.cloud1Tick < 100 then
        c.cloud1Tick = c.cloud1Tick + 1
        if c.cloud2Interval <= 1000 then
            c.cloud2Interval = c.cloud2Interval + 1
        end
    else
        c.cloud1Tick = 0
        c.cloud1X = c.cloud1X - 10
        if c.cloudMove then
            c.cloud1Y = c.cloud1Y - 5
            c.cloud2Y = c.cloud2Y - 5
            c.cloudMove = false
        else
            c.cloud1Y = c.cloud1Y + 5
            c.cloud2Y = c.cloud2Y + 5
            c.cloudMove = true
        end
    end
    --Cloud2
    -- TODO something wrong here
    if c.cloud2Tick < 100 then
        c.cloud2Tick = c.cloud2Tick + 1
        if c.cloud2Interval > 1000 then
            c.cloud2Tick = 0
            c.cloud2X = c.cloud2X - 10
        end
    end
end

return c
