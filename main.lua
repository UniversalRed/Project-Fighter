function clearLoveCallbacks()
	love.draw = nil
	love.joystickpressed = nil
	love.joystickreleased = nil
	love.keypressed = nil
	love.keyreleased = nil
	--love.load = nil
	love.mousepressed = nil
	love.mousereleased = nil
	love.update = nil
end

state = {}
function loadState(name)
	state = {}
	clearLoveCallbacks()
	local path = "states/" .. name
	require(path .. "/main")
	load()
end

function load()
end

function love.load()
	loadState("menu")
	
	icon = love.graphics.newImage("assets/fighter.png");
    icon64 = love.window.setIcon( icon:getData() );
end