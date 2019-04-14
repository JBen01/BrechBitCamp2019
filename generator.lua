
local anim8 = require 'anim8'
local generator = {}
local bullets = {}
	
generator.load = function(arg)
	simg = love.graphics.newImage('Sprites/generator/generator.png')
	bulletimg = love.graphics.newImage('Sprites/bullet.png')
	local g = anim8.newGrid(128, 128, simg:getWidth(), simg:getHeight())
	canShoot = true
	canShootTimerMax = 0.05 
	canShootTimer = canShootTimerMax
	
	
	generator1 = {x = (love.graphics.getWidth()/2 - 46), y = 64, img = love.graphics.newImage('Sprites/generator/generator.png'), health = 100,  generatorAnimation = nil, healing = false, pos = 1,
		animations = {
			healing = anim8.newAnimation(g('1-4',1), 0.1),
			normal = anim8.newAnimation(g('1-4',2), 0.1),
			damaged = anim8.newAnimation(g('1-4',3), 0.1),
			hurting = anim8.newAnimation(g('1-4',4), 0.1),
			critical = anim8.newAnimation(g('1-4',5), 0.1)
		}
	}
	table.insert(generator, generator1)
	
	generator2 = {x = (love.graphics.getWidth()/2 - 46), y = 320, img = love.graphics.newImage('Sprites/generator/generator.png'), health = 100,  generatorAnimation = nil, healing = false, pos = 2,
		animations = {
			healing = anim8.newAnimation(g('1-4',1), 0.1),
			normal = anim8.newAnimation(g('1-4',2), 0.1),
			damaged = anim8.newAnimation(g('1-4',3), 0.1),
			hurting = anim8.newAnimation(g('1-4',4), 0.1),
			critical = anim8.newAnimation(g('1-4',5), 0.1)
		}
	}
	table.insert(generator, generator2)
	
	generator3 = {x = (love.graphics.getWidth()/2 - 46), y = 576, img = love.graphics.newImage('Sprites/generator/generator.png'), health = 100,  generatorAnimation = nil, healing = false, pos = 3,
		animations = {
			healing = anim8.newAnimation(g('1-4',1), 0.1),
			normal = anim8.newAnimation(g('1-4',2), 0.1),
			damaged = anim8.newAnimation(g('1-4',3), 0.1),
			hurting = anim8.newAnimation(g('1-4',4), 0.1),
			critical = anim8.newAnimation(g('1-4',5), 0.1)
		}
	}
	table.insert(generator, generator3)
	
	
end
	
generator.healthCheck = function(dt)
	for i, generators in ipairs(generator) do
		if generators.health > 80 then
			generators.generatorAnimation = generators.animations.normal
		elseif generators.health < 80 and generators.health > 60 then
			generators.generatorAnimation = generators.animations.damaged
		elseif generators.health < 60 and generators.health > 40 then
			generators.generatorAnimation = generators.animations.hurting
		elseif generators.health <= 40 then
			generators.generatorAnimation = generators.animations.critical
		end
		generators.generatorAnimation:update(dt)
	end
end

generator.damage = function(dt)
	for i, generators in ipairs(generator) do
		for i, alien in ipairs(aliens) do
			if (alien.x > generators.x - 64 and alien.x < generators.x + 128) and alien.y > generators.y and alien.y < generators.y + 129 then
				alien.attack = true
				generators.health = generators.health - (dt*4)
			end
		end
		if generators.health < 0 then
			if generators.pos == 1 then
				spawnTop = false
			elseif generators.pos == 2 then
				spawnCenter = false
			elseif generators.pos == 3 then
				spawnBottom = false
			end
		end
	end
	
	for j, alien in ipairs(aliens) do
		if spawnTop == false then
			if alien.ypos == "top" then
				alien.attack = false
			end
		end
		if spawnCenter == false then
			if alien.ypos == "center" then
				alien.attack = false
			end
		end
		if spawnBottom == false then
			if alien.ypos == "bottom" then
				alien.attack = false
			end
		end
		if spawnTop == false and spawnCenter == false and spawnBottom == false then
			gameover = true
		end
	end
	
end

waittime = 1
generator.firingBullets = function(dt)
	if waittime < .5 then
		waittime = waittime + dt
	end
	
	if waittime > .5 then
		if love.keyboard.isDown('f') then
			for i, generators in ipairs(generator) do
				if player.x < generators.x - 64 or player.x > generators.x + 128 and player.y > generators.y - 64*2 and player.y < generators.y + 129 then
					if player.dir == "left" then
						newbullet = {x = player.x - 10, y = player.y + 32, img = bulletimg, dir = player.dir}
						table.insert(bullets, newbullet)
					elseif player.dir == "right" then
						newbullet = {x = player.x + 74, y = player.y + 32, img = bulletimg, dir = player.dir}
						table.insert(bullets, newbullet)
					end
				end
			end
		end
		waittime = 0
	end
end

generator.bulletMovements = function(dt)
	for i, bullet in ipairs(bullets) do
		if bullet.dir == "left" then
			if bullet.x > 0 then
				bullet.x = bullet.x - ((10*70)*dt) 
			end
			for j, alien in ipairs(aliens) do
				if alien.x < player.x + 64 then
					if bullet.x < alien.x + 64  and bullet.y > alien.y and bullet.y < alien.y + 64 then
						alien.dead = true
						table.remove(bullets, i)
					end
					if alien.dead == true then
						table.remove(aliens, j)
					end
				end
			end
		end
		if bullet.dir == "right" then
			if bullet.x > love.graphics.getWidth() then
				table.remove(bullets, i)
			end
			for l, alien in ipairs(aliens) do
				if alien.x > player.x then
					if bullet.x > alien.x and bullet.y > alien.y and bullet.y < alien.y + 64 then
						alien.dead = true
					end
					if alien.dead == true then
						table.remove(aliens, l)
						table.remove(bullets, i)
					end
				end
			end
			if bullet.x < love.graphics.getWidth() then
				bullet.x = bullet.x + ((10*70)*dt) 
			end
		end
		if bullet.x > love.graphics.getWidth() then
			table.remove(bullets, i)
		end
		if bullet.x < 0 then
			table.remove(bullets, i)
		end
	end
end

generator.heal = function(dt)
	for i, generators in ipairs(generator) do
		if generators.health >= 1 then
			if generators.health > 100 then
				generators.health = 100
			end
			
			if (player.x > generators.x - 64 and player.x < generators.x + 128) and player.y > generators.y and player.y < generators.y + 129 then
				generators.healing = true
			else
				generators.healing = false
			end
			
			if generators.health < 100 then
				if love.keyboard.isDown('e') and generators.healing == true then
					generators.generatorAnimation = generators.animations.healing
					generators.generatorAnimation:update(dt)
						if generators.health < 100 then
							generators.health = generators.health + (dt*4)
						end
				end
			end
		end
	end
	
	
end
	
generator.draw = function(dt)
	for i, generators in ipairs(generator) do
		if	generators.health > 0 then
			generators.generatorAnimation:draw(generators.img, generators.x, generators.y)
		end
		if generators.healing == true and generators.health > 0 then
			if not(love.keyboard.isDown('e')) and (generators.health < 100) then 
				love.graphics.print("E[heal generator]", generators.x + 128, generators.y)
			end
		end
	end
end

generator.drawBullets = function(dt)
	if player.health > 0 then
		for i, bullet in ipairs(bullets) do
			love.graphics.draw(bullet.img, bullet.x, bullet.y)
		end
	end
end
	
return generator