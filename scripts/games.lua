function early() --checks for early shooting
	if love.keyboard.isDown("w") and love.keyboard.isDown("up") and time ~= 1 and gamestate == 2 and wPressed == false and upPressed == false then
		condition.tie = true
	end

	if love.keyboard.isDown("w") and time ~= 1 and gamestate ~= 0 and condition.tie == false then
		if wPressed == false then
			bangSound:play()
		end
		wPressed = true
	elseif love.keyboard.isDown("up") and time ~= 1 and gamestate == 2 and condition.tie == false then
		if upPressed == false then
			bangSound:play()
		end
		upPressed = true
	end		
end

function singleplayer()
	if love.keyboard.isDown("w") and computerShoots() and wPressed == false then
		condition.tie = true
	elseif love.keyboard.isDown("w") and wPressed == false then
		condition.win1 = true
		player1score = player1score + 1
	elseif computerShoots() then
		condition.win2 = true
		computerscore = computerscore + 1
	end		
end

function multiplayer() --checks for ontime shooting
	if love.keyboard.isDown("w") and love.keyboard.isDown("up") and wPressed == false and upPressed == false then
		condition.tie = true
	elseif love.keyboard.isDown("w") and wPressed == false then
		condition.win1 = true
		player1score = player1score + 1
	elseif love.keyboard.isDown("up") and upPressed == false  then
		condition.win2 = true
		player2score = player2score + 1
	end			
end