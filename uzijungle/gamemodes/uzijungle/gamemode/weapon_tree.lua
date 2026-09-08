AddCSLuaFile()
WeaponTree = {}

local WeaponList = {"weapon_uzi_pistol", "weapon_uzi_big_pistol", "weapon_uzi_burst_pistol", 
    "weapon_uzi_semi_rifle", "weapon_uzi_slow_shotgun", "weapon_uzi_weak_rifle", 
    "weapon_uzi_smg", "weapon_uzi_sniper_rifle", "weapon_uzi_burst_rifle", 
    "weapon_uzi_shotgun", "weapon_uzi_auto_shotgun", "weapon_uzi_rifle", 
    "weapon_uzi_silenced_rifle", "weapon_uzi_high_cap_smg", "weapon_uzi_heavy_smg"}

// corresponding icons in the cs.ttf font
local WeaponFontList = {"a", "f", "c", "e", "k", "v", "x", "n", "t", "k", "B", "b", "w", "m", "q"}

function WeaponTree.LeftChild(idx)
    return idx*2
end

function WeaponTree.RightChild(idx)
    return idx*2+1
end

function WeaponTree.CurrentWeapon(idx)
    if idx > #WeaponList then
        if CLIENT then
            ClientTreePos = 1
        end

        return "OOB"
    else
        return WeaponList[idx]
    end
end

function WeaponTree.CurrentWeaponFontIcon(idx)
if idx > #WeaponList then
        if CLIENT then
            ClientTreePos = 1
        end

        return "OOB"
    else
        return WeaponFontList[idx]
    end
end

function WeaponTree.GetGemsNeededToUpgrade()
    if CLIENT then
        if ClientTreePos <= 1 then
            return 2
        elseif ClientTreePos <= 3 then
            return 3
        else
            return 4
        end
    end
end