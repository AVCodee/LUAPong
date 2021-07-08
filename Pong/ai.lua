AI = {}

--Comments: Potentially Draw Circle on Board and use Line of vision for detetcting object. 
function AI:load()
    self.width = 20
    self.height = 100
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.yVel = 0
    self.speed = 500

    self.timer = 0
    self.rate = 0.5
end

function AI:update(dt)
    self:move(dt)
    self:checkBoundaries()
    self.timer = self.timer + dt
    if self.timer > self.rate then
        self.timer = 0
        self:acquireTarget()
    end
end

function AI:move(dt)
    self.y = self.y + self.yVel * dt
end

function AI:acquireTarget()
    if Ball.y + Ball.height < self.y then
        self.yVel = -self.speed
    elseif Ball.y > self.y + self.height then
        self.yVel = self.speed
    else 
        self.yVel = 0
    end 

end

function AI:checkBoundaries()
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end


function AI:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)


end
