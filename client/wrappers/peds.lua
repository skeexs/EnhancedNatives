--- @alias animData {blendIn: number, blendOut: number, duration: number, flag: number, playbackRate: number, lockX: boolean, lockY: boolean, lockZ: boolean }

---@alias PedSkills "SHOOTING_ABILITY" | "FLYING_ABILITY" | "WHEELIE_ABILITY" | "STAMINA" | "STRENGTH" | "STEALTH_ABILITY" | "LUNG_CAPACITY" | "KILLS_PLAYERS"
---@alias vector3 vector3
---@alias vector4 vector4

---@class Ped
---@field handle number
---@field skills table<string, number>
---@field blip Blip | nil
---@field animationPlaying {dict: string, anim: string} | nil
---@field getCoordsWithHeading fun(): vector4
---@field getCoords fun(): vector3
---@field getHeading fun(): number
---@field getClosestVehicle fun(): Vehicle
---@field isInVehicle fun(): boolean
---@field setSkill fun(skill: string, value: number): boolean | nil
---@field getSkills fun(): table<string, number>
---@field getVehicle fun(): Vehicle
---@field setIntoVehicle fun(vehicle: Vehicle, seat: number): any
---@field setCoords fun(coords: vector3): any
---@field setHeading fun(heading: number): any
---@field addBlip fun(): Blip
---@field removeBlip fun(): any
---@field getAttachedEntity fun(): any
---@field isCollissionEnabled fun(): any
---@field getMaxHealth fun(): any
---@field placeOnGround fun(): any
---@field clearTasks fun(): any
---@field clearTasksImmediately fun(): any
---@field getBlip fun(): Blip | nil
---@field setInvincible fun(toggle: boolean): any
---@field setHealth fun(health: number): any
---@field godMode fun(toggle: boolean): any
---@field playAnimation fun(dict: string, anim: string, animData: animData): any
---@field playScenario fun(scenario: string): any
---@field setArmour fun(armour: number): any
---@field isAnimationPlaying fun(armour: number): any
---@field getSelectedWeapon fun(): any
---@field giveWeapon fun(weaponHash: string|number, ammo: number): boolean | nil
---@field isInjured fun(): boolean
---@field isDead fun(): boolean
---@field freeze fun(toggle: boolean): any
---@field kill fun(): any
---@field injure fun(): any
---@field revive fun(): any

---@param handle number
---@return Ped
function Ped(handle)
    local self = setmetatable({}, { __index = Ped })

    self.handle = handle
    self.animationPlaying = nil
    self.blip = nil --[[@as Blip | nil]]
    self.skills = {
        [Abilities.SHOOTING_ABILITY] = 0,
        [Abilities.FLYING_ABILITY] = 0,
        [Abilities.WHEELIE_ABILITY] = 0,
        [Abilities.STAMINA] = 0,
        [Abilities.STRENGTH] = 0,
        [Abilities.STEALTH_ABILITY] = 0,
        [Abilities.LUNG_CAPACITY] = 0,
        [Abilities.KILLS_PLAYERS] = 0
    }

    assert(self.handle, "Ped is not valid")

    function self.getCoordsWithHeading()
        local coords = GetEntityCoords(self.handle, false)
        local heading = GetEntityHeading(self.handle)

        return vector4(coords.x, coords.y, coords.z, heading)
    end

    ---@param skill string
    ---@param value number
    ---@return boolean
    function self.setSkill(skill, value)
        if not self.skills[skill] then
            debugPrint("Skill does not exist")
            return nil
        end

        self.skills[skill] = value

        StatSetInt(skill, value, true)

        return true
    end

    ---@param toggle boolean
    ---@return any
    function self.godMode(toggle)
        SetEntityInvincible(self.handle, toggle)
        TaskSetBlockingOfNonTemporaryEvents(self.handle, toggle)
        SetBlockingOfNonTemporaryEvents(self.handle, toggle)
    end

    function self.getSkills()
        return self.skills
    end

    function self.getCoords()
        local coords = GetEntityCoords(self.handle, false)

        return vector3(coords.x, coords.y, coords.z)
    end

    function self.freeze(toggle)
        FreezeEntityPosition(self.handle, toggle)
    end

    function self.getAttachedEntity()
        return GetEntityAttachedTo(self.handle)
    end

    function self.isCollissionEnabled()
        return GetEntityCollissionDisabled(self.handle)
    end

    function self.getHeading()
        return GetEntityHeading(self.handle)
    end

    function self.getMaxHealth()
        return GetEntityMaxHealth(self.handle)
    end

    function self.addBlip()
        if self.blip then
            debugPrint("Ped already has a blip")
            return self.blip
        end

        local blip = AddBlipForEntity(self.handle)
        print("Blip: ", blip.handle)
        self.blip = blip

        return self.blip
    end

    function self.removeBlip()
        if not self.blip then
            debugPrint("Ped does not have a blip")
            return
        end

        self.blip.remove()
        self.blip = nil

        debugPrint("Ped blip removed")
    end

    function self.getBlip()
        return getmetatable(self.blip) == Blip and self.blip or nil
    end

    function self.kill()
        SetEntityHealth(self.handle, 0)
    end

    function self.injure()
        ApplyDamageToPed(self.handle, 1000, false)
        debugPrint("Ped injured")
    end

    ---@param scenario string
    function self.playScenario(scenario)
        TaskStartScenarioInPlace(self.handle, scenario, 0, true)
    end

    function self.getClosestVehicle()
        local coords = self.getCoords()
        local closestVehicle = nil
        local closestDistance = 9999.0

        local vehicles = GetGamePool("CVehicle")

        for i = 1, #vehicles do
            local vehicle = vehicles[i]
            local vehicleCoords = vehicle.getCoords()

            local distance = #(coords - vehicleCoords)

            if distance < closestDistance then
                closestVehicle = vehicle
                closestDistance = distance
            end
        end

        return closestVehicle
    end

    function self.isInVehicle()
        return IsPedInAnyVehicle(self.handle, false)
    end

    function self.getVehicle()
        local vehicle = GetVehiclePedIsIn(self.handle, false)

        return vehicle
    end

    function self.setIntoVehicle(vehicle, seat)
        TaskWarpPedIntoVehicle(self.handle, vehicle.handle, seat)
    end

    function self.setCoords(coords)
        SetEntityCoords(self.handle, coords.x, coords.y, coords.z, false, false, false, false)
    end

    function self.setHeading(heading)
        SetEntityHeading(self.handle, heading)
    end

    function self.setInvincible(toggle)
        SetEntityInvincible(self.handle, toggle)
    end

    function self.setHealth(health)
        SetEntityHealth(self.handle, health)
    end

    function self.setArmour(armour)
        SetPedArmour(self.handle, armour)
    end

    function self.isInjured()
        return IsPedInjured(self.handle)
    end

    function self.isDead()
        return IsPedDeadOrDying(self.handle)
    end

    function self.revive()
        if not self.isInjured() or not self.isDead() then
            debugPrint("Ped is not injured or dead")
            return
        end

        ---@diagnostic disable-next-line
        NetworkResurrectLocalPlayer(self.getCoords().x, self.getCoords().y, self.getCoords().z, self.getCoords().z, true,
            true, false)

        debugPrint("Ped revived")
    end

    function self.getWeapon()
        assert(self.handle, "Ped is not valid")
        ---@diagnostic disable-next-line
        return GetSelectedPedWeapon(self.handle)
    end

    ---@param dict string
    ---@param anim string
    ---@param animData {blendIn: number, blendOut: number, duration: number, flag: number, playbackRate: number, lockX: boolean, lockY: boolean, lockZ: boolean }
    ---@return boolean | nil
    function self.playAnimation(dict, anim, animData)
        assert(DoesAnimDictExist(dict), "Animation dictionary does not exist")

        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local sequence = OpenSequenceTask()
        TaskPlayAnim(nil, dict, anim, animData.blendIn, animData.blendOut, animData.duration, animData.flag,
            animData.playbackRate, animData.lockX, animData.lockY, animData.lockZ)
        CloseSequenceTask(sequence)
        TaskPerformSequence(self.handle, sequence)
        ClearSequenceTask(sequence)
        RemoveAnimDict(dict)

        return true
    end

    function self.clearTasks()
        ClearPedTasks(self.handle)
    end

    function self.clearTasksImmediately()
        ClearPedTasksImmediately(self.handle)
    end

    ---@return boolean
    function self.isAnimationPlaying()
        if not self.animationPlaying then
            return false
        end

        return IsEntityPlayingAnim(self.handle, self.animationPlaying.dict, self.animationPlaying.anim, 3) or
            IsPedUsingAnyScenario(self.handle)
    end

    ---@param weaponHash string | number
    ---@param ammo number | number
    ---@return boolean | nil
    function self.giveWeapon(weaponHash, ammo)
        ---@diagnostic disable-next-line
        return GiveWeaponToPed(self.handle, weaponHash, 1000, false, true)
    end

    ---@return boolean
    function self.placeOnGround()
        local coords = self.getCoords()
        local found, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0.0, false)

        if not found then
            debugPrint("Ground not found")
            return
        end

        self.setCoords(vector3(coords.x, coords.y, groundZ))

        return true
    end

    ---@param

    return self
end

function debugPrint(...)
    local info = debug.getinfo(2, "nSl")
    local line = info.currentline
    local source = info.short_src
    local funcname = info.name or "anonymous"

    print(string.format("[%s:%d] | ^6function^4 %s^0() -", source, line, funcname), ...)
end
