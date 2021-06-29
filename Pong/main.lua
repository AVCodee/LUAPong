require("player")
require("ball")
require("ai")

function love.load()
    Player:load()
    Ball:load()
    AI:load()

    Score = {player=0, ai=0}
    font = love.graphics.newFont(30)
    endgame = false

end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    AI:update(dt)
    checkWinner(dt)

    
end

function love.draw()
    if endgame then
        drawWinner()
        
    else
        Player:draw()
        Ball:draw()
        AI:draw(0)
        drawScore()
    end
end

function drawScore()
    love.graphics.setFont(font)
    love.graphics.print("Player: "..Score.player, 50, 50)
    love.graphics.print("Opponent: "..Score.ai, 1000, 50)
end


function checkWinner()
    if Score.player >= 5 then
        winVal = 1
        drawWinner()
    elseif Score.ai >= 5 then
        winVal = 0
        drawWinner()
    end

end


function drawWinner() --Add a control situation if both scores < 5 then raise error condition. Remove endgame = true
    love.graphics.setFont(font)
    if winVal == 1 then
        love.graphics.print("Player Wins!", love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() /2 - 50)
    else
        love.graphics.print("Opponent Wins!", love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() /2 - 50)    
    end
    endgame = true
end



function checkCollision(a, b) -- Add Unit Test Cases for proper testing
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else 
        return false
    end 

end
