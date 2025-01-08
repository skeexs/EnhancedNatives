local _PlayerPedId = PlayerPedId
local _GetVehiclePedIsIn = GetVehiclePedIsIn
local _GetGamePool = GetGamePool

PlayerPedId = function()
    local ped = _PlayerPedId() --[[@as integer]]

    return Ped(ped)
end

GetVehiclePedIsIn = function(ped, lastVehicle)
    local vehicle = _GetVehiclePedIsIn(ped, lastVehicle) --[[@as integer]]

    return Vehicle(vehicle)
end

GetGamePool = function(type)
    local pool = _GetGamePool(type) --[[@as integer]]

    if type == "CVehicle" then
        for i = 1, #pool do
            pool[i] = Vehicle(pool[i])
        end
    elseif type == "CPed" then
        for i = 1, #pool do
            pool[i] = Ped(pool[i])
        end
    end

    return pool
end

local _GetPedInVehicleSeat = GetPedInVehicleSeat

GetPedInVehicleSeat = function(vehicle, seat)
    local ped = _GetPedInVehicleSeat(vehicle, seat) --[[@as integer]]

    return Ped(ped)
end

local _CreatePed = CreatePed
local _CreateVehicle = CreateVehicle
local _CreateVehicleNoOffset = CreateVehicleNoOffset

CreatePed = function(type, model, coords, heading, networked, cb)
    local ped = _CreatePed(type, model, coords, heading, networked, cb) --[[@as integer]]

    if ped == 0 then
        return nil
    end

    return Ped(ped)
end

CreateVehicle = function(model, coords, heading, networked, cb)
    local vehicle = _CreateVehicle(model, coords, heading, networked, cb) --[[@as integer]]

    return Vehicle(vehicle)
end

CreateVehicleNoOffset = function(model, coords, heading, networked, cb)
    local vehicle = _CreateVehicleNoOffset(model, coords, heading, networked, cb) --[[@as integer]]

    return Vehicle(vehicle)
end
