RegisterCommand("weapon", function()
    --[[    local skateModel = GetHashKey("a_m_y_skater_01")

    RequestModel(skateModel)

    while not HasModelLoaded(skateModel) do
        Wait(500)
    end

    local playerPed = PlayerPedId()
    local coords = playerPed.getCoordsWithHeading()

    local newPed = CreatePed(
            4,
            skateModel,
            coords.xyz,
            coords.w,
            true,
            true
    )

    local onGround = newPed.placeOnGround()

    if onGround then
        newPed.freeze(true)
        newPed.godMode(true)
    end]]

    local ped = PlayerPedId()
    ped.playScenario("WORLD_HUMAN_SMOKING")
end, false)


RegisterCommand("updateSkill", function()
    local ped = PlayerPedId()

    ped.setSkill(Abilities.SHOOTING_ABILITY, 100)
end, false)

RegisterCommand("giveWeapon", function(source, args)
    local ped = PlayerPedId()

    local weapon = args[1]
    local ammo = tonumber(args[2])

    if not weapon then
        ShowGTANotification("You need to specify a weapon")
        return
    end

    if not ammo then
        ShowGTANotification("You need to specify ammo")
        return
    end

    ped.giveWeapon(weapon or "WEAPON_PISTOL", ammo)
end, false)

function ShowGTANotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    PlayerPedId().revive()

    -- while true do
    --     if IsControlJustPressed(0, 73) then
    --         local ped = PlayerPedId()

    --         if ped.isAnimationPlaying() then
    --             ped.clearTasks()
    --         end
    --     end

    --     Citizen.Wait(0)
    -- end
end)

RegisterNetEvent("wrapper:vehicles:client:setOrphanMode", function()
    print("?????")
end)
