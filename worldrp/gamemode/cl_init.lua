
// Clientside files; including files

include("shared.lua")
include("cl_hud.lua")
include("sh_config.lua")

local worldrp_cl = {};

function worldrp_cl.SendScreen()
	//if(net.ReadInt() == 1) then
	if(LocalPlayer():GetNWBool("worldrp_loaded") == true) then return end
		local frame = vgui.Create("DFrame");
			frame:SetPos(0, 0)
			frame:ShowCloseButton(false)
			frame:SetTitle("");
			frame:SetDraggable(false)
			frame:SetSize(ScrW(), ScrH())
			function frame:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			end
		concommand.Add("Remove_menu", function()
			if(LocalPlayer():GetNWBool("worldrp_loaded") != true) then return end
			LocalPlayer():SetNWBool("worldrp_closed", true)
			frame:Close();
		end)
	//end
end
//net.Receive("Start_Loading", worldrp_cl.SendScreen())

function worldrp_cl.F4Menu()
	local ply = LocalPlayer()

	local frame = vgui.Create("DFrame");
		frame:SetSize(ScrW()/2, ScrH()-50)
		frame:Center()
		frame:SetDraggable(false)
		frame:MakePopup()
end
concommand.Add("test_f4", worldrp_cl.F4Menu)