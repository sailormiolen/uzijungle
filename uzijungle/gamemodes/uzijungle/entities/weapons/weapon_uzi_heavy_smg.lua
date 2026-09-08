AddCSLuaFile()

SWEP.Name = "Heavy SMG"
SWEP.PrintName = "Heavy SMG"
SWEP.Purpose = "Serves as the heavy ammo ugrade for the SMG for Uzi Jungle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_smg"

SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/ump45/ump45-1.wav")
SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_smg_ump45.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_smg_ump45.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.HoldType 				= "smg" -- How should your playermodel hold your SWEP? 

SWEP.Primary.Damage = 20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 25
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 25  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 0.4 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 1   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= true -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= .35  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/600 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 10 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.025
SWEP.Primary.Automatic = true

local tracerEveryXBullets = 1