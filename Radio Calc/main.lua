require("formulas")

function love.load()
	love.window.setMode(400,600)
	love.window.setTitle("Radio Calculator")
	radio = love.image.newImageData("radio.png")
	love.window.setIcon(radio)
	love.graphics.setBackgroundColor(200,200,200)
	screen = "main"
	gauge = 30
	inductance = 250
	radius = 1
	mode = "none"
	coilLength = 0
	coilTurns = 0
	wireLength = 0
end

function love.update(dt)
	
end

function love.textinput(t)
	if mode == "gauge" then
		gauge = gauge ..t
	elseif mode == "inductance" then
		inductance = inductance ..t
	elseif mode == "radius" then
		radius = radius ..t
	end
end

function love.keypressed(key)
	if mode == "gauge" then
		if key == "backspace" then
			local len = string.len(gauge)
			local result = string.sub(gauge,1,len-1)
			gauge = result
		end
	elseif mode == "inductance" then
		if key == "backspace" then
			local len = string.len(inductance)
			local result = string.sub(inductance,1,len-1)
			inductance = result
		end
	elseif mode == "radius" then
		if key == "backspace" then
			local len = string.len(radius)
			local result = string.sub(radius,1,len-1)
			radius = result
		end
	end
end

function love.mousepressed(x,y,key)
	if screen ~= "main" then
		if (x>=20 and x<=70) and (y>=20 and y<=40) then
			screen = "main"
		end
	end
	if screen == "main" then
		if (x>=100 and x<=300) and (y>=100 and y<=120) then
			screen = "induction"
		elseif (x>=100 and x<=300) and (y>=140 and y<=160) then
			screen = "frequency"
		end
	end
	if screen == "induction" then
		if (x>=150 and x<=250) and (y>=100 and y<=120) then
			mode = "gauge"
		elseif (x>=150 and x<=250) and (y>=140 and y<=160) then
			mode = "inductance"
		elseif (x>=150 and x<=250) and (y>=180 and y<=200) then
			mode = "radius"
		elseif (x>=150 and x<=250) and (y>=220 and y<=240) then
			coilLength,coilTurns,wireLength = calcInduction()
		else
			mode = "none"
		end
	end
end

function getWidth(text)
	local font = love.graphics.getFont()
	local length = font:getWidth(text)
	return length
end

function love.draw()
	if screen == "main" then
		love.graphics.setColor(0,0,0)
		love.graphics.print("Radio Calculator",200-(getWidth("Radio Calculator")/2),15)
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",100,100,200,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Inductance of a Coil",200-(getWidth("Inductance of a Coil")/2),105)
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",100,140,200,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Resonant Frequency",200-(getWidth("Resonant Frequency")/2),145)
	elseif screen == "induction" then
		love.graphics.setColor(0,0,0)
		love.graphics.print("Inductance of a Coil",200-(getWidth("Inductance of a Coil")/2),15)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",150,100,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Gauge",200-(getWidth("Gauge")/2),85)
		love.graphics.print(gauge,200-(getWidth(gauge)/2),105)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",150,140,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Inductance",200-(getWidth("Inductance")/2),125)
		love.graphics.print(inductance,200-(getWidth(inductance)/2),145)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",150,180,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Core Radius",200-(getWidth("Core Radius")/2),165)
		love.graphics.print(radius,200-(getWidth(radius)/2),185)
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",150,220,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Calculate",200-(getWidth("Calculate")/2),225)
		love.graphics.print("Coil Length: " ..coilLength .." inches",200-(getWidth("Coil Length: " ..coilLength .." inches")/2),250)
		love.graphics.print("Number of Turns: ~" ..coilTurns .." turns",200-(getWidth("Number of Turns: " ..coilTurns .." turns")/2),270)
		love.graphics.print("You will need about " ..math.ceil(wireLength/12) .." feet of wire.",200-(getWidth("You will need about " ..math.ceil(wireLength/12) .." feet of wire.")/2),290)
		if mode == "gauge" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,100,100,20)
		elseif mode == "inductance" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,140,100,20)
		elseif mode == "radius" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,180,100,20)
		end
	elseif screen == "frequency" then
		love.graphics.setColor(0,0,0)
		love.graphics.print("Resonant Frequency",200-(getWidth("Resonant Frequency")/2),15)
	end
	if screen ~= "main" then
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",20,20,50,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Back",45-(getWidth("Back")/2),25)
	end
end
