gamestate = 0

--gets mouse position---------------------------------------------------------------------------------------
function mousePos()
	mx, my = love.mouse.getPosition()
end

local function checkHover(mx, my, x, y, w, h)
	return mx > x and mx < x+w and my > y and my < y+h
end
	


button = {}
	button.singleplayer = {}
		button.singleplayer.x = 255
		button.singleplayer.y = 300
		button.singleplayer.w = 290
		button.singleplayer.h = 76

	button.multiplayer = {}
		button.multiplayer.x = 255
		button.multiplayer.y = 400
		button.multiplayer.w = 290
		button.multiplayer.h = 76

	button.quit = {}
		button.quit.x = 255
		button.quit.y = 500
		button.quit.w = 290
		button.quit.h = 76

	button.increase = {}
		button.increase.x = 569
		button.increase.y = 300
		button.increase.h = 76
		button.increase.w = 76

		button.decrease = {}
		button.decrease.x = 155
		button.decrease.y = 300
		button.decrease.h = 76
		button.decrease.w = 76

--draws and creates hitbox for menu buttons-------------------------------------------------------------------------
function menuButton(game, imageHover, image, x, y, w, h)
	if checkHover(mx, my, x, y, w, h) and love.mouse.isDown(1) then
		love.graphics.draw(imageHover, x, y)
		gamestate = game

		if game == 0 then
			love.event.quit()
		end

	elseif checkHover(mx, my, x, y, w, h) then
		love.graphics.draw(imageHover, x, y)
	else
		love.graphics.draw(image, x, y)
	end
end


--variable used to prevent multiple additions to gamesToWin per click
 local clicked = 0

--draws and creates hitbox for gamesToWin buttons
function gamesToWinButton(imageHover, image, x, y, w, h, op)
	if checkHover(mx, my, x, y, w, h) and love.mouse.isDown(1) then
		love.graphics.draw(imageHover, x, y)
		
		if love.mouse.isDown(1) == true then
			clicked = clicked + 1
		end

		if clicked == 1 then

			if op == "plus" then 
				gamesToWin = gamesToWin + 1
				
				if gamesToWin == 21 then
					gamesToWin = 20
				end

			elseif op == "minus" then
				gamesToWin = gamesToWin - 1
				
				if gamesToWin == 0 then
					gamesToWin = 1
				end
			end
		end

	elseif checkHover(mx, my, x, y, w, h) then
		love.graphics.draw(imageHover, x, y)
		clicked = 0
	else
		love.graphics.draw(image, x, y)
	end
end