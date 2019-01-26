require("libraries.tablesave")


--saves by putting the gamesPlayed table as lua code table named loadedGamesPlayed------------
function saveNumGames()
	love.filesystem.write("saveData.lua", table.show(gamesPlayed, "loadedGamesPlayed")) 
end


--loads saveData------------------------------------------------------------------------------
function loadNumGames()
	chunk = love.filesystem.load("saveData.lua")
	chunk()
end


--adds 1 to the amount of games played, called when a game is completed-----------------------
function gameComp()
	gamesPlayed.num = loadedGamesPlayed.num + 1
	saveNumGames()
end