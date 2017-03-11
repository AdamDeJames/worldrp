/// HUD File -- Clientside

local wrp_hud = {}

local wrp_nohud = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if(wrp_nohud[name]) then return false end
end)


function wrp_hud.DrawHud()
    wrp_hud.HP = LocalPlayer():Health()
    wrp_hud.Arm = LocalPlayer():Armor()
    if(IsValid(LocalPlayer():GetActiveWeapon())) then
        wrp_hud.Wep1 = LocalPlayer():GetActiveWeapon()
    end


    // Base Frame
    draw.RoundedBox(4, 0, ScrH()-150, 330, 150, Color(10, 10, 10, 200))
    //draw.RoundedBox(4, 95, ScrH()-180, 100, 20, Color(10, 10, 10, 230))
    //draw.SimpleText(string.sub(GetHostName(), 1, 25), "ChatFont", ScrW()-1800, ScrH()-180, Color(255, 255, 255, 255))

    // Print RP name
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("icon16/user.png"))
    surface.DrawTexturedRect(ScrW()-1910, ScrH()-130, 16, 16)
    draw.SimpleText("Name: "..string.sub(LocalPlayer():Nick(), 1, 20), "ChatFont", ScrW()-1890, ScrH()-130, Color(255, 255, 255, 255))

    // Money
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(Material("icon16/money.png"))
    surface.DrawTexturedRect(ScrW()-1910, ScrH()-110, 16, 16)
    draw.SimpleText("Wallet:", "ChatFont", ScrW()-1890, ScrH()-110, Color(255, 255, 255, 255))
    draw.SimpleText(LocalPlayer():GetNWInt("worldrp_cash"), "ChatFont", ScrW()-1830, ScrH()-110, Color(0, 255, 0, 255))

    //Salary
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(Material("icon16/money_add.png"))
    surface.DrawTexturedRect(ScrW()-1910, ScrH()-90, 16, 16)
    draw.SimpleText("Error", "ChatFont", ScrW()-1890, ScrH()-90, Color(255, 255, 255, 255))

    //Job
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(Material("icon16/wrench.png"))
    surface.DrawTexturedRect(ScrW()-1910, ScrH()-70, 16, 16)
    draw.SimpleText("Occupation: "..team.GetName(LocalPlayer():Team()), "Chatfont", ScrW()-1890, ScrH()-70)
    // Health
    draw.RoundedBox(4, ScrW()-1920, ScrH()-180, 110, 30, Color(10, 10, 10, 200))
    draw.RoundedBox(4, ScrW()-1915, ScrH()-175, wrp_hud.HP, 20, Color(187, 37, 0, 255))
    draw.SimpleText("Health: "..wrp_hud.HP,"ChatFont", ScrW()-1910, ScrH()-175, Color(255, 255, 255, 255))

    // Armor
    if(wrp_hud.Arm > 0) then
        draw.RoundedBox(4, ScrW()-1810, ScrH()-180, 110, 30, Color(10, 10, 10, 200))
        draw.RoundedBox(4, ScrW()-1805, ScrH()-175, math.Clamp(wrp_hud.Arm, 0, 100), 20, Color(0, 0, 150, 255))
        draw.SimpleText("Armor: "..wrp_hud.Arm,"ChatFont", ScrW()-1800, ScrH()-175, Color(255, 255, 255, 255))
    end

    // Ammo
    if(wrp_hud.Arm > 0) then
        if(LocalPlayer():Alive() != false and IsValid(wrp_hud.Wep1)) then
            if(wrp_hud.Wep1:GetPrimaryAmmoType() >= 0) then
                draw.RoundedBox(4, ScrW()-1700, ScrH()-180, 110, 30, Color(10, 10, 10, 200))
                draw.RoundedBox(4, ScrW()-1695, ScrH()-175, math.Clamp(wrp_hud.Wep1:Clip1() * 6, 2, 100), 20, Color(0, 0, 150, 255))
                if(wrp_hud.Wep1:Clip1() > 0) then
                    draw.SimpleText("Ammo: "..wrp_hud.Wep1:Clip1().."/"..LocalPlayer():GetAmmoCount(wrp_hud.Wep1:GetPrimaryAmmoType()),"ChatFont", ScrW()-1690, ScrH()-175, Color(255, 255, 255, 255))
                else
                    draw.SimpleText("No Ammo", "ChatFont", ScrW()-1690, ScrH()-175, Color(255, 255, 255, 255))
                end
            end
        end
    else
        draw.RoundedBox(4, ScrW()-1810, ScrH()-180, 110, 30, Color(10, 10, 10, 200))
        draw.RoundedBox(4, ScrW()-1805, ScrH()-175, math.Clamp(wrp_hud.Wep1:Clip1() * 6, 2, 100), 20, Color(0, 0, 150, 255))
        if(wrp_hud.Wep1:Clip1() > 0) then
             draw.SimpleText("Ammo: "..wrp_hud.Wep1:Clip1().."/"..LocalPlayer():GetAmmoCount(wrp_hud.Wep1:GetPrimaryAmmoType()),"ChatFont", ScrW()-1800, ScrH()-175, Color(255, 255, 255, 255))
        else
            draw.SimpleText("No Ammo", "ChatFont", ScrW()-1800, ScrH()-175, Color(255, 255, 255, 255))
        end
    end
end
hook.Add("HUDPaint", "paintthehudufuck", wrp_hud.DrawHud)