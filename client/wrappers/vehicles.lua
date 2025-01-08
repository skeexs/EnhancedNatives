---@class Vehicle
---@field handle number
---@field getCoordsWithHeading fun(): vector4
---@field getCoords fun(): vector3
---@field setCoords fun(coords: vector3): any
---@field setHeading fun(heading: number): any
---@field getFuelLevel fun(): number
---@field setFuelLevel fun(level: number): any
---@field getEngineHealth fun(): number
---@field setEngineHealth fun(health: number): any
---@field getSpeed fun(): number
---@field setSpeed fun(speed: number): any
---@field getRPM fun(): number
---@field getGear fun(): number
---@field delete fun(): any
---@field isSeatFree fun(seat: number): boolean
---@field getFreeSeat fun(): number
---@field getPedOnSeat fun(seat: number): Ped
---@field getClass fun(): number, string
---@field getClassLabelFromIndex fun(index: number): string
---@field getColor fun(): number, number
---@field setColor fun(color1: number, color2: number): any
---@field getExtraColors fun(): number, number
---@field setExtraColors fun(extra1: number, extra2: number): any
---@field getNeonLightsColor fun(): number
---@field getVehicleProperties fun(): table


VEHICLE_CLASSES = {
    "Compacts",
    "Sedans",
    "SUVs",
    "Coupes",
    "Muscle",
    "Sports Classics",
    "Sports",
    "Super",
    "Motorcycles",
    "Off-road",
    "Industrial",
    "Utility",
    "Vans",
    "Cycles",
    "Boats",
    "Helicopters",
    "Planes",
    "Service",
    "Emergency",
    "Military",
    "Commercial",
    "Trains"
}

---@param handle number
---@return Vehicle
function Vehicle(handle)
    local self = setmetatable({}, { __index = Vehicle })
    self.handle = handle

    if not GetEntityOrphanMode then
        self.orphanMode = 0
    else
        self.orphanMode = GetEntityOrphanMode(self.handle)
    end

    function self.getCoordsWithHeading()
        local coords = GetEntityCoords(self.handle, false)
        local heading = GetEntityHeading(self.handle)

        return vector4(coords.x, coords.y, coords.z, heading)
    end

    function self.getOrphanMode()
        return self.orphanMode
    end

    function self.getCoords()
        local coords = GetEntityCoords(self.handle, false)

        return vector3(coords.x, coords.y, coords.z)
    end

    function self.setCoords(coords)
        SetEntityCoords(self.handle, coords.x, coords.y, coords.z, false, false, false, false)
    end

    function self.setHeading(heading)
        SetEntityHeading(self.handle, heading)
    end

    function self.getFuelLevel()
        return DecorGetFloat(self.handle, "_FUEL_LEVEL")
    end

    function self.setFuelLevel(level)
        DecorSetFloat(self.handle, "_FUEL_LEVEL", level)
    end

    function self.getEngineHealth()
        return GetVehicleEngineHealth(self.handle)
    end

    function self.setEngineHealth(health)
        SetVehicleEngineHealth(self.handle, health)
    end

    function self.getSpeed()
        return GetEntitySpeed(self.handle)
    end

    function self.setSpeed(speed)
        SetEntityMaxSpeed(self.handle, speed)
    end

    function self.getRPM()
        return GetVehicleCurrentRpm(self.handle)
    end

    function self.getGear()
        return GetVehicleCurrentGear(self.handle)
    end

    function self.delete()
        DeleteEntity(self.handle)
    end

    function self.isSeatFree(seat)
        return IsVehicleSeatFree(self.handle, seat)
    end

    function self.getPedOnSeat(seat)
        local ped = GetPedInVehicleSeat(self.handle, seat)

        if ped == 0 then
            return 0
        end

        return ped
    end

    function self.getFreeSeat()
        for i = -1, GetVehicleMaxNumberOfPassengers(self.handle) do
            if self.isSeatFree(i) then
                return i
            end
        end

        return -1
    end

    function self.getClass()
        assert(GetVehicleClass(self.handle) ~= nil, "Vehicle class is nil")

        local index = GetVehicleClass(self.handle)
        local classIndex = index + 1

        return index, self.getClassLabelFromIndex(classIndex)
    end

    function self.getColor()
        local color1, color2 = GetVehicleColours(self.handle)

        return color1, color2
    end

    function self.setColor(color1, color2)
        SetVehicleColours(self.handle, color1, color2)
    end

    function self.getExtraColors()
        local extra1, extra2 = GetVehicleExtraColours(self.handle)

        return extra1, extra2
    end

    function self.setExtraColors(extra1, extra2)
        SetVehicleExtraColours(self.handle, extra1, extra2)
    end

    function self.getNeonLightsColor()
        return GetVehicleNeonLightsColour(self.handle)
    end

    function self.getNeonLightsEnabled()
        return {
            IsVehicleNeonLightEnabled(self.handle, 0),
            IsVehicleNeonLightEnabled(self.handle, 1),
            IsVehicleNeonLightEnabled(self.handle, 2),
            IsVehicleNeonLightEnabled(self.handle, 3)
        }
    end

    function self.getVehicleProperties()
        local props = {}

        props.color1, props.color2 = self.getColor()
        props.extra1, props.extra2 = self.getExtraColors()
        props.neonColor = self.getNeonLightsColor()
        props.neonEnabled = self.getNeonLightsEnabled()

        return props
    end

    function self.getClassLabelFromIndex(index)
        return VEHICLE_CLASSES[index]
    end

    function self.getModel()
        return GetEntityModel(self.handle)
    end

    return self
end
