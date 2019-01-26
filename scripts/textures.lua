--player images
player1Image = love.graphics.newImage("gameImages/player1.png")
player2Image = love.graphics.newImage("gameImages/player2.png")
ripImage = love.graphics.newImage("gameImages/rip.png")
player1shotImage = love.graphics.newImage("gameImages/player1Shot.png")
player2shotImage = love.graphics.newImage("gameImages/player2Shot.png")

--popup images
drawImage = love.graphics.newImage("gameImages/draw.png")
player1WinImage = love.graphics.newImage("gameImages/player1Win.png")
player2WinImage = love.graphics.newImage("gameImages/player2Win.png")
computerWinImage = love.graphics.newImage("gameImages/computerWin.png")
rematchImage = love.graphics.newImage("gameImages/rematch.png")

--background
backImage = love.graphics.newImage("gameImages/back.png")

--fonts
gringoFont = love.graphics.newFont("fonts/gringoNights.ttf", 30)

--menu images
logoImage = love.graphics.newImage("menuImages/logo.png")
singleplayerImage = love.graphics.newImage("menuImages/singleplayer.png")
singleplayerHoverImage = love.graphics.newImage("menuImages/singleplayerHover.png")
multiplayerImage = love.graphics.newImage("menuImages/multiplayer.png")
multiplayerHoverImage = love.graphics.newImage("menuImages/multiplayerHover.png")
quitImage = love.graphics.newImage("menuImages/quit.png")
quitHoverImage = love.graphics.newImage("menuImages/quitHover.png")

plusGamesImage = love.graphics.newImage("menuImages/plus.png") 
plusGamesHoverImage = love.graphics.newImage("menuImages/plusHover.png")
minusGamesImage = love.graphics.newImage("menuImages/minus.png")
minusGamesHoverImage = love.graphics.newImage("menuImages/minusHover.png")

--sounds
bangSound = love.audio.newSource("sounds/bang.wav", "stream")
bellSound = love.audio.newSource("sounds/bell.wav", "stream")
menuMusicSound = love.audio.newSource("sounds/menuMusic.wav", "stream")

backSound = love.audio.newSource("sounds/back.wav", "stream")
backSound:setVolume(1)