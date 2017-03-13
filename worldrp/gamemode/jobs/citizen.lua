
//

local wrp_job = {};

wrp_job.ID = 1
wrp_job.Name = "Citizen"
wrp_job.Cmd = "citizen"
wrp_job.Salary = 50
wrp_job.Color = Color(0, 230, 0, 255)
wrp_job.Description = [[You are a citizen. You either  get a job, or you can become a criminal as your occupation.]]
wrp_job.ReqKarma = 0
wrp_job.DefaultWeapons = {}
GM:LoadJob(wrp_job)