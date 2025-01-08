---@class ServerVehicle;
---@field handle number;
---@field orphan number;
---@field setOrphanMode fun(orphan: number): any
---@field getOrphanMode fun(): number
---@field netId number;
---@field getNetId fun(): number
---@field updateVehicleData fun(key: string, value: any): any
---@field getVehicleData fun(key: string): table

---@enum EntityOrphanMode
OrphanModes = {
    DeleteWhenNotRelevant   = 0,
    DeleteOnOwnerDisconnect = 1,
    KeepEntity              = 2
}

---@param ent number;
---@return ServerVehicle;
function ServerVehicle(ent)
    local self       = setmetatable({}, {
        __index = Vehicle
    });

    self.handle      = ent;
    self.orphan      = GetEntityOrphanMode(self.handle) or 0;
    self.netId       = NetworkGetNetworkIdFromEntity(self.handle) or 0;
    self.vehicleData = {
        netId  = self.netId,
        orphan = self.orphan,
    };

    ---@param orphan number;
    ---@return any;
    function self.setOrphanMode(orphan)
        if not SetEntityOrphanMode then
            return;
        end

        SetEntityOrphanMode(self.handle, orphan);
        self.orphan = orphan;
    end

    ---@return number;
    function self.getOrphanMode()
        return self.orphan;
    end

    ---@param key string;
    ---@param value any;
    ---@return any;
    function self.updateVehicleData(key, value)
        assert(key, "Key cannot be nil");
        assert(value, "Value cannot be nil");
        assert(self.vehicleData[key], "Key does not exist in vehicle data");

        self.vehicleData[key] = value;

        TriggerClientEvent("wrapper:vehicle:update:client", -1, self.netId, key, value);
        TriggerEvent("wrapper:vehicle:update:server", self.netId, key, value);

        return self.vehicleData[key];
    end

    ---@param key string;
    ---@return table | any;
    function self.getVehicleData(key)
        local data = {
            netId = self.netId,
            orphan = self.orphan,
        };

        for k, v in pairs(self.vehicleData) do
            data[k] = v;
        end

        if key then
            return data[key];
        end

        return data;
    end

    return self;
end
