local roundStatus = "waiting"
local roundTimeLeft = -1

local function RequestFreeze()
    net.Start("ClientRequestFreeze")
    net.WritePlayer(LocalPlayer())
    net.SendToServer()
end

net.Receive("RoundStatusUpdate", function()
    roundStatus = net.ReadString()
    roundTimeLeft = net.ReadInt(17)

    if roundStatus == "waiting" or roundStatus == "starting" then
        RequestFreeze()
    end
end)

function GetRoundStatus()
    return roundStatus
end

function RequestRoundStatus()
    net.Start("ClientRequestUpdate")
    net.SendToServer()
end

function RoundHud()
    local roundHUDWords
    
    if GetRoundStatus() == "waiting" then
        roundHUDWords = "Waiting for players..."
    elseif GetRoundStatus() == "starting" then
        roundHUDWords = "Starting..."
    elseif GetRoundStatus() == "playing" then
        local roundTimeMinutesPart = math.floor(roundTimeLeft / 60)
        local roundTimeSecondsPart = roundTimeLeft % 60
        roundHUDWords = "Time Left: " .. roundTimeMinutesPart .. ":" .. roundTimeSecondsPart
    elseif GetRoundStatus() == "ended" then
        roundHUDWords = "Ending..."
    end

    draw.SimpleText(roundHUDWords, "Trebuchet24", ScrW() / 2, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end

hook.Add("HUDPaint", "RoundHUD", RoundHud)