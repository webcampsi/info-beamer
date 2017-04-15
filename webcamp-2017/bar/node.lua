gl.setup(1920, 216)

logo = resource.load_image("wc-logo.png")
font = resource.load_font("OpenSans-Regular.ttf")

function node.render()
	gl.clear(1, 1, 1, 0.5)
	logo:draw(66, 33, 763, 182)
end
