local aliens = {}

aliens.load = function(arg)
	spriteImg = love.graphics.newImage('Sprites/player.png')
	spawnTime = 0
	randomSpawn = 0
end
counter = 0
spawnTop = true
spawnCenter = true
spawnBottom = true

aliens.spawn = function(dt)
	randomSpawntime = love.math.random(3, 4)
	if spawnTime < randomSpawntime then
		spawnTime = spawnTime + dt
	end
	if spawnTime > randomSpawntime then
		randomSpawn = love.math.random(1, 6)
		if randomSpawn == 1 and spawnTop == true then
			newAlien = {x = (64 * 6), y = 64*2, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="top"}
			table.insert(aliens, newAlien)
		end
		if randomSpawn == 2 and spawnTop == true then
			newAlien = {x = (64*17), y = 64*2, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="top"}
			table.insert(aliens, newAlien)
		end
		if randomSpawn == 3 and spawnCenter == true then
			newAlien = {x = 64 * 6, y = 64*6, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="center"}
			table.insert(aliens, newAlien)
		end
		if randomSpawn == 4 and spawnCenter == true then
			newAlien = {x = 64*17, y = 64*6, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="center"}
			table.insert(aliens, newAlien)
		end
		if randomSpawn == 5 and spawnBottom == true then
			newAlien = {x = 64 * 4, y = 64*10, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="Bottom"}
			table.insert(aliens, newAlien)
		end
		if randomSpawn == 6  and spawnBottom == true then
			newAlien = {x = 64*19, y = 64*10, img = spriteImg, spawn = tonumber(randomSpawn), dead = false, attack = false, ypos ="Bottom"}
			table.insert(aliens, newAlien)
		end
		
		counter = counter + 1
		spawnTime = 0
	end
	
	for i, alien in ipairs(aliens) do
		if alien.x + 64 > player.x and alien.x < player.x + 64 and player.y < alien.y +64 and player.y > alien.y - 32 then
			table.remove(aliens, i)
			player.health = player.health - 1
		elseif (player.x > alien.x + 32 and player.x < alien.x + 64 * 10) and player.x < 64*19 and player.y < alien.y +64
		and player.y > alien.y - 32 and alien.attack == false then
			alien.x = alien.x + ((10*10)*dt)
		elseif (player.x < alien.x and player.x < alien.x + 64 * 4) and player.x < 64*19 and player.y < alien.y +64
		and player.y > alien.y - 64 and alien.attack == false then
			alien.x = alien.x - ((10*10)*dt)
		elseif alien.x < love.graphics.getWidth()/2 -64 then
			alien.x = alien.x + ((10*10)*dt)
		elseif alien.x > love.graphics.getWidth()/2 +32 then
			alien.x = alien.x - ((10*10)*dt)
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
	end

end

aliens.draw = function(dt)
	for i, alien in ipairs(aliens) do
		love.graphics.draw(alien.img, alien.x, alien.y)
		--love.graphics.print(alien.spawn, alien.x, alien.y)
	end
	--love.graphics.print(randomSpawn, 440, 15)
end

return aliens