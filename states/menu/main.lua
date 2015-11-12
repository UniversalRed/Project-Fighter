function load()
	love.graphics.setBackgroundColor( 190, 190, 190 )
	imgPlay = love.graphics.newImage("assets/play.png")
	imgPlayOn = love.graphics.newImage("assets/play_on.png")
	imgExit = love.graphics.newImage("assets/exit.png")
	imgExitOn = love.graphics.newImage("assets/exit_on.png")
	imgOptions = love.graphics.newImage("assets/options.png")
	imgOptionsOn = love.graphics.newImage("assets/options_on.png")
	
	buttons = {
		{imgOff = imgPlay, imgOn = imgPlayOn, x = 64, y = 96, w = 128, h = 64, action = "play"},
		{imgOff = imgOptions, imgOn = imgOptionsOn, x = 64, y = 96 + 64, w = 128, h = 64, action = "options"},
		{imgOff = imgExit, imgOn = imgExitOn, x = 64, y = 96 + 128, w = 128, h = 64, action = "exit"}
	}
end

local function drawButton(off, on, x, y, w, h, mx, my)
	local ins = insideBox( mx, my, x - (w/2), y - (h/2), w, h )
	
	love.graphics.setColor( 255, 255, 255, 255 )
	
	if ins then
		love.graphics.draw( on, x, y, 0, 1, 1, (w/2), (h/2) )
	else
		love.graphics.draw( off, x, y, 0, 1, 1, (w/2), (h/2) )
	end
end

function love.draw()
	local x = love.mouse.getX( )
	local y = love.mouse.getY( )

	for k, v in pairs(buttons) do
		drawButton( v.imgOff, v.imgOn, v.x, v.y, v.w, v.h, x, y )
	end
	
	love.graphics.setColor( 127, 0, 0, 255 )
	love.graphics.print ("Project Alien Smasher", 400, 50, 0, 2, 2)
	love.graphics.print ("A project made by UniversalRed", 600, 950, 0, 2, 2)
end

function love.update(dt)
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
end

function love.keyreleased( key, unicode )
	
end

function love.mousepressed( x, y, button )
	if button == "l" then
		for k, v in pairs(buttons) do
			local ins = insideBox( x, y, v.x - (v.w/2), v.y - (v.h/2), v.w, v.h )
			
			if ins then
				if v.action == "play" then
					loadState("game")
				elseif v.action == "exit" then
					love.event.quit()
				end
			end
		end
	end
end

function love.mousereleased( x, y, button )
end

function love.quit()
end

function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end