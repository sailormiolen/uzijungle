AddCSLuaFile()

SWEP.Name = "Burst Pistol"
SWEP.PrintName = "Burst Pistol"
SWEP.Purpose = "Burst pistol upgrade to the starter pistol"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_pistol"

SWEP.Primary.Sound = Sound("weapons/glock/glock18-1.wav")
SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_pist_glock18.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_pist_glock18.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.Primary.ClipSize = 21
SWEP.Primary.DefaultClip 	= 21
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Cone        = 0.03
SWEP.Primary.Delay      = 60/180
SWEP.Primary.Damage      = 15

local numBurstShots = 3
local burstDelay = 60/900.0
local burstFlag = false

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    local owner = self:GetOwner()

    if not IsValid(owner) or owner:IsNPC() then return end

    self.BurstShotsRemaining = numBurstShots
    self.NextBurstShot = CurTime()

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:Think()
    if not self.BurstShotsRemaining or self.BurstShotsRemaining <= 0 then
        return
    end

    if CurTime() < self.NextBurstShot then
        return
    end

    if self:Clip1() <= 0 then
        self.BurstShotsRemaining = 0
        return
    end

    if not worldsnd then
                self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
        elseif SERVER then
                sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
    end

    self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumberofShots, self:GetPrimaryCone())

    self:TakePrimaryAmmo(1)

    self.BurstShotsRemaining = self.BurstShotsRemaining - 1
    self.NextBurstShot = CurTime() + burstDelay
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
   bullet.Spread     = Vector(cone, cone, 0)
   bullet.Tracer     = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force      = 5
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