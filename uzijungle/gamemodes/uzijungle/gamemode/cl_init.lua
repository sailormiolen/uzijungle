AddCSLuaFile("gem_panel/cl_gem_panel.lua")

include("shared.lua")
include("weapon_tree.lua")
include("gem_panel/cl_gem_panel.lua")
include("round_controller/cl_round_controller.lua")

RequestRoundStatus()

function hidehud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudWeaponSelection"}) do
        if name == v then return false end
    end
end

hook.Add("HUDShouldDraw", "HideOurHud", hidehud)

function hud()
    local health = LocalPlayer():Health()
    draw.RoundedBox(0, 2, ScrH() - 15 - 90, 325, 100, Color(0, 0, 0, 120))
    draw.RoundedBox(0, 5, ScrH() - 15 - 20, health*3, 15, Color(255,0,0,255)) -- health box
    draw.SimpleText("Health: " .. health, "Trebuchet24", 5, ScrH() - 15 - 50, Color(255,255,255,255))

    local gemsNeeded = WeaponTree.GetGemsNeededToUpgrade()
    draw.SimpleText("Gems    " .. ClientCurrentGemCount .. "/" .. gemsNeeded, "Trebuchet24", 5, ScrH() - 15- 80, Color(255, 255, 255, 255))
end 

hook.Add("HUDPaint", "UZI_HUD", hud)