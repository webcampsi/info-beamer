gl.setup(1920, 1080)

background = resource.load_image("wc-background.png")

function node.render()
	util.draw_correct(background, 0, 0, WIDTH, HEIGHT)

	local bar = resource.render_child("bar")
	bar:draw(0, 0, 1919, 215)

	local sponsors = resource.render_child("sponsors")
	sponsors:draw(0, 792, 1919, 1079)

	local schedule = resource.render_child("schedule")
	schedule:draw(0, 216, 1919, 1079)
end
