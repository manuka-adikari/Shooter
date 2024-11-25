ScoreCounter = {}
ScoreCounter.__index = ScoreCounter

function ScoreCounter:Draw()
    love.graphics.print( "Score: " .. Score, 25, 15, nil, 2.5, 2.5)
end

return ScoreCounter