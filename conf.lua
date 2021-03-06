-- Configuration
function love.conf(t)
	t.title = "Project Alien Smasher" -- The title of the window the game is in (string)
	t.author = "UniversalRed"        -- The author of the game (string)
	t.window.width = 750        -- we want our game to be long and thin.
	t.window.height = 500
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
	t.modules.thread = true
    t.modules.physics = true    -- Enable the physics module (boolean)
	t.console = false	-- For Windows debugging
end
