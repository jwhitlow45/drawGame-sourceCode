require("scripts.audioFade")
require("scripts.counters")
require("scripts.games")
require("scripts.menu")
require("scripts.playerData")
require("scripts.saveData")
require("scripts.textures")

love.filesystem.setIdentity("pewPewDraw")

function love.load()
	--initializes table far saveData
	gamesPlayed = {}
	gamesPlayed.num = 0

	--sets font
	love.graphics.setFont(gringoFont)

	--checks to make sure if saveData.lua exists, if not it creates saveData.lua (located in LOVE Roaming file)
	if love.filesystem.getInfo("saveData.lua", file) == nil then
		saveNumGames()
	else
		loadNumGames()
	end


	--sets time based variables
	time = 0
	frame = 0
	wait = 0

	fired = false
	bell = false


	--keeps track of which keys have been pressed
	wPressed = false
	upPressed = false

	--sets all game win conditions
	condition = {}
	condition.tie = false
	condition.win1 = false
	condition.win2 = false
	condition.early1 = false
	condition.early2 = false

	--gets random number for draw timer
	math.randomseed(os.clock())
	random = math.random(60, 600)


	--gets random draw delay for computer
	math.randomseed(os.clock())
	computerRandom = math.random(20,50) + random
end


--displays graphic for shooting-----------------------------------------
function draw(score1, score2, game)
	if frame == random then
		time = 1
	end

	if time == 1 and score1 ~= gamesToWin and score2 ~= gamesToWin and gamestate == game then
		love.graphics.draw(drawImage, 0, 100)

		if bell == false then
			bellSound:play()
			bell = true
		end
	end
end


--checks if computer shot---------------------------------------------------
function computerShoots()
	if frame == computerRandom then
		return true
	else
		return false
	end
end


--sets and resets game images state if no player's score == gamesToWin-------------------
function reset(state, score, image1, image2)
	if condition.tie == false and condition.win1 == false and condition.win2 == false then
		love.graphics.draw(player1Image, 30, 500)
		love.graphics.draw(player2Image, 670, 500)

	elseif state == true and score ~= gamesToWin then
		love.graphics.draw(image1, 30, 500)
		love.graphics.draw(image2, 670, 500)
		wait = wait + 1

		if wait == 2 then
			love.timer.sleep(2)
			love.load()
		end

	elseif score == gamesToWin then
		love.graphics.draw(image1, 30, 500)
		love.graphics.draw(image2, 670, 500)
	end
end


--checks if a player's score == gamesToWin--------------------------
function win(score, game, winner)
	if score == gamesToWin then
		love.graphics.draw(winner, 0, 100)
		love.graphics.draw(rematchImage, 0, 200)

		--adds 1 to number of games played and saves
		gameComp()
		saveNumGames()
					
		if love.keyboard.isDown("y") then
			player1score = 0
			player2score = 0
			computerscore = 0
			love.load()
			gamestate = game

		elseif love.keyboard.isDown("n") then
			player1score = 0
			player2score = 0
			computerscore = 0
			love.load()
			gamestate = game
			gamestate = 0
		end
	end
end


--updates every frame----------------------------------------------
function love.update(dt)
	if frame < 600 and gamestate ~= 0 then
		frame = frame + 1
	end
	
	if condition.tie == condition.win1 == condition.win2 == false then
		early()
	end
	
	if condition.tie == condition.win1 == condition.win2 == false and gamestate == 1 then
		singleplayer()
	elseif condition.tie == condition.win1 == condition.win2 == false and gamestate == 2 then
		multiplayer()
	end
end

--draws every frame-----------------------------------------------
function love.draw()
	--draws background
	love.graphics.draw(backImage)

	--games played counter display
	gamesPlayedCounter()
	
	--sound
	if condition.tie or condition.win1	or condition.win2 then
		if fired == false then
			bangSound:play()
			fired = true
		end
	end

	--gamestates (0 = menu, 1 = singleplayer, 2 = multiplayer)
	if gamestate == 0 then

		--plays menu music
		if menuMusicSound:isPlaying() == false then
			menuMusicSound:setVolume(0.1)
			menuMusicSound:play()
		end

		--draw menu screen
		mousePos()

		love.graphics.printf("First to: "..gamesToWin, 275, 246, 250, 'center')
		love.graphics.draw(logoImage, 0, 50)

		gamesToWinButton(plusGamesHoverImage, plusGamesImage, button.increase.x, button.increase.y, button.increase.w, button.increase.h, "plus")
		gamesToWinButton(minusGamesHoverImage, minusGamesImage, button.decrease.x, button.decrease.y, button.decrease.w, button.decrease.h, "minus")
		
		menuButton(1, singleplayerHoverImage, singleplayerImage, button.singleplayer.x, button.singleplayer.y, button.singleplayer.w, button.singleplayer.h)
		menuButton(2, multiplayerHoverImage, multiplayerImage, button.multiplayer.x, button.multiplayer.y, button.multiplayer.w, button.multiplayer.h)
		menuButton(0, quitHoverImage, quitImage, button.quit.x, button.quit.y, button.quit.w, button.quit.h)

	elseif gamestate == 1 then
		singleplayerScoreCounter()

		--fades out menu music
		if menuMusicSound:isPlaying() == true then
			audioFadeOut(menuMusicSound, 0.1)
		end

		backSound:play()

		draw(player1score, computerscore, 1)
		win(player1score, gamestate, player1WinImage)
		win(computerscore, gamestate, computerWinImage)
		reset(condition.win1, player1score, player1shotImage, ripImage)
		reset(condition.win2, computerscore, ripImage, player2shotImage)
		reset(condition.tie, 0, ripImage, ripImage)

	elseif gamestate == 2 then
		multiplayerScoreCounter()		
		
		--fades out menu music
		if menuMusicSound:isPlaying() == true then
			audioFadeOut(menuMusicSound, 0.1)
		end

		backSound:play()

		draw(player1score, player2score, 2)
		win(player1score, gamestate, player1WinImage)
		win(player2score, gamestate, player2WinImage)
		reset(condition.win1, player1score, player1shotImage, ripImage)
		reset(condition.win2, player2score, ripImage, player2shotImage)
		reset(condition.tie, 0, ripImage, ripImage)

		--just in the two idiots playing somehow both miss (so me)
		if wPressed == true and upPressed == true then
			love.graphics.printf("congratulations...you both missed.", 100, 246, 600, 'center')

			wait = wait + 1

			if wait == 2 then
				love.timer.sleep(3)
				love.load()
			end
		end
	end
end