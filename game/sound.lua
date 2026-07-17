local sound = {}

function sound:init()
    self.sfx = {}
    local base = "assets/sounds/"

    local function loadIfExists(name, file)
        if love.filesystem.getInfo(base .. file) then
            local ok, src = pcall(love.audio.newSource, base .. file, "static")
            if ok and src then
                self.sfx[name] = src
            end
        end
    end

    loadIfExists("fly", "tick_002.ogg")
    loadIfExists("hit", "jingles_HIT12.ogg")
    loadIfExists("click", "click_001.ogg")
end

function sound:play(name)
    local s = self.sfx[name]
    if not s then return end
    if s:isPlaying() then s:stop() end
    s:play()
end

return sound
