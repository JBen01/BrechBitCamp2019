local fireball = {}



fireball.load = function(arg)
	canShoot = true
	canShootTimerMax = 0.05 
	canShootTimer = canShootTimerMax
	spriteimg = love.graphics.newImage('Sprites/fire.png')
end

fireball.create = function(dt)
	count = 0
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
	  canShoot = true
	end
	
	if love.keyboard.isDown('f') and canShoot then
		newfireball = { x = 350, y = 250, img = spriteimg}
		table.insert(fireball, newfireball)
		canShoot = false
		canShootTimer = canShootTimerMax
		
	end
	
	for i, fire in ipairs(fireball) do
		fire.x = fire.x - (300 * dt)

		if fire.x < 0 then -- remove bullets when they pass off the screen
			table.remove(fireball, i)
		end
	end
	
end

fireball.draw = function()
	for i, fire in ipairs(fireball) do
		love.graphics.draw(fire.img, fire.x, fire.y)
	end
end

return fireball