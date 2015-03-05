gl.setup(1280, 144)

logo = resource.load_image("wc-logo.png")
font = resource.load_font("Montserrat-Regular.otf")

function node.render()
	gl.clear(0, 0, 0, 1)
	logo:draw(44, 22, 148, 122)
	font:write(200, 47, "WebCamp 2015", 56, 1, 1, 1, 1)
end
