

// Init file; including files

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("sh_config.lua")

include("sv_sql.lua")
include("shared.lua")
include("sv_config.lua")
include("sv_player.lua")
include("sh_config.lua")

local jobs = "gamemodes/worldrp/gamemode/jobs/"

local files, folders = file.Find(jobs.."*.lua", "GAME") or {}

for k, v in pairs(files) do
    include("jobs/"..v)
end

//
//

// Networking
util.AddNetworkString("Start_Loading")


// Serverside; functions; tables; etc

local worldrp_func = {}

function worldrp_func.ServerInit()
	game.ConsoleCommand("sbox_godmode 0\n")
	game.ConsoleCommand("sbox_noclip 0\n")
end
hook.Add("Initialize", "SetCvars", worldrp_func.ServerInit)

function worldrp_func.PlayerFirstSpawn(ply)
	ply:SetNWBool("worldrp_loaded", false)
	ply:Freeze(true);
	//net.Start("Start_Loading")
		//net.WriteInt(1, 32)
	//net.Send(ply)

	if(ply:SteamID()== worldrp_sv_c.Owner) then
		ply:SetUserGroup("superadmin")
	end
	ply:LoadData();
end
hook.Add("PlayerInitialSpawn", "aaa", worldrp_func.PlayerFirstSpawn)

function worldrp_func.PlayerSpawned(ply)
	local cpos = ply:GetPos()
	print(cpos);
	local q1 = "SELECT * FROM spawnpoints WHERE job = '"..ply:Team().."';"
	GetDBConnection():Query(q1, function(result)
		PrintTable(result)
		if(result or #result > 0) then
			ply:SetPos(Vector(result[math.random(1, #result)]))
		end
	end)
	if(ply:GetNWBool("worldrp_loaded")) then
		if(ply:GetNWBool("worldrp_closed")) then return end
		//ply:ConCommand("Remove_Menu")
	end
end
hook.Add("PlayerSpawn", "aaa2", worldrp_func.PlayerSpawned)

function GM:OnPlayerChangedTeam(ply, old, new)
	ply:SetNWString("worldrp_jobname", team.GetName(new))
	ply:SetNWInt("worldrp_salary", job_db[new].Salary)
end

function worldrp_func.Loadout(ply)
	for k, v in pairs(job_db[ply:Team()].DefaultWeapons) do
		ply:Give(v)
	end

	for k, v in pairs(worldrp_sh_c.DefaultWeps) do
		ply:Give(v)
	end

	return true
end
hook.Add("PlayerLoadout", "defaultweaponsreeroo", worldrp_func.Loadout)

concommand.Add("aaaa", function()
	for k, v in pairs(player.GetAll()) do
		print(job_db[v:Team()].Name)
	end
end)

timer.Simple(30, function()
	for k, v in pairs(player.GetAll()) do
		v:SaveData()
	end
end)