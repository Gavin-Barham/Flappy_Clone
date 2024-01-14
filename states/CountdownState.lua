--[[
    Countdown State
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Counts down visually on the screen (3,2,1) so that the player knows the
    game is about to begin. Transitions to the PlayState as soon as the
    countdown is complete.
]]

CountdownState = Class{__includes = BaseState}

-- takes 1 second to count down each time
COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
    self.isPaused = false
end

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function CountdownState:update(dt)
    if love.keyboard.wasPressed('p') then
        self.isPaused = not self.isPaused
    end
    if not self.isPaused then
        self.timer = self.timer + dt

        -- loop timer back to 0 (plus however far past COUNTDOWN_TIME we've gone)
        -- and decrement the counter once we've gone past the countdown time
        if self.timer > COUNTDOWN_TIME then
            self.timer = self.timer % COUNTDOWN_TIME
            self.count = self.count - 1

            -- when 0 is reached, we should enter the PlayState
            if self.count == 0 then
                gStateMachine:change('play')
            end
        end
    end
end

function CountdownState:render()
    counterHeight = 120
    if self.isPaused then
        love.graphics.print('PAUSED', VIRTUAL_WIDTH/2 - 90, 20)
        love.graphics.print('||', VIRTUAL_WIDTH/2 - 16, 70)
    end
        -- render count big in the middle of the screen
        love.graphics.setFont(hugeFont)
        love.graphics.printf(tostring(self.count), 0, counterHeight, VIRTUAL_WIDTH, 'center')
end