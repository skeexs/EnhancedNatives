local _GetPlayerPed = GetPlayerPed;
local _GetVehiclePedIsIn = GetVehiclePedIsIn;

---@return ServerPed;
function GetPlayerPed(player)
    local ped = _GetPlayerPed(player) --[[@as integer]]

    return ServerPed(ped)
end

---@return ServerVehicle;
function GetVehiclePedIsIn(ped, lastVehicle)
    local vehicle = _GetVehiclePedIsIn(ped, lastVehicle) --[[@as integer]]

    return ServerVehicle(vehicle)
end
