generator = require('generator')
fireguy = require('fireguy')
fireball = require('fireball')
firefighter = require('firefighter')
block = require('block')
aliens = require('aliens')
font = love.graphics.newFont('Sprites/fonts/Beefd.ttf', 14)

gameover = false

function love.load(arg)
	love.graphics.setFont(font)
	currentTime = 0
	backgroundimg = love.graphics.newImage('Sprites/background.png')
	--firefighter.load(arg)
	block.load(arg)
	generator.load(arg)
	aliens.load(arg)
	--fireball.load(arg)
end

function love.update(dt) 
	if gameover == false then
		currentTime = currentTime + dt
		love.graphics.setBackgroundColor( 0, 150, 255)
		--fireball.create(dt)
		block.collision(dt)
		--firefighter.movement(dt)
		--firefighter.hosefire(dt)
		--fireguy.control(dt)
		block.movement(dt)
		generator.healthCheck(dt)
		generator.heal(dt)
		generator.damage(dt)
		generator.firingBullets(dt)
		generator.bulletMovements(dt)
		--fireguy.fire(dt)
		aliens.spawn(dt)
		if player.health < 1 then
			gameover = true
		end
	end

end

function love.draw(dt)
	love.graphics.draw(backgroundimg, 0, 0)
	block.draw(dt)
	if gameover == false then
		generator.draw(dt)
		aliens.draw(dt)
		generator.drawBullets(dt)
		fireguy.draw(dt)
	end
		love.graphics.print("time: ", (love.graphics.getWidth()/2) - 50, 20)
		love.graphics.print(math.floor(currentTime), (love.graphics.getWidth()/2) + 49, 20)
	if gameover == true then
		love.graphics.print("GAME OVER", (love.graphics.getWidth()/2) - 50, love.graphics.getHeight()/2)
	end
	--fireball.draw(dt)
	--firefighter.draw(dt)
end