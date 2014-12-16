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
	solve = "none"
	capacitance = 180
	frequency = 0.400
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
	elseif mode == "frequency" then
		frequency = frequency ..t
	elseif mode == "capacitance" then
		capacitance = capacitance ..t
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
	elseif mode == "frequency" then
		if key == "backspace" then
			local len = string.len(frequency)
			local result = string.sub(frequency,1,len-1)
			frequency = result
		end
	elseif mode == "capacitance" then
		if key == "backspace" then
			local len = string.len(capacitance)
			local result = string.sub(capacitance,1,len-1)
			capacitance = result
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
			mode = "none"
		elseif (x>=100 and x<=300) and (y>=140 and y<=160) then
			screen = "frequency"
			solve = "none"
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
	if screen == "frequency" then
		if (x>=150 and x<=250) and (y>=50 and y<=70) then
			solve = "frequency"
		elseif (x>=150 and x<=250) and (y>=90 and y<=110) then
			solve = "capacitance"
		elseif (x>=150 and x<=250) and (y>=130 and y<=150) then
			solve = "inductance"
		end
		if solve == "frequency" then
			if (x>=150 and x<=250) and (y>=200 and y<=220) then
				mode = "inductance"
			elseif (x>=150 and x<=250) and (y>=240 and y<=260) then
				mode = "capacitance"
			elseif (x>=150 and x<=250) and (y>=300 and y<=320) then
				calcTrio()
			end
		elseif solve == "capacitance" then
			if (x>=150 and x<=250) and (y>=200 and y<=220) then
				mode = "inductance"
			elseif (x>=150 and x<=250) and (y>=240 and y<=260) then
				mode = "frequency"
			elseif (x>=150 and x<=250) and (y>=300 and y<=320) then
				calcTrio()
			end
		elseif solve == "inductance" then
			if (x>=150 and x<=250) and (y>=200 and y<=220) then
				mode = "frequency"
			elseif (x>=150 and x<=250) and (y>=240 and y<=260) then
				mode = "capacitance"
			elseif (x>=150 and x<=250) and (y>=300 and y<=320) then
				calcTrio()
			end
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
		love.graphics.print("Gauge (8-56)",200-(getWidth("Gauge")/2),85)
		love.graphics.print(gauge,200-(getWidth(gauge)/2),105)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",150,140,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Inductance (uh)",200-(getWidth("Inductance")/2),125)
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
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",150,50,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Frequency",200-(getWidth("Frequency")/2),55)
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",150,90,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Capacitance",200-(getWidth("Capacitance")/2),95)
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",150,130,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Inductance",200-(getWidth("Inductance")/2),135)
		if solve == "frequency" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,50,100,20)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,200,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Inductance (uh)",200-(getWidth("Inductance (uh)")/2),185)
			love.graphics.print(inductance,200-(getWidth(inductance)/2),205)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,240,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Capacitance (pF)",200-(getWidth("Capacitance (pF)")/2),225)
			love.graphics.print(capacitance,200-(getWidth(capacitance)/2),245)
			if mode == "inductance" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,200,100,20)
			elseif mode == "capacitance" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,240,100,20)
			end
			love.graphics.setColor(0,0,0)
			love.graphics.print("Frequency: " ..frequency .."MHz",200-(getWidth("Frequency: " ..frequency .."MHz")/2),400)
		elseif solve == "capacitance" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,90,100,20)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,200,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Inductance (uh)",200-(getWidth("Inductance (uh)")/2),185)
			love.graphics.print(inductance,200-(getWidth(inductance)/2),205)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,240,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Frequency (MHz)",200-(getWidth("Frequency (MHz)")/2),225)
			love.graphics.print(frequency,200-(getWidth(frequency)/2),245)
			if mode == "inductance" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,200,100,20)
			elseif mode == "frequency" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,240,100,20)
			end
			love.graphics.setColor(0,0,0)
			love.graphics.print("Capacitance: " ..capacitance .."pF",200-(getWidth("Capacitance: " ..capacitance .."pF")/2),400)
		elseif solve == "inductance" then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",150,130,100,20)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,200,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Frequency (MHz)",200-(getWidth("Frequency (MHz)")/2),185)
			love.graphics.print(frequency,200-(getWidth(frequency)/2),205)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",150,240,100,20)
			love.graphics.setColor(0,0,0)
			love.graphics.print("Capacitance (pF)",200-(getWidth("Capacitance (pF)")/2),225)
			love.graphics.print(capacitance,200-(getWidth(capacitance)/2),245)
			if mode == "frequency" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,200,100,20)
			elseif mode == "capacitance" then
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line",150,240,100,20)
			end
			love.graphics.setColor(0,0,0)
			love.graphics.print("Inductance: " ..inductance .."uh",200-(getWidth("Inductance: " ..inductance .."uh")/2),400)
		end
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",150,300,100,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Calculate",200-(getWidth("Calculate")/2),305)
	end
	if screen ~= "main" then
		love.graphics.setColor(150,150,150)
		love.graphics.rectangle("fill",20,20,50,20)
		love.graphics.setColor(0,0,0)
		love.graphics.print("Back",45-(getWidth("Back")/2),25)
	end
end
