# EnhancedNatives
A script that enhances natives and creates a object for ex. PlayerPedId()

## How do I use this?
Have you always wanted to use FiveM natives as classes in Lua? Now you can.

# Clientside
```lua
local ped       = PlayerPedId() -- this will now return a table with natives that are related to the player ped;

local vehicle   = ped.getVehicle() -- will return the vehicle that the player is in, this will also return a vehicle object;
local coords    = ped.getCoords() -- will return the coords of the player;

--[[
    If you want to use the handle of the player ped you can use
    PlayerPedId().handle. This will return the handle of the player ped.
]]--
```

## Server sided natives
```lua
--These natives do not have the same functionality as it is the server.
--And it does not have the same natives as the client.
local ped = GetPlayerPed(source);
```

## How to I use this in my script?
Because FiveM doesn't allow you to replace natives you will have to include this in every script you want to use it in.

In your fxmanifest.lua file you will have to include the following:

```lua
client_scripts {
    '@EnhancedNatives/client/init.lua'
}

server_scripts {
    '@EnhancedNatives/server/init.lua'
}
```

## Does it work for vehicles as well?
Yes, it does. You can use the following natives for vehicles:
```lua
local ped       = PlayerPedId();

--[[You could also do ped.getClosestVehicle() which will return the closest vehicle to the player.]]--
local vehicle   = ped.getVehicle();

local coords    = vehicle.getCoords();
local speed     = vehicle.getSpeed();
local fuel      = vehicle.getFuelLevel();

-- setters
vehicle.setFuelLevel(100);
vehicle.setHeading(90);

---@param vector3;
vehicle.setCoords(vector3(0, 0, 0));

---@param color1 number;
---@param color2 number;
vehiucle.setColor(color1, color2)

```