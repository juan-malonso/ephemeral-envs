-- plugins/kong-plugin-stdout-log/schema.lua
local typedefs = require "kong.db.schema.typedefs"

return {
  name = "stdout-log",  -- ¡coincide con la carpeta y con KONG_PLUGINS!
  fields = {
    { consumer  = typedefs.no_consumer },       -- reemplaza no_consumer=true
    { protocols = typedefs.protocols_http },    -- o typedefs.protocols_with_stream si quieres TCP/UDP
    { config = {
        type = "record",
        fields = {
          { log_level = { type = "string", default = "notice",
                          one_of = { "debug","info","notice","warn","err" } } },
          { include_req_body = { type = "boolean", default = false } },
        },
      },
    },
  },
}