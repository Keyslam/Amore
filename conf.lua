local lldebuggerPatcher = require("localLuaDebuggerPatch")
lldebuggerPatcher.start()

function love.errorhandler(msg)
	error(msg, 2)
end

function love.conf(t)
	t.modules.window   = false
	t.modules.graphics = false
	t.modules.audio    = false
end
