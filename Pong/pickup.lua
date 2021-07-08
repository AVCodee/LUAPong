pickup = {}
pickup.__index = pickup
ActivePickups = {}


function pickup.new(x,y)
    instance = setmetatable({}, pickup)
    instance.x = x
    instance.y = y
    instance.width = 80
    instance.height = 80
    instance.scaleX = 1
    instance.speed = 100
    instance.xVel = -instance.speed
    instance.yVel = 0
    table.insert(ActivePickups, instance)
end 

function pickup:remove()
    for i,instance in ipairs(ActivePickups) do
        if instance == self then
            table.remove(ActivePickups, i)
        end
    end
end

function pickup:collect()
    for i, instance in ipairs(ActivePickups) do
        if instance == self then
            if checkCollision(instance, Player) then
                Ball.speed = Ball.speed*2
                pickup:remove()
            end
        end
    end
end


function pickup:move(dt)
    for i, instance in ipairs(ActivePickups) do
        instance.x = instance.x + instance.xVel * dt
        instance.y = instance.y + instance.yVel * dt
    end
end

function pickup:update(dt)
    
    self:collect()
  
end




function pickup:draw()
    --[[
    for i, instance in ipairs(ActivePickups) do
        love.graphics.rectangle("fill", instance.x, instance.y, instance.width, instance.height)
    end ]]
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