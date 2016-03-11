gl.setup(1920, 216)

logo = resource.load_image("wc-logo.png")
font = resource.load_font("Montserrat-Regular.otf")

function node.render()
	gl.clear(0, 0, 0, 1)
	logo:draw(66, 33, 237, 182)
	font:write(300, 71, "WebCamp 2016", 84, 1, 1, 1, 1)
end
