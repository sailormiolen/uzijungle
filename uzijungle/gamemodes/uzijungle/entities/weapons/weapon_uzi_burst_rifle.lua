AddCSLuaFile()

SWEP.Name = "Burst Rifle"
SWEP.PrintName = "Burst Rifle"
SWEP.Purpose = "Burst rifle upgrade to the semi-automatic rifle"
SWEP.Spawnable = true 
SWEP.Base = "weapon_uzi_burst_pistol"

SWEP.Primary.Sound = Sound("weapons/famas/famas-1.wav")
SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")

SWEP.ViewModelFlip			= false -- This is like the CSGO command, if you wanna display your gun on the left side of the screen
SWEP.ViewModelFOV			= 60	-- FOV of the SWEP Model
SWEP.ViewModel				= "models/weapons/v_rif_famas.mdl"	-- Model path to an already existing model or custom model (Model you see on screen)
SWEP.WorldModel				= "models/weapons/w_rif_famas.mdl" -- Model path to an already existing model or custom model (Model you see when your character holds it out)
SWEP.UseHands          	 	= true	-- Can you see your hands when you hold the model? 

SWEP.HoldType 				= "ar2" -- How should your playermodel hold your SWEP? 

SWEP.Primary.ClipSize = 21
SWEP.Primary.DefaultClip 	= 21
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Cone        = 0.015
SWEP.Primary.Delay      = 60/120
SWEP.Primary.Damage      = 25

local numBurstShots = 3
local burstDelay = 60/800.0
local burstFlag = false