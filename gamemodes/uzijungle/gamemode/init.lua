AddCSLuaFile("cl_init.lua")
AddCSLuaFile("gem_panel/cl_gem_panel.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("weapon_tree.lua")
AddCSLuaFile("player_class/player_junglist.lua")
AddCSLuaFile("entities/uzi_gem/init.lua")
AddCSLuaFile("gem_panel/sv_gem_panel.lua")
AddCSLuaFile("round_controller/cl_round_controller.lua")

include("shared.lua")
include("weapon_tree.lua")
include("player_class/player_junglist.lua")
include("gem_panel/sv_gem_panel.lua")
include("round_controller/sv_round_controller.lua")

DEFINE_BASECLASS("gamemode_base")

BeginRound()

--Server applies realistic fall damage
hook.Add("GetFallDamage", "RealisticDamage", function(ply, speed) 
   return (speed / 10)
end)

--Server local for tracking all player's last used weapon before they die so that it can be given back
local weaponTracker = {}

hook.Add("WeaponEquip", "AddToWeaponTracker", function(weapon, ply)
   local plyID = ply:AccountID()
   local weaponName = weapon:GetClass()

   weaponTracker[plyID] = weaponName
end)

function GM:InitPostEntity()
   local gem = ents.Create("uzi_gem")
   gem:Spawn()

   
end

function GM:PlayerSpawn(ply, transition)
   local predeathWep = ""
   if weaponTracker[ply:AccountID()] ~= nil then
      predeathWep = weaponTracker[ply:AccountID()]
   end

   player_manager.SetPlayerClass(ply, "player_junglist")
   ply:SetModel("models/player/kleiner.mdl")
   BaseClass.PlayerSpawn(self, ply, transition)

   if predeathWep ~= "" then
      ply:RemoveAllItems()
      ply:Give(predeathWep)
      ply:GiveAmmo(240, "UZI_BULLET", true)
   end

   if GetRoundStatus() == "waiting" then
      BeginRound()
   end
end
