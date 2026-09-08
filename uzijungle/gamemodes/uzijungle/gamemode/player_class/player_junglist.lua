DEFINE_BASECLASS("player_default")

local JUNGLIST = {}

JUNGLIST.WalkSpeed = 150
JUNGLIST.RunSpeed = 250
JUNGLIST.SlowWalkSpeed = 100

function JUNGLIST:Loadout()
    self.Player:RemoveAllItems()

    self.Player:GiveAmmo(240, "UZI_BULLET", true)
    
    self.Player:Give(WeaponTree.CurrentWeapon(1))
end

JUNGLIST.giveLoadout = function()
    JUNGLIST:Loadout()
end

player_manager.RegisterClass("player_junglist", JUNGLIST, "player_default")