--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}
    local GOLD_SCORE = 5
    local SILVER_SCORE = 3
    local BRONZE_SCORE = 1
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    local medal_image = ''
    if self.score >= GOLD_SCORE then
        medal_image = love.graphics.newImage('gold.png')
    elseif self.score >= SILVER_SCORE then
        medal_image = love.graphics.newImage('silver.png')
    elseif self.score >= BRONZE_SCORE then
        medal_image = love.graphics.newImage('bronze.png')
    end
    if self.score ~= 0 then
        love.graphics.draw(medal_image, VIRTUAL_WIDTH/2 - 15, 120)
    end
     
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end