AddCSLuaFile()

SWEP.Name = "Desert Eagle"
SWEP.PrintName = "Desert Eagle"
SWEP.Purpose = "Large caliber upgrade to the starter pistol"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_pistol"

SWEP.Primary.Sound = Sound("weapons/deagle/deagle-1.wav")
SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD

SWEP.ViewModelFlip			= true -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_pist_deagle.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.Primary.Damage = 30
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 7
SWEP.Primary.Ammo = "UZI_BULLET"

SWEP.Primary.DefaultClip 	= 7  -- How much bullets the user spawns with when the swep is given to them
SWEP.Primary.Spread 		= 0.2 -- How much spread the weapon has
SWEP.Primary.NumberofShots  = 1   -- How many bullets are dispensed when shot
SWEP.Primary.Automatic 		= false -- Automatic? Yes = true | No = false
SWEP.Primary.Recoil 		= .5  -- How much recoil the weapon has
SWEP.Primary.Delay 			= 60/180.0 -- Time Delay before the next shot can happen
SWEP.Primary.Force 			= 30 -- How much force or push is given to a prop or npc after it is shot by the weapon 
SWEP.Primary.Cone        = 0.015