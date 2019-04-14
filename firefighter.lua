local anim8 = require 'anim8'
local firefighter = {}
local fireball = {}

firefighter.load = function(arg)
	
	local firemanSprite = love.graphics.newImage('Sprites/firemen/fireman.png')
	local g = anim8.newGrid(64, 80, firemanSprite:getWidth(), firemanSprite:getHeight())
	
	fireman1 ={x = 600, y = 430, img = love.graphics.newImage('Sprites/firemen/fireman.png'), movement = (10*20), direction = "left", npcAnimation = nil,
		animations = {
			left = anim8.newAnimation(g('1-4',1), 0.1),
			right = anim8.newAnimation(g('1-4',2), 0.1),
			idle_left = anim8.newAnimation(g('1-1',1), 0.1),
			idle_right = anim8.newAnimation(g('1-1',2), 0.1)
		}
	}
	table.insert(firefighter, fireman1)
	
	canShoot = true
	canShootTimerMax = 0.05 
	canShootTimer = canShootTimerMax
	
	spriteimg = love.graphics.newImage('Sprites/fire.png')
	
	--[[firemanImg = love.graphics.newImage('Sprites/block.png')
	fireman = {x = 100, y = 300, img = firemanImg, movementSpeed = (10*40)}
	table.insert(fireguy, fireman)]]
	
end

firefighter.movement = function(dt)
	for i, currentnpc in ipairs(firefighter) do	
	
			if player.x < currentnpc.x then
				currentnpc.direction = "left"
			end
			if player.x > currentnpc.x then
				currentnpc.direction = "right"
			end
			
			if player.x < currentnpc.x - 100 and player.x >  currentnpc.x - 300 then
				currentnpc.npcAnimation = currentnpc.animations.left
				currentnpc.x = currentnpc.x - (currentnpc.movement*dt)
				
			elseif player.x + player.img:getWidth() > currentnpc.x + (100*2) and player.x <  currentnpc.x + 300 then
				currentnpc.npcAnimation = currentnpc.animations.right
				currentnpc.x = currentnpc.x + (currentnpc.movement*dt)
			else
				if currentnpc.direction == "left" then
					currentnpc.npcAnimation = currentnpc.animations.idle_left
				elseif currentnpc.direction == "right" then
					currentnpc.npcAnimation = currentnpc.animations.idle_right
				end
			end
			
			
			--[[	if currentnpc.direction == "left" then
					currentnpc.npcAnimation = currentnpc.animations.idle_left
				elseif currentnpc.direction == "right" then
					currentnpc.npcAnimation = currentnpc.animations.idle_right
				end
			end]]
			currentnpc.npcAnimation:update(dt)

	end
end

firefighter.hosefire = function(dt)
	count = 0
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
	  canShoot = true
	end
	
	for i, currentnpc in ipairs(firefighter) do
		if (player.x < currentnpc.x + 100*2 and player.x > currentnpc.x) and canShoot 
		and currentnpc.direction == "right" and player.y >  currentnpc.y - 20 then
			newfireball = { x = currentnpc.x + 40, y = currentnpc.y + 10, img = spriteimg, direction = currentnpc.direction}
			table.insert(fireball, newfireball)
			canShoot = false
			canShootTimer = canShootTimerMax
			
		end
		if (player.x > currentnpc.x - 100 and player.x < currentnpc.x) and canShoot  
		and currentnpc.direction == "left" and player.y >  currentnpc.y - 20 then
			newfireball = { x = currentnpc.x - 80, y = currentnpc.y + 10, img = spriteimg, direction = currentnpc.direction}
			table.insert(fireball, newfireball)
			canShoot = false
			canShootTimer = canShootTimerMax
			
		end
		
		for i, fire in ipairs(fireball) do
			if fire.direction == "right" then
				fire.x = fire.x + (600 * dt)

				if fire.x > currentnpc.x + 100 then -- remove bullets when they pass off the screen
					table.remove(fireball, i)
				end
			end
			if fire.direction == "left" then
				fire.x = fire.x - (600 * dt)

				if fire.x < currentnpc.x - 140 then -- remove bullets when they pass off the screen
					table.remove(fireball, i)
				end
			end
			
		end
	end
end

firefighter.draw = function(dt)
	for i, firedude in ipairs(firefighter) do
		firedude.npcAnimation:draw(firedude.img, firedude.x, firedude.y)
		love.graphics.print(firedude.x, firedude.x, firedude.y - 18)
	end

	--[[love.graphics.draw(fireman.img, fireman.x, fireman.y)]]
	for i, fire in ipairs(fireball) do
		love.graphics.draw(fire.img, fire.x, fire.y)
	end
	
end


return firefighter