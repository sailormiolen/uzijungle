AddCSLuaFile()

SWEP.Name = "Semi-Automatic Rifle"
SWEP.PrintName = "Semi-Automatic Rifle"
SWEP.Purpose = "Serves as the semi-automatic rifle in Uzi Jungle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_pistol"

SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/aug/aug-1.wav")
SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_rif_aug.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_rif_aug.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 
SWEP.HoldType 				= "ar2" -- How should your playermodel hold your SWEP? 

SWEP.Primary.Damage = 25
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 20
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 20  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 0.3 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 1   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= false -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= .5  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/300 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 15 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.01

local tracerEveryXBullets = 1