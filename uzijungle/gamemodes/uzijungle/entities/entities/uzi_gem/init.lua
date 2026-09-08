AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")
include("cl_init.lua")

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.spotlight = ents.Create("point_spotlight")
    self.spotlight:SetPos(self:GetPos())
    self.spotlight:SetKeyValue("SpotlightLength", "2000")
    self.spotlight:SetKeyValue("SpotlightWidth", "25")
    self.spotlight:SetKeyValue("rendercolor", "246 65 36")
    self.spotlight:SetAngles(Angle(-90, 0, 0))
    self.spotlight:SetKeyValue("IgnoreSolid", "1")
    self.spotlight:Spawn()
    self.spotlight:SetParent(self)
    self.spotlight:Activate()
    self.spotlight:Fire("LightOn")
    self:SetKeyValue("targetname", "gem")

    timer.Simple(0, function()
        self:MoveGem()
    end)
end

function ENT:Use(caller, activator)
    if (activator:IsPlayer()) then
        if SERVER then
            
            
            local smokescreen = ents.Create("env_steam")
            smokescreen:SetPos(activator:GetPos())
            smokescreen:SetKeyValue("Type", "0")
            smokescreen:SetKeyValue("JetLength", "76")
            smokescreen:SetKeyValue("Speed", 60)
            smokescreen:SetKeyValue("StartSize", 10)
            smokescreen:SetKeyValue("EndSize", 25)
            smokescreen:SetKeyValue("Rate", 26)
            smokescreen:SetAngles(Angle(-90, 0, 0))
            smokescreen:Spawn()
            smokescreen:Activate()

            
            activator:GodEnable()
            timer.Simple(0, function()
                net.Start("opengui")
                net.WriteEntity(smokescreen)
                net.Send(activator)
            end)

            self:MoveGem()
        end

        
    end

end

function ENT:MoveGem()
    local gem_pos_table = ents.FindByName('gemloc')

    self:SetNoDraw(true)
    self.spotlight:Fire("LightOff")

    timer.Simple(0, function()
        self:SetPos(gem_pos_table[math.random(1, #gem_pos_table)]:GetPos())
    end)

    local gem = self
    timer.Simple(GetConVar("uzi_gemwaittime"):GetFloat(), function()
        gem:SetNoDraw(false)
        gem.spotlight:Fire("LightOn")
    end)
end