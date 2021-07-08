luaunit = require('luaunit')

function checkCollision() -- Add Unit Test Cases for proper testing
    local aX = 500
    local aY = 500
    local aWidth = 300
    local aHeight = 300

    local bX = 200
    local bY = 200
    local bWidth = 400
    local bHeight = 400
    if aX + aWidth > bX and aX < bX + bWidth and aY + aHeight > bY and aY < bY + bHeight then
        return true
    else 
        return false
    end 

end


function testCollision()
    luaunit.assertEquals(checkCollision(), true)
end

function testNoCollision()
    luaunit.assertEquals(checkCollision(), false)
end

os.exit( luaunit.LuaUnit.run() )