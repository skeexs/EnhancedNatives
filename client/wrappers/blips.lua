---
--- Created by Administratör.
--- DateTime: 2025-01-01 00:33
---

---@alias Blip {handle: integer, sprite: number|nil}

---@class Blip
---@field handle integer
---@field sprite number
---@field color number
---@field alpha number
---@field scale number
---@field setSprite fun(sprite: number): void
---@field setColour fun(colour: number): void
---@field setAlpha fun(alpha: number): void
---@field setScale fun(scale: number): void
function Blip(handle)
    local self = setmetatable({}, Blip)

    self.handle = handle
    self.sprite = nil
    self.color = nil
    self.alpha = nil
    self.scale = nil

    function self.setSprite(sprite)
        SetBlipSprite(self.handle, sprite)
        self.sprite = sprite
    end

    function self.setColour(colour)
        SetBlipColour(self.handle, colour)
        self.color = colour
    end

    function self.setAlpha(alpha)
        SetBlipAlpha(self.handle, alpha)
        self.alpha = alpha
    end

    function self.setScale(scale)
        SetBlipScale(self.handle, scale)
        self.scale = scale
    end

    function self.remove()
        RemoveBlip(self.handle)
    end

    return self
end

_AddBlipForEntity = AddBlipForEntity
AddBlipForEntity = function(entity)
    local blip = _AddBlipForEntity(entity) --[[@as integer]]

    return Blip(blip)
end
