AddCSLuaFile()

SWEP.Name = "Slow Shotgun"
SWEP.PrintName = "Slow Shotgun"
SWEP.Purpose = "Serves as the \"double barrel\" shotgun in Uzi Jungle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_pistol"

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.ReloadSound = Sound("weapons/shotgun/shotgun_reload3.wav")
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_shotgun.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 
SWEP.HoldType = "shotgun"

SWEP.Primary.Damage = 30
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 2
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 2  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 5 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 6   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= false -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= .5  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/160 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 15 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.08716

local tracerEveryXBullets = 1
local RELOAD_TIME = 0.5


function SWEP:Initialize()
    self:SetHoldType(self.HoldType)

    self.Reloading = false
    self.ReloadShellTime = 0
end


function SWEP:PrimaryAttack()

    if self.Reloading then
        return
    end

    if not self:CanPrimaryAttack() then
        return
    end

    local owner = self:GetOwner()

    if not IsValid(owner) then
        return
    end

    self:ShootBullet(
        self.Primary.Damage,
        self.Primary.Recoil,
        self.Primary.NumShots,
        self.Primary.Cone
    )

    self:TakePrimaryAmmo(1)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
end


function SWEP:CanPrimaryAttack()

    if self:Clip1() <= 0 then
        self:EmitSound("Weapon_Shotgun.Empty")
        self:SetNextPrimaryFire(CurTime() + 0.2)
        return false
    end

    return true
end


function SWEP:Reload()

    if self.Reloading then
        return
    end

    if self:Clip1() >= self.Primary.ClipSize then
        return
    end

    if self:Ammo1() <= 0 then
        return
    end

    self.Reloading = true
    self.ReloadShellTime = CurTime()

    self:SetNextPrimaryFire(CurTime() + 999)
    self:SetNextSecondaryFire(CurTime() + 999)

    self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
end


function SWEP:Think()

    if not self.Reloading then
        return
    end

    if CurTime() < self.ReloadShellTime then
        return
    end

    -- Stop if the magazine is full.
    if self:Clip1() >= self.Primary.ClipSize then
        self:FinishReload()
        return
    end

    -- Stop if we have no shells left.
    if self:Ammo1() <= 0 then
        self:FinishReload()
        return
    end

    -- Insert one shell.
    self:SetClip1(self:Clip1() + 1)

    self:EmitSound(self.ReloadSound)

    self:SendWeaponAnim(ACT_VM_RELOAD)

    self.ReloadShellTime = CurTime() + RELOAD_TIME
end


function SWEP:FinishReload()

    if not self.Reloading then
        return
    end

    self.Reloading = false

    self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

    self:SetNextPrimaryFire(CurTime() + 0.5)
    self:SetNextSecondaryFire(CurTime() + 0.5)
end


function SWEP:SecondaryAttack()

    if self.Reloading then
        return
    end

    -- Put secondary fire here if you want it.
end


function SWEP:ShootBullet(damage, recoil, numbul, cone)

    local owner = self:GetOwner()

    if not IsValid(owner) then
        return
    end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    owner:SetAnimation(PLAYER_ATTACK1)
    owner:MuzzleFlash()
    self:EmitSound(self.Primary.Sound)

    local bullet = {}

    bullet.Num = self.Primary.NumberofShots
    bullet.Src = owner:GetShootPos()
    bullet.Dir = owner:GetAimVector()
    bullet.Spread = Vector(cone, cone, 0)
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 10
    bullet.Damage = damage
    bullet.Attacker = owner
    bullet.Inflictor = self

    owner:FireBullets(bullet)

    owner:ViewPunch(
        Angle(
            -recoil,
            math.Rand(-recoil * 0.25, recoil * 0.25),
            0
        )
    )
end