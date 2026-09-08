AddCSLuaFile()

SWEP.Name = "SMG"
SWEP.PrintName = "SMG"
SWEP.Purpose = "Serves as the SMG for Uzi Jungle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_base"

SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/mp5navy/mp5-1.wav")
SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_smg_mp5.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_smg_mp5.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.HoldType 				= "smg" -- How should your playermodel hold your SWEP? 

SWEP.Primary.Damage = 13
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 18
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 24  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 0.4 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 1   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= true -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= .2  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/800 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 10 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.03
SWEP.Primary.Automatic = true

local tracerEveryXBullets = 3

function SWEP:Initialize()
   self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack(worldsnd)
   local ply = self:GetOwner()

   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
   end

   self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

   self:TakePrimaryAmmo( 1 )

   local owner = self:GetOwner()
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil, util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil, 0 ) )

   if game.SinglePlayer() then
      self:CallOnClient("SPLastShoot")
   end
end

function SWEP:DryFire(setnext)
   if CLIENT and LocalPlayer() == self:GetOwner() then
      self:EmitSound( "Weapon_Pistol.Empty" )
   end

   setnext(self, CurTime() + 0.2)

   self:Reload()
end

function SWEP:CanPrimaryAttack()
   if not IsValid(self:GetOwner()) then return end

   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
end

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:SendWeaponAnim(self.PrimaryAnim)

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )

   numbul = numbul or 1
   cone   = cone   or 0.01

   local bullet = {}
   bullet.Num        = numbul
   bullet.Src        = self:GetOwner():GetShootPos()
   bullet.Dir        = self:GetOwner():GetAimVector()
   bullet.Spread     = Vector( cone, cone, 0 )
   bullet.Tracer     = tracerEveryXBullets
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force      = 10
   bullet.Damage     = dmg
   bullet.Attacker   = self:GetOwner()
   bullet.Inflictor  = self

   self:GetOwner():FireBullets( bullet )

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or self:GetOwner():IsNPC() or (not self:GetOwner():Alive()) then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 0.6) or recoil

      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
   end
end

function SWEP:GetPrimaryCone()
   local cone = self.Primary.Cone or 0.2
   -- 15% accuracy bonus when sighting
   return cone
end

SWEP.Secondary.ClipSize = -1 // Size of a clip
SWEP.Secondary.DefaultClip = -1 // Default number of bullets in a clip
SWEP.Secondary.Automatic = false // Automatic/Semi Auto
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1

function SWEP:SecondaryAttack()
   self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
end

SWEP.Slot 					= 2 -- What slot does it show up in? 

SWEP.SlotPos 				= 1 	-- Doesnt really matter
SWEP.DrawCrosshair 			= true  -- Does it display the crosshair?
SWEP.DrawAmmo 				= true	-- Does it display the SWEPs ammo?
SWEP.Weight 				= 5 	-- Priority of the weapon when its picked up
SWEP.AutoSwitchTo 			= false -- Can it be switched to?
SWEP.AutoSwitchFrom 		= false -- Can it be switched from? 

SWEP.FiresUnderwater 		= false	-- Can it fire underwater?

SWEP.ReloadSound 			= "sound/epicreload.wav" -- The sound it makes when it reloads (I suggest precaching if your going to use a custom reload sound)

SWEP.CSMuzzleFlashes 		= true -- Should the SWEP Have CounterStrike muzzle flashes? 

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

function SWEP:GetPrimaryDelay()
   return self.Primary.Delay
end

function SWEP:SetPrimaryDelay(delay)
   self.Primary.Delay = delay
end

function SWEP:SetStat(stat, value)
   self.Primary[stat] = value
end