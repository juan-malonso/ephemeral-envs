-- plugins/kong-plugin-stdout-log/handler.lua
local kong  = kong
local cjson = require "cjson.safe"

local PLUGIN = { PRIORITY = 5, VERSION = "0.1.0" }

function PLUGIN:log(conf)
  local data = kong.log.serialize({
    request = { body = conf.include_req_body and kong.request.get_raw_body() or nil }
  })
  local line = cjson.encode(data)

  if     conf.log_level == "debug"  then kong.log.debug(line)
  elseif conf.log_level == "info"   then kong.log.info(line)
  elseif conf.log_level == "warn"   then kong.log.warn(line)
  elseif conf.log_level == "err"    then kong.log.err(line)
  else                                    kong.log.notice(line)
  end
end

return PLUGIN