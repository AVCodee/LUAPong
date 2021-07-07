pickup = {}
pickup.__index = pickup
ActivePickups = {}


function pickup.new(x,y)
    instance = setmetatable({}, pickup)
    instance.x = x
    instance.y = y
    instance.width = 80
    instance.height = 80
    table.insert(ActivePickups, instance)
end 

function pickup:remove()
    for i,instance in ipairs(ActivePickups) do
        if instance == self then
            table.remove(ActivePickups, i)
        end
    end
end

function pickup:update(dt)
    self:collect()
end

function pickup:collect()
    if checkCollision(self, Ball) then
        Ball.speed = Ball.speed*2
        pickup:remove()
    end
end


function pickup:draw()
    love.graphics.rectangle("fill", instance.x, instance.y, instance.width, instance.height)

end

function pickup.updateAll(dt)
    for i, instance in ipairs(ActivePickups) do
        pickup:update(dt)
    end
end


function pickup.drawAll()
    for i,instance in ipairs(ActivePickups) do --Will loop until Nil
        instance:draw()
    end
end