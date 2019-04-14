fireguy = require('fireguy')
local block = {}
local xpos = {}
gravityMultiplier = 0
count = 1
count2 = 1
level = {
		{ 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2},
		{ 2, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 3},
		{ 2, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 4},
		{ 3, 0, 0, 0, 0, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1, 1, 0, 0, 0, 0, 2},
		{ 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2},
		{ 4, 1, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 1, 1, 2},
		{ 2, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 2},
		{ 2, 0, 0, 0, 0, 5, 1, 1, 1, 5, 1, 1, 5, 1, 1, 1, 1, 1, 5, 0, 0, 0, 0, 3},
		{ 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2},
		{ 2, 1, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 1, 5, 2},
		{ 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 2},
		{ 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	}
	
length = table.getn(level[1])
tilesize = 0
tileheight = 0
	
block.load = function(arg)
	block1 = love.graphics.newImage('Sprites/blocks/block_Animation 1_0.png')
	block2 = love.graphics.newImage('Sprites/blocks/block_Animation 1_2.png')
	block3 = love.graphics.newImage('Sprites/blocks/block_Animation 1_3.png')
	block4 = love.graphics.newImage('Sprites/blocks/block_Animation 1_4.png')
	block5 = love.graphics.newImage('Sprites/blocks/block_Animation 1_1.png')
	block6 = love.graphics.newImage('Sprites/blocks/block_Animation 1_5.png')
	tilesize = block2:getWidth()
	tileheight = block2:getHeight()
	sprite = nil
	xPos = 0
	yPos = 510
	
	while count <= #level do
		count2 = 0
		while count2 <= #level[count] do
			
			--Block intialization
			if level[count][count2] == 1 then
				sprite = block1
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block1, movementSpeed = (10*20), yposition = count, blocktype = 1, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			elseif level[count][count2] == 2 then
				sprite = block2
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block2, movementSpeed = (10*20), yposition = count, blocktype = 2, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			elseif level[count][count2] == 3 then
				sprite = block3
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block3, movementSpeed = (10*20), yposition = count, blocktype = 2, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			elseif level[count][count2] == 4 then
				sprite = block4
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block4, movementSpeed = (10*20), yposition = count, blocktype = 2, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			elseif level[count][count2] == 5 then
				sprite = block5
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block5, movementSpeed = (10*20), yposition = count, blocktype = 1, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			elseif level[count][count2] == 6 then
				sprite = block6
				tile = {x = ((count2 - 1) * sprite:getWidth()), y = ((count -1) * sprite:getHeight()), 
				img = block6, movementSpeed = (10*20), yposition = count, blocktype = 2, blockPosition = count2, heightestBlock = false}
				table.insert(block, tile)
			end

			
			--creates the xplane to find vertical stacking block positions
			if table.getn(xpos) <= table.getn(level[1]) - 1  then
				blockSizeMeasure = block2
				row = ((count2) * blockSizeMeasure:getWidth())
				table.insert(xpos, row)
			end
			
			--Adjust gravity to avoid stacking of games gravity (ie a gravity feild increasing over distance in strength)
			gravityMultiplier = gravityMultiplier + 1
			
			count2 = count2 + 1
		end
		count = count + 1 --gives me the length of the arrays in my 2d array 
		--xPos = --[[xPos]] (count * 96) ---90--125--125
	end
	
	--puts
	
	
	
	
	--count = 8
	fireguy.load(arg, 510--[[tile.y]] + 20)	
	--firefighter.load(arg)
end
currentHeighestBlock = 0
xPositionOnScreen = 0
yPositionOnScreen = 0
currentBlockType = 0
currentBlockPostion = 0
heighestLeftBlock = 0
thing = 0
stuff = 0
fall = false

center = {}
right = {}
pig = 0
block.collision = function(dt)
	
	for i, xposition in ipairs(xpos) do
		
		if (player.x + tilesize >= xposition and player.x <= xposition + tilesize)--[[ or (player.x > xposition - (tilesize/2) and player.x < xposition + (tilesize/2))]] then
			
				xPositionOnScreen = xposition --The current block that player collides with is only choosen if above and inside it
				--currentBlockPostion = i
				for j, newblock in ipairs(block) do
					if newblock.x == xposition and newblock.blocktype == 1 and player.y + (tileheight-2) < newblock.y then
						table.insert(center, newblock.y)
					end
				end
				
				table.sort(center)
				if table.getn(center) > 0 then
					yPositionOnScreen = center[1] - tileheight
					player.ground = yPositionOnScreen
				end
				if table.getn(center) <= 1 then
					yPositionOnScreen = 600
					player.ground = yPositionOnScreen
				end
			--currentBlockPostion = newblock.blockPosition
		end
	end
	
	fireguy.jump(dt/5*1.5, xPositionOnScreen, yPositionOnScreen, fall, xPositionOnScreen + tilesize)
	fireguy.control(dt, xPositionOnScreen, yPositionOnScreen) --controls for the players movement are loaded in collision
	center = {}
end


block.movement = function(dt)
	for i, newblock in ipairs(block) do
		--if player.moving == true then
			if love.keyboard.isDown('j') then
				newblock.x = newblock.x + (newblock.movementSpeed * dt)
				
			elseif love.keyboard.isDown('l') then
				newblock.x = newblock.x - (newblock.movementSpeed * dt)  
			end
		--else
			--newblock.x = newblock.x
		--end
		
	end
end



block.draw = function(dt)
	for i, newblock in ipairs(block) do
		if not(newblock.img == nil) then 
			love.graphics.draw(newblock.img, newblock.x, newblock.y)
		end
		if ((player.x > newblock.x - 55 and player.x < newblock.x + 95) and (player.y < player.ground + 10)) then
			positionOnScreen = newblock.x	
		end
			--[[love.graphics.print("tile postion: ", 10 , 50)
			love.graphics.print(xPositionOnScreen, 100, 50)
			love.graphics.print("fireguy x pos: ", 10, 30)
			love.graphics.print(player.x, 100, 30)
			love.graphics.print("scrollX : ", 10, 70)
			love.graphics.print(count2, 100, 70)
			love.graphics.print("tile ypostion: ", 10, 110)
			love.graphics.print(yPositionOnScreen, 100, 110)
			love.graphics.print("fireguy y pos: ", 10, 130)
			love.graphics.print(player.y, 100, 130)
			love.graphics.print("fireguy fall: ", 10, 150)
			love.graphics.print(tostring(fall), 100, 150)
			love.graphics.print("fireguy ground: ", 10, 170)
			love.graphics.print(player.ground, 110, 170)
			love.graphics.print("level length: ", 10, 190)
			love.graphics.print((count2 - 1), 110, 190)
			love.graphics.print("level height: ", 10, 210)
			love.graphics.print(count - 1, 110, 210)
			love.graphics.print("(" .. newblock.yposition .. ",", newblock.x, newblock.y)
			love.graphics.print(newblock.blockPosition .. ")", newblock.x + 26, newblock.y)
			love.graphics.print("last block xpos: ", 10, 230)
			love.graphics.print(xpos[table.getn(xpos)], 110 , 230)
			love.graphics.print("level length: ", 10, 250)
			love.graphics.print(table.getn(xpos), 110, 250)
			love.graphics.print("current tile: ", 10, 270)
			love.graphics.print(currentBlockPostion, 110, 270)
			love.graphics.print(pig, 110, 290)]]
		
	end
end

return block