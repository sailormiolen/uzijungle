AddCSLuaFile()

SWEP.Name = "Weak Rifle"
SWEP.PrintName = "Weak Rifle"
SWEP.Purpose = "Serves as the weaker version of a rifle for Uzi Jungle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_rifle"

SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/galil/galil-1.wav")
SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")

SWEP.ViewModelFlip			= false -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_rif_galil.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_rif_galil.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.HoldType 				= "ar2" -- How should your playermodel hold your SWEP? 

SWEP.Primary.Damage = 13
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 30  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 0.4 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 1   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= true -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= 1  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/450 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 25 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.02
SWEP.Primary.Automatic = true

local tracerEveryXBullets = 1