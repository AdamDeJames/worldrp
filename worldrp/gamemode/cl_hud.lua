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
	wrp_hud.Wep1 = LocalPlayer():GetActiveWeapon()


	// Base Frame
	draw.RoundedBox(4, 0, ScrH()-185, 300, 300, Color(10, 10, 10, 200))
	//draw.RoundedBox(4, 95, ScrH()-180, 100, 20, Color(10, 10, 10, 230))
	draw.SimpleText("WorldRP", "ChatFont", 110, ScrH()-180, Color(255, 255, 255, 255))

	// Print RP name -- note does not work yet, will default to steam name
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material("icon16/user.png"))
	surface.DrawTexturedRect(10, ScrH()-150, 16, 16)
	if(not LocalPlayer():GetNWString("worldrp_rpname") or LocalPlayer():GetNWString("worldrp_rpname") == "") then
		draw.SimpleText("Name: "..LocalPlayer():Name(), "ChatFont", 30, ScrH()-150, Color(255, 255, 255, 255))
	end
	// Money
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(Material("icon16/money.png"))
	surface.DrawTexturedRect(10, ScrH()-130, 16, 16)
	draw.SimpleText("Wallet: $", "ChatFont", 30, ScrH()-130, Color(255, 255, 255, 255))
	draw.SimpleText(tostring(LocalPlayer():GetNWInt("worldrp_cash")), "ChatFont", 100, ScrH()-130, Color(0, 255, 0, 255))
end
hook.Add("HUDPaint", "paintthehudufuck", wrp_hud.DrawHud)