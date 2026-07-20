local lume = require('library.external.lume')
local storage = {}

function storage:loadScore()
    if love.filesystem.getInfo("savedata.txt") then
        local file = love.filesystem.read("savedata.txt")
        local data = lume.deserialize(file)
        return data.highscore
    else
        return 0
    end
end

function storage:saveScore(score)
    local highscore = storage:loadScore()
    if highscore > score then
        return
    end
    local data = {}
    data.highscore = score
    local serialized = lume.serialize(data)
    love.filesystem.write("savedata.txt", serialized)
end

return storage