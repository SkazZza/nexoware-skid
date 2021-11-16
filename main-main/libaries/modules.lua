local client = {}; do
    for i,v in pairs(getgc(true)) do
        if (client.char and client.network and client.camera and client.particle and client.gamelogic and client.hud and client.uiscaler and client.input and client.effects and client.sound and client.replication and client.publicsettings and client.roundsystem and client.menu and client.screencull and client.bulletcheck and client.trajectory and client.loadgun and client.gunbob and client.gunsway) then break end
        if (type(v) == "table") then
            if (rawget(v, "setmovementmode")) then
                client.char = v
            elseif (rawget(v, "send")) then
                client.network = v
            elseif (rawget(v, "basecframe")) then
                client.camera = v
            elseif (rawget(v, "new") and rawget(v, "reset")) then
                client.particle = v
            elseif (rawget(v, "gammo")) then
                client.gamelogic = v
            elseif (rawget(v, "updateammo")) then
                client.hud = v
            elseif (rawget(v, "getscale")) then
                client.uiscaler = v
            elseif (rawget(v, "iskeydown")) then
                client.input = v
            elseif (rawget(v, "breakwindow")) then
                client.effects = v
            elseif (rawget(v, "PlaySound")) then
                client.sound = v
            elseif (rawget(v, "getupdater")) then
                client.replication = v
            elseif (rawget(v, "bulletLifeTime")) then
                client.publicsettings = v
            elseif (rawget(v, "raycastwhitelist")) then
                client.roundsystem = v
            elseif (rawget(v, "deploy")) then
                client.menu = v
            elseif (rawget(v, "localSegment")) then
                client.screencull = v
            end
        elseif (type(v) == "function") then
            local Name = debug.getinfo(v).name

            if (Name == "bulletcheck" and debug.getconstant(v, 4) == "Instance") then
                client.bulletcheck = v
            elseif (Name == "trajectory") then
                client.trajectory = v
            elseif (Name == "loadgun") then
                client.loadgun = v
            elseif (Name == "loadplayer") then
                client.loadplayer = v
            elseif (Name == "gunsway") then
                client.gunsway = v
            elseif (Name == "gunbob") then
                client.gunbob = v
            end
        end
    end
end

return client
