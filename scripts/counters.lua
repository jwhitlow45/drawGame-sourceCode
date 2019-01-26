require("scripts.playerdata")

function gamesPlayedCounter()
	love.graphics.printf("Games Played: "..loadedGamesPlayed.num, 275, 25, 250, 'center')
end

function singleplayerScoreCounter()
	love.graphics.print("Score: ".. player1score, 20, 450)
	love.graphics.print("Score: ".. computerscore, 680, 450)
end

function multiplayerScoreCounter()
	love.graphics.print("Score: ".. player1score, 20, 450)
	love.graphics.print("Score: ".. player2score, 680, 450)
end