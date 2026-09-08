AddCSLuaFile()
AddCSLuaFile("uzijungle/gamemode/weapon_tree.lua")
include("uzijungle/gamemode/weapon_tree.lua")

--Create Counter-Strike: Source weapon icon font
surface.CreateFont("cswep", {
    font = "cs",
    size = 64
})

--Client side globals for tracking the player's position in the weapons tree and their current gem count
ClientTreePos = 1
ClientCurrentGemCount = 0


--GUI opens when opengui is received. Closes after answergui is sent to the server
net.Receive("opengui", function()
    local ply = LocalPlayer()
    ClientCurrentGemCount = ClientCurrentGemCount + 1
    local smokescreen = net.ReadEntity()

    if (WeaponTree.GetGemsNeededToUpgrade() > ClientCurrentGemCount) then
        net.Start("removesmokescreen")
        net.WritePlayer(ply)
        net.WriteEntity(smokescreen)
        net.SendToServer()

        return
    else
        ClientCurrentGemCount = 0
    end

    net.Start("firesmokescreen")
    net.WriteEntity(smokescreen)
    net.SendToServer()

    local Frame = vgui.Create("DFrame")
    Frame:SetBackgroundBlur(true)
    Frame:SetPos( 0, 0 ) 
    Frame:SetSize( 300, 150 ) 
    Frame:SetTitle( "" ) 
    Frame:SetVisible( true ) 
    Frame:SetDraggable( false ) 
    Frame:ShowCloseButton( false ) 
    Frame:Center()
    Frame:MakePopup()

    local leftWeaponName = WeaponTree.CurrentWeapon(WeaponTree.LeftChild(ClientTreePos))
    local rightWeaponName = WeaponTree.CurrentWeapon(WeaponTree.RightChild(ClientTreePos))
    leftWeaponName = string.sub(leftWeaponName, 12)
    rightWeaponName = string.sub(rightWeaponName, 12)

    leftWeaponName = leftWeaponName:gsub("_", " ")
    rightWeaponName = rightWeaponName:gsub("_", " ")

    Frame.Paint = function(self, w, h)
        draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0, 210))
        draw.SimpleText("Select Your Next Gun", "Trebuchet24", 150, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText(leftWeaponName, "default", 75, 130, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(rightWeaponName, "default", 225, 130, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end

    

    local leftWeaponIcon = WeaponTree.CurrentWeaponFontIcon(WeaponTree.LeftChild(ClientTreePos))
    local rightWeaponIcon = WeaponTree.CurrentWeaponFontIcon(WeaponTree.RightChild(ClientTreePos))

    local ButtonLeft = vgui.Create("DButton", Frame)
    ButtonLeft:SetText(leftWeaponIcon)
    ButtonLeft:SetTextColor(Color(255, 255, 255, 255))
    ButtonLeft:SetPos(15, 45)
    ButtonLeft:SetSize(125, 75)
    ButtonLeft:SetFont("cswep")
    ButtonLeft.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 210))
    end

    local ButtonRight = vgui.Create("DButton", Frame)
    ButtonRight:SetText(rightWeaponIcon)
    ButtonRight:SetTextColor(Color(255, 255, 255, 255))
    ButtonRight:SetPos(160, 45)
    ButtonRight:SetSize(125, 75)
    ButtonRight:SetFont("cswep")
    ButtonRight.Paint = function (self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 210))
    end

    ButtonLeft.DoClick = function()
        local ply = LocalPlayer()
        ClientTreePos = WeaponTree.LeftChild(ClientTreePos)
        
        net.Start("answergui")
        net.WritePlayer(ply)
        net.WriteString(WeaponTree.CurrentWeapon(ClientTreePos))
        net.WriteEntity(smokescreen)
        net.SendToServer()

        Frame:Close()
    end

    ButtonRight.DoClick = function()
        local ply = LocalPlayer()
        ClientTreePos = WeaponTree.RightChild(ClientTreePos)
        
        net.Start("answergui")
        net.WritePlayer(ply)
        net.WriteString(WeaponTree.CurrentWeapon(ClientTreePos))
        net.WriteEntity(smokescreen)
        net.SendToServer()

        Frame:Close()
    end
end)