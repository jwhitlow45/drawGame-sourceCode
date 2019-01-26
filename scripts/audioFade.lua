fadeAmount = 0

function audioFadeOut(source, volume)
	fadeAmount = fadeAmount + 0.001
	volume = volume - fadeAmount
	source:setVolume(volume)

	if fadeAmount > source:getVolume() * 100 then
		source:stop()
		fadeAmount = 0
		volume = volume - fadeAmount
	end
end