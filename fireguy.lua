local fireguy = {}
local anim8 = require 'anim8'
local respawnX = (love.graphics.getWidth()/2 - 32)
local respawnY = (love.graphics.getHeight() - 64)

fireguy.load = function(arg, tileY)
	
	simg = love.graphics.newImage('Sprites/spaceman/spaceman1.png')
	bulletimg = love.graphics.newImage('Sprites/bullet.png')
	local g = anim8.newGrid(64, 68, simg:getWidth(), simg:getHeight())
	
	player = {x = respawnX, y = respawnY, img = love.graphics.newImage('Sprites/spaceman/spaceman1.png'), movementSpeed = (10*40), health = 10, scrollX = 0, moving = false, dir = "left",  playerAnimation = nil,
		animations = {
			left = anim8.newAnimation(g('1-4',1), 0.1),
			right = anim8.newAnimation(g('1-4',2), 0.1),
			idle_left = anim8.newAnimation(g('6-6',1), 0.1),
			idle_right = anim8.newAnimation(g('6-6',2), 0.1),
			jump_left = anim8.newAnimation(g('5-5',1), 0.1),
			jump_right = anim8.newAnimation(g('5-5',2), 0.1)
		}
	}
	table.insert(fireguy, player)
	
	player.ground = tileY - 63 
	player.velocity = 0  
	player.jump_height = -2200   
	player.gravity = -1330 * 14  
end

fireguy.control = function(dt, tileX, tileY) 
	--player.scrollX = (player.movementSpeed * dt)
	if love.keyboard.isDown('a','left') then
		if player.x > 64 then
		player.x = player.x - (player.movementSpeed * dt)
		--player.scrollX = player.scrollX - (player.movementSpeed * dt) 
		player.moving = true
		player.dir = "left"
			if player.velocity == 0 then
				player.playerAnimation = player.animations.left
			else
				player.playerAnimation = player.animations.jump_left
			end
		end
		
	elseif love.keyboard.isDown('d','right') then
		if player.x < love.graphics.getWidth()- (64*2) then
			player.x = player.x + (player.movementSpeed* dt)
			--player.scrollX = player.scrollX + (player.movementSpeed * dt) 
			player.moving = true
			player.dir = "right"
			if player.velocity == 0 then
				player.playerAnimation = player.animations.right
			else
				player.playerAnimation = player.animations.jump_right
			end
		end
	else
		player.moving = false
		if player.dir == "left" then
			player.playerAnimation = player.animations.idle_left
		elseif player.dir == "right" then
			player.playerAnimation = player.animations.idle_right
		end
	end
	player.playerAnimation:update(dt)
end

fireguy.jump = function(dt, tileX, tileY, fall, tileXRight)	
		--jump code
		if love.keyboard.isDown('w', 'up')then                           
			if player.velocity == 0 then
				player.velocity = player.jump_height 
			end
		end
		if player.velocity ~= 0 then                            
			player.y = player.y + player.velocity * dt                
			
		end
		--end of jump code
		
		if player.y < player.ground then
			player.velocity = player.velocity - player.gravity * dt 
		end
	
		--boundries finding out if its inside the blocks width
		if player.y > player.ground then   
			player.velocity = 0      
			player.y = player.ground  
			
		end
		
		--if under a block and nothing is under that block, this causes the player to fall
		if player.y > 768 then
			player.y = respawnY
			player.x = respawnX
			player.velocity = 0      
		end
end

fireguy.falling = function(dt, tileX)
	if player.y > player.ground or (player.x < tileX - 55) or (player.x > tileX + 95) then --falling
		player.y = player.y + 10 * dt
		player.velocity = player.velocity - player.gravity * dt 
	end
end

fireguy.draw = function(dt)
	player.playerAnimation:draw(player.img, player.x, player.y)
	--[[love.graphics.print("fireguy velocity : ", 10, 10)
	love.graphics.print(player.velocity, 120, 10)
	love.graphics.print("player moving?: ", 10, 90)
	thing = player.moving
	if player.moving == true then
		love.graphics.print((tostring(thing)), 120, 90)
	elseif player.moving == false then
		love.graphics.print((tostring(thing)), 120, 90)
	end]]
	
	love.graphics.print("health: ", 74, 15)
	love.graphics.print(player.health, 210, 15)
end


return fireguy