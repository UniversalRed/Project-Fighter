UI = require 'Thranduil/UI'

player = {x = love.window.getWidth()/2 - 75, y = love.window.getHeight() - 100, speed = 100, img = nil}
isAlive = true
canShoot = true
canShootTimerMax = 0.5
canShootTimer = canShootTimerMax
bulletImg = nil
bullets = {}
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax
enemyImg = {}
enemies = {}
score = 0
isFocused = false
gameStart = false

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function load ()
	player.img = love.graphics.newImage ("assets/fighter.png")
	bulletImg = love.graphics.newImage ("assets/fighter_missile.png")
	enemyImg[1] = love.graphics.newImage ("assets/alien_ship_green.png")
	enemyImg[2]= love.graphics.newImage ("assets/alien_ship_blue.png")
	enemyImg[3] = love.graphics.newImage ("assets/alien_ship_red.png")
	music = love.audio.newSource("assets/Project Fighter Song.mp3")

	UI.registerEvents()
end

function love.update (dt)

	if dt < 1/30 then
		love.timer.sleep(1/30 - dt)
	end

	if love.keyboard.isDown('q') then
		isFocused = true
	elseif (love.keyboard.isDown('e')) then
		isFocused = false
	end
	
	if (isFocused == false) then
		if love.keyboard.isDown('left','a') then
			if player.x > 0 then
				player.x = player.x - (player.speed*dt)
			end
		elseif love.keyboard.isDown('right','d') then
			if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
				player.x = player.x + (player.speed*dt)
			end
		--elseif love.keyboard.isDown('up','w') then
		--	if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
		--		player.y = player.y - (player.speed*dt)
		--	end
		--elseif love.keyboard.isDown('down','s') then
		--	if player.y < (love.graphics.getHeight() + player.img:getHeight()) then
		--		player.y = player.y + (player.speed*dt)
		--	end
		end 
	
		-- Boundaries
		if (player.x < 0) then
			player.x = 0
		end	
		if (player.y < 0) then
			player.y = 0
		end
		if (player.x > love.window.getWidth()) then
			player.x = love.window.getWidth()
		end	
		if (player.y > love.window.getHeight()) then
			player.y = love.window.getHeight()
		end
	
		canShootTimer = canShootTimer - (1 * dt)
		if isAlive == false then
			canShoot = false
		elseif canShootTimer < 0 then
			canShoot = true
		end
	
		if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
			-- Create some bullets
			newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
			table.insert(bullets, newBullet)
			canShoot = false
			canShootTimer = canShootTimerMax
		end
	
		for i, bullet in ipairs(bullets) do
			bullet.y = bullet.y - (250 * dt)
			if bullet.y < 0 then -- remove bullets when they pass off the screen
				table.remove(bullets, i)
			end
		end
	
		createEnemyTimer = createEnemyTimer - (1 * dt)
		if createEnemyTimer < 0 then
			createEnemyTimer = createEnemyTimerMax
			-- Create an enemy
			randomNumber = math.random(10, love.graphics.getWidth() - 10)
			newEnemy = { x = randomNumber, y = -10, img = enemyImg[1] }
			table.insert(enemies, newEnemy)
		end
		
		for i, enemy in ipairs(enemies) do
			enemy.y = enemy.y + (200 * dt)
		
			if enemy.y > love.window.getHeight() - 25 then -- remove enemies when they pass off the screen
				table.remove(enemies, i)
			end
		end
	
		for i, enemy in ipairs(enemies) do
			for j, bullet in ipairs(bullets) do
				if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
					table.remove(bullets, j)
					table.remove(enemies, i)
					score = score + 1
				end
			end
	
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
			and isAlive then
				table.remove(enemies, i)
				isAlive = false
			end
		end
	end
	if not isAlive and love.keyboard.isDown('r') then
		bullets = {}
		enemies = {}
	
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax
	
		player.x = love.window.getWidth()/2 - 75
		player.y = love.window.getHeight() - 100
	
		score = 0
		isAlive = true
	end

	if (isFocused == false) then
		music:play()
	end

	if (gameStart == false) then
		if (isFocused == false) then
			isFocused = true
		end
		love.timer.sleep (3)
		gameStart = true
		isFocused = false
	end

end

function love.focus(bool)
	if (bool) then
		isFocused = false
	else
		isFocused = true
	end
end

function love.draw ()
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.setBackgroundColor( 0, 0, 0 )

	if (isAlive == true) then
			love.graphics.draw (player.img, player.x, player.y)
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10, 0, 2, 2)
		for i, bullet in ipairs(bullets) do
			table.remove(bullets, i)
		end
	end
	
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bulletImg, bullet.x, bullet.y)
	end
	
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	
	love.graphics.print ("FPS: ".. love.timer.getFPS(), 0, 0)
	love.graphics.print ("Score: ".. score, 0, 10)
end