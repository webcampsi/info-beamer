gl.setup(1920, 1080)

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

background = resource.load_image("wc-background.png")

function node.render()
	-- gl.clear(0, 0, 0, 1)
	util.draw_correct(background, 0, 0, WIDTH, HEIGHT)

	local bar = resource.render_child("bar")
	bar:draw(0, 0, 1919, 215)

	local sponsors = resource.render_child("sponsors")
	sponsors:draw(0, 792, 959, 1079)
end
