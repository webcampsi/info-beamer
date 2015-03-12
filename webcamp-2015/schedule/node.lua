gl.setup(1920, 864)

local json = require"json"
local base_time = N.base_time or 0

util.data_mapper{
	["clock/set"] = function(time)
		base_time = tonumber(time) - sys.now()
		N.base_time = base_time
		print("UPDATED TIME", base_time)
	end;
}

util.file_watch("schedule.json", function(content)
	talks = json.decode(content)
end)

function node.render()

end