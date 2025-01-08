AddEventHandler("gameEventTriggered", function(name, eventArgs)
    local gunShotEvent = "CEventGunShot"

    print("Event triggered: " .. name)
end)

RegisterCommand("orphan", function(source, args)
    local ped     = GetPlayerPed(source);
    local vehicle = ped.getVehicle();

    if not vehicle then return end

    local orphan    = tonumber(args[1])
    local newOrphan = vehicle.updateVehicleData("orphan", orphan)

    print("Orphan mode: " .. newOrphan)
end, false)
