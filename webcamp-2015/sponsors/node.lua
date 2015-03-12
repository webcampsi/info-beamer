local INTERVAL = 10

local SWITCH_DELAY = 3

gl.setup(960, 288)

function is_valid_image(name)
	return name:match(".*png")
end

pictures = util.generator(function()
	local out = {}
	for name, _ in pairs(CONTENTS) do
		if is_valid_image(name) then
			out[#out + 1] = name
		end
	end
	return out
end)

node.event("content_remove", function(filename)
	print("image removed ", filename)
	pictures:remove(filename)
end)

node.event("content_update", function(filename)
	if is_valid_image(filename) then
		print("image added ", filename)
		pictures:add(filename)
	end
end)

util.set_interval(INTERVAL, function()
	local next_image_name = pictures.next()
	print("now loading " .. next_image_name)
	last_image = current_image
	current_image = resource.load_image(next_image_name)
	fade_start = sys.now() + SWITCH_DELAY
end)

function node.render()
	gl.clear(1, 1, 1, 0.5)
	local delta = sys.now() - fade_start
	if last_image and delta < 0 then
		util.draw_correct(last_image, 0, 0, 960, 288)
	elseif last_image and delta < 1 then
		util.draw_correct(last_image, 0, 0, 960, 288, 1 - delta)
		util.draw_correct(current_image, 0, 0, 960, 288, delta)
	else
		if last_image then
			last_image:dispose()
			last_image = nil
		end
		util.draw_correct(current_image, 0, 0, 960, 288)
	end
end
