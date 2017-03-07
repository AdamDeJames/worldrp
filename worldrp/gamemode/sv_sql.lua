/// SQL
require("mysqloo")
include("sv_config.lua")

local db = mysqloo.connect(worldrp_sv_c.Host, worldrp_sv_c.User, worldrp_sv_c.Password, worldrp_sv_c.Db)
 
function GetDBConnection()
  return db or nil;
end

function mysqle(str)
	if(type(str) != "string") then
		return GetDBConnection():escape(tostring(str))
	elseif(type(str) == "string") then
		return GetDBConnection():escape(str)
	end
end
 
function db.onConnected()
	if(worldrp_sv_c.Debug == true) then
  		MsgC(Color(255, 0, 0, 255), "[Worldrp Debug] ", Color(255, 255, 255, 255), "Connection to the database finished!\n")
  	end
end
 
function db.onConnectionFailed(err)
	if(worldrp_sv_c.Debug == true) then
  		MsgC(Color(255, 0, 0, 255), "[Worldrp Debug] ", Color(255, 255, 255, 255), "connection to the database failed! Error:\n"..unpack(err))
  	end
end
 
 
function db:Query(query, callback, test)
  if !query then
    print("Error executing query, no query specified.")
    return
  else
 
    local q = db:query(query)
 
    if !q then return end
    function q:onSuccess(data)
      if callback then callback(data) end
    end
 
    function q:onError(err, qur)
      print("Error executing query, Error: "..err..", Query: "..qur)
      if (!db or db:status() == mysqloo.DATABASE_NOT_CONNECTED) then
        db:connect()
      end
    end
 
    q:start()
    return q:getData()
  end
end
 
 
db:connect()