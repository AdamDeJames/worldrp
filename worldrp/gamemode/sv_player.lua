/// SV metatable
local meta = FindMetaTable("Player")

include("sv_config.lua");
function meta:CreateData()
  local q1 = "INSERT INTO `players` (`steamname`, `steamid`, `money`, `playtime`, `inventory`) VALUES ('"..mysqle(self:Name()).."', '"..self:SteamID().."', '"..worldrp_sh_c.DefaultCash.."', '0', '"..mysqle(unpack(worldrp_sh_c.DefaultInv)).."');"
  print(q1)
  GetDBConnection():Query(q1, function(result)
    self:LoadData();
  end)
end

function meta:LoadData()
  local q1 = "SELECT * FROM players WHERE steamid = '"..GetDBConnection():escape(self:SteamID()).."';"
  GetDBConnection():Query(q1, function(result)
    PrintTable(result)
    if(not result or #result <= 0) then
      self:CreateData()
    else
      result = result[1]
      print(result.money)
      self:SetNWInt("worldrp_cash", result.money)
      self:SetNWInt("worldrp_playtime", CurTime() - result.playtime)
      self:SetNWBool("worldrp_loaded", true)
      self:KillSilent()
    end
  end)
end

function meta:GetMoney()
  return self:GetNWInt("worldrp_cash");
end

function meta:GiveMoney(int)
  if(int == 0) then
    return
  end
  self:SetNWInt("worldrp_cash", self:GetMoney() + int)
end