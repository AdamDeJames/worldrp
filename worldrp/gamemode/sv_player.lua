/// SV metatable
local meta = FindMetaTable("Player")

include("sv_config.lua");
function meta:CreateData()
  local q1 = "INSERT INTO `players` (`steamname`, `steamid`, `money`, `playtime`, `inventory`) VALUES ('"..mysqle(self:Name()).."', '"..self:SteamID().."', '"..worldrp_sh_c.DefaultCash.."', '0', '"..mysqle(unpack(worldrp_sh_c.DefaultInv)).."');"
  print(q1)
  GetDBConnection():Query(q1, function(result)
    self:LoadData();
    if(worldrp_sv_c.Debug) then
      MsgC(Color(255, 0, 0, 255), "[WorldRP Debug] ", Color(255, 255, 255, 255), "Player "..self:Name().."'s data was created.")
    end
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
      self:SetTeam(TEAM_CITIZEN)
      self:KillSilent()
      if(worldrp_sv_c.Debug) then
        MsgC(Color(255, 0, 0, 255), "[WorldRP Debug] ", Color(255, 255, 255, 255), "Player "..self:Name().."'s data has been loaded.")
      end
    end
  end)
end

function meta:SaveData()
  local money = self:GetMoney()
  local playtime = "1"
  local id = self:SteamID()
  local name = mysqle(self:Name())
  local q1 = "UPDATE `players` SET money='"..money.."', playtime='"..playtime.."', steamname='"..name.."' WHERE steamid = '"..id.."';"
  GetDBConnection():Query(q1, function(results)
    if(worldrp_sv_c.Debug) then
      MsgC(Color(255, 0, 0, 255), "[WorldRP Debug] ", Color(255, 255, 255, 255), "Data saved.")
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

function meta:Notify(str, time)
  if(type(str) == "table") then
    str = unpack(str)
  end
  net.Start("worldrp_notify")
    net.WriteString(str)
    net.WriteFloat(time)
  net.Send(self)
end

function meta:GetKarma()
  return self:GetNWFloat("wrp_karma") or 0
end

function meta:SetKarma(int)
  self:SetNWFloat("wrp_karma", int)
end