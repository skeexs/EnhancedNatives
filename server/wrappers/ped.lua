---@class ServerPed;
---@field handle number;
---@field setOrphanMode fun(orphan: number): any;
---@field getOrphanMode fun(): number;
---@field getVehicle fun(): ServerVehicle;

---@param handle number;
---@return ServerPed;
function ServerPed(handle)
    local self = setmetatable({}, { __index = Ped })

    self.handle = handle
    self.orphan = GetEntityOrphanMode(self.handle) or 0

    ---@param orphan number;
    ---@return any;
    function self.setOrphanMode(orphan)
        if not SetEntityOrphanMode then
            return
        end

        SetEntityOrphanMode(self.handle, orphan)
        self.orphan = orphan
    end

    ---@return number;
    function self.getOrphanMode()
        return self.orphan
    end

    ---@return ServerVehicle;
    function self.getVehicle()
        local vehicle = GetVehiclePedIsIn(self.handle, false) --[[@as ServerVehicle]]

        return ServerVehicle(vehicle.handle)
    end

    return self
end
