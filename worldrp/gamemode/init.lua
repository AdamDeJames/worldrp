

// Init file; including files

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("sv_sql.lua")
include("shared.lua")
include("sv_config.lua")

// Networking
util.AddNetworkString("Start_Loading")


// Serverside; functions; tables; etc

local worldrp_func = {}

function worldrp_func.PlayerFirstSpawn(ply)
	ply:SetNWBool("worldrp_loaded", false)
	ply:Freeze(true);
	net.Start("Start_Loading")
		net.WriteInt(1, 32)
	net.Send(ply)

	if(ply:SteamID()== worldrp_sv_c.Owner) then
		ply:SetUserGroup("superadmin")
	end
end
hook.Add("PlayerInitialSpawn", "aaa", worldrp_func.PlayerFirstSpawn)