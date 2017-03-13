
// Shared; include files;
local jobs = "gamemode/jobs/"
local files, folders = file.Find(jobs.."*.lua", "LUA")

for k, v in pairs(files) do
    include(jobs..v)
end

local GM = GM or GAMEMODE
// functions//
DeriveGamemode("sandbox")

local worldrp_func_sh = {};
job_db = {};
function GM:LoadJob(tbl)
	job_db[tbl.ID] = tbl
	team.SetUp(tbl.ID, tbl.Name, tbl.Color)
	MsgC(Color(255, 0, 0, 255), "[WorldRP] ", Color(255, 255, 255, 255), "Loaded job: "..tbl.Name.."\n")
end

TEAM_CITIZEN = 1
TEAM_POLICE = 2