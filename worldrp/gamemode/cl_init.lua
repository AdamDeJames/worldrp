
// Clientside files; including files

include("shared.lua")

local worldrp_cl = {};

function worldrp_cl.SendScreen()
	//if(net.ReadInt() == 1) then
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
			frame:Close();
		end)
	//end
end
net.Receive("Start_Loading", worldrp_cl.SendScreen())