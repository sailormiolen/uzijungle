GM.Name = "Uzi Jungle"
GM.Author = "bridges"

include("weapon_tree.lua")
include("player_class/player_junglist.lua")
include("noclip_disable.lua")

function GM:Initialize()
   game.AddAmmoType( {
      name = "UZI_BULLET",
      dmgtype = DMG_BULLET,
      tracer = TRACER_BEAM,
      plydmg = 5,
      npcdmg = 5,
      force = 100,
      maxcarry = 240,
      minsplash = 10,
      maxsplash = 5
   })

   if SERVER then
      BeginRound()
   end
end

function GM:PlayerFootstep(ply, pos, foot, sound, volume, rf)
   if IsValid(ply) and (ply:Crouching() or ply:GetMaxSpeed() < 150) then
      -- do not play anything, just prevent normal sounds from playing
      return true
   end
end

--Predict player movement
function GM:Move(ply, mv)
   if ply then
      mv:SetMaxClientSpeed(mv:GetMaxClientSpeed())
      mv:SetMaxSpeed(mv:GetMaxSpeed())
   end

   if drive.Move(ply, mv) then return true end
end