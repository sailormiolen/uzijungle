local roundStatus = "waiting" -- options are waiting, starting, playing, and ended
local roundTimeLeft = -1 -- -1 if the current roundStatus doesn't display the time or is infinite

util.AddNetworkString("RoundStatusUpdate")
util.AddNetworkString("ClientRequestUpdate")
util.AddNetworkString("ClientRequestFreeze")

net.Receive("ClientRequestUpdate", function()
    SendRoundStatus()
end)

net.Receive("ClientRequestFreeze", function()
    local ply = net.ReadPlayer()
    if ply:IsPlayer() then
        ply:Freeze(true)
    end
end)

local function CheckPlayerCount()
    return #player.GetAll() >= GetConVar("uzi_playersneededtostart"):GetInt()
end

-- Freeze all players if state = true
local function FreezePlayers(state)
    for _, v in ipairs(player.GetAll()) do
        v:Freeze(state)
    end
end

function BeginRound() 
    print("Round Begin Called")
    roundStatus = "waiting"
    roundTimeLeft = -1
    SendRoundStatus()

    FreezePlayers(true) -- Freeze all the players while waiting for players

    if CheckPlayerCount() == true then
        roundStatus = "starting"
        roundTimeLeft = -1
        SendRoundStatus()

        timer.Simple(10, function()
            roundStatus = "playing"

            FreezePlayers(false)
            roundTimeLeft = GetConVar("uzi_roundtime"):GetInt() * 60
            SendRoundStatus()

            timer.Create("roundTimer", 1, GetConVar("uzi_roundtime"):GetInt() * 60, function()
                SendRoundStatus()
                roundTimeLeft = roundTimeLeft - 1
            end)

            timer.Simple(GetConVar("uzi_roundtime"):GetInt() * 60, function()
                EndRound()
            end)
        end)
    end
end

function EndRound()
    roundStatus = "ended"
    roundTimeLeft = -1
    SendRoundStatus()

    timer.Simple(20, function()
        BeginRound()
    end)
end

function GetRoundStatus()
    return roundStatus
end

function SendRoundStatus()
    net.Start("RoundStatusUpdate")
    net.WriteString(roundStatus)
    net.WriteInt(roundTimeLeft, 17)
    net.Broadcast()
end