AddCSLuaFile()

--Sent by cl_gem_panel.lua when the player is done selecting their next weapon
util.AddNetworkString("answergui")
net.Receive("answergui", function()
      local ply = net.ReadPlayer()
      local nextwep = net.ReadString()

      if nextwep == "OOB" then
      nextwep = "weapon_uzi_pistol"
      end

      ply:RemoveAllItems()
      ply:Give(nextwep)
      ply:GiveAmmo(240, "UZI_BULLET", true)
      ply:GodDisable()

      local smokescreen = net.ReadEntity()

      smokescreen:Fire("TurnOff")
      smokescreen:Remove()
end)

--Sent by cl_gem_panel.lua when the panel opens but the player has not selected their next weapon
util.AddNetworkString("firesmokescreen")
net.Receive("firesmokescreen", function ()
   local smokescreen = net.ReadEntity()

   if IsValid(smokescreen) then
      smokescreen:Fire("TurnOn")
   end
end)

--Sent by cl_gem_panel.lua in the case that the player doesn't have enough gems to open the weapon selection panel
util.AddNetworkString("removesmokescreen")
net.Receive("removesmokescreen", function()
   local ply = net.ReadPlayer()
   local smokescreen = net.ReadEntity()

   ply:GodDisable()
   smokescreen:Remove()
end)

--Used by cl_gem_panel.lua
util.AddNetworkString("opengui")