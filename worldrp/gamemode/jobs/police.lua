
//

local wrp_job = {};

wrp_job.ID = 2
wrp_job.Name = "Police Officer"
wrp_job.Cmd = "police"
wrp_job.Salary = 100
wrp_job.Color = Color(0, 0, 230, 255)
wrp_job.Description = [[You are a cop. You stop crime and make sure the citizens are in check.]]
wrp_job.ReqKarma = 50
wrp_job.DefaultWeapons = {"weapon_arrest_baton", "weapon_handcuffs", "tfa_hk45"}
GM:LoadJob(wrp_job)