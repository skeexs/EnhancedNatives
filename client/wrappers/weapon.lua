---@class Weapon
---@field public getHash fun(): number
---@field public getClipSize fun(): number | integer
---@field public weaponHash string
---@field public ammo number | integer
---@field public clipSize? number | integer
---@field public components table<string, boolean>
---@field public tint? number | integer

---@param hash number | integer
---@return Weapon
function Weapon(hash)
    local self = setmetatable({}, {
        __index = Weapon,
        __tostring = function()
            return "Weapon"
        end
    })

    self.weaponHash = hash
    self.ammo = 0
    self.clipSize = 0
    self.components = {}
    self.tint = 0

    function self.getHash()
        return self.weaponHash
    end

    function self.getClipSize()
        return self.clipSize
    end

    function self.getAmmo()
        return self.ammo
    end

    return self
end
