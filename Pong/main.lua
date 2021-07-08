require("player")
require("ball")
require("ai")
require("pickup")
require("Ball2")
local game_state = 'menu'
local menus = { 'Play', 'How To Play', 'Quit' }
local selected_menu_item = 1
local window_width
local window_height
local font_height

-- functions
local draw_menu
local menu_keypressed
local draw_how_to_play
local how_to_play_keypressed
local draw_game
local game_keypressed

function love.load()

  window_width, window_height = love.graphics.getDimensions()
  local font = love.graphics.setNewFont(30)
  font_height = font:getHeight()

end

function love.update(dt)

  if game_state == 'game' then
    -- update everything in the game
  end

end

function love.draw()
  
  if game_state == 'menu' then
    draw_menu()

  elseif game_state == 'how-to-play' then
    draw_how_to_play()

  else -- game_state == 'game'
    draw_game()

  end

end

function draw_menu()

  local horizontal_center = window_width / 2
  local vertical_center = window_height / 2
  local start_y = vertical_center - (font_height * (#menus / 2))

  -- draw guides to help check if menu items are centered, can remove later
  -- love.graphics.setColor(1, 1, 1, 0.1)
  -- love.graphics.line(horizontal_center, 0, horizontal_center, window_height)
  -- love.graphics.line(0, vertical_center, window_width, vertical_center)

  -- draw game title
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf("Breakout", 0, 150, window_width, 'center')

  -- draw menu items
  for i = 1, #menus do

    -- currently selected menu item is yellow
    if i == selected_menu_item then
      love.graphics.setColor(1, 1, 0, 1)

    -- other menu items are white
    else
      love.graphics.setColor(1, 1, 1, 1)
    end

    -- draw this menu item centered
    love.graphics.printf(menus[i], 0, start_y + font_height * (i-1), window_width, 'center')

  end

end

function draw_how_to_play()

  love.graphics.printf(
    "this is the 'how-to-play' state, press Esc to go back to the 'menu' state",
    0,
    window_height / 2 - font_height / 2,
    window_width,
    'center')

  -- TODO: implement this function

end

function draw_game()

  love.graphics.printf(
    "this is the 'game' state, press Esc to go back to the 'menu' state",
    0,
    window_height / 2 - font_height / 2,
    window_width,
    'center')

  -- TODO: implement this function

end

function love.keypressed(key, scan_code, is_repeat)

  if game_state == 'menu' then
    menu_keypressed(key)

  elseif game_state == 'how-to-play' then
    how_to_play_keypressed(key)

  else -- game_state == 'game'
    game_keypressed(key)

  end

end

function menu_keypressed(key)

  -- pressing Esc on the main menu quits the game
  if key == 'escape' then
    love.event.quit()

  -- pressing up selects the previous menu item, wrapping to the bottom if necessary
  elseif key == 'up' then

    selected_menu_item = selected_menu_item - 1

    if selected_menu_item < 1 then
      selected_menu_item = #menus
    end

  -- pressing down selects the next menu item, wrapping to the top if necessary
  elseif key == 'down' then

    selected_menu_item = selected_menu_item + 1

    if selected_menu_item > #menus then
      selected_menu_item = 1
    end

  -- pressing enter changes the game state (or quits the game)
  elseif key == 'return' or key == 'kpenter' then

    if menus[selected_menu_item] == 'Play' then
      game_state = 'game'

    elseif menus[selected_menu_item] == 'How To Play' then
      game_state = 'how-to-play'

    elseif menus[selected_menu_item] == 'Quit' then
      love.event.quit()
    end

  end

end

function how_to_play_keypressed(key)

  if key == 'escape' then
    game_state = 'menu'
  end

end

function game_keypressed(key)

  if key == 'escape' then
    game_state = 'menu'
  end

end



function love.load()
    Player:load()
    Ball:load()
    AI:load()
    

    Score = {player=2, ai=0}
    font = love.graphics.newFont(30)
    endgame = false
    --pickup.new(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    

end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    pickup:update(dt)
    AI:update(dt)
    checkWinner(dt)
    spawnCollectible()

    
end

function love.draw()
    if endgame then
        drawWinner()
        
    else
        Player:draw()
        Ball:draw()
        AI:draw(0)
        pickup:draw()
        if endgame == true then
            pickup:draw()
        end
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

function spawnCollectible()
    if Score.player >= 2 then
        pickup.new(love.graphics.getWidth() / 3, love.graphics.getHeight() / 3)
    end
end



function checkCollision(a, b) -- Add Unit Test Cases for proper testing
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else 
        return false
    end 

end


