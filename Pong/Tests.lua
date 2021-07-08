luaunit = require('luaunit')




function checkCollision(a, b) -- Add Unit Test Cases for proper testing
    a.x = 500
    a.y = 500
    a.width = 300
    a.height = 300

    b.x = 200
    b.y = 200
    b.width = 400
    b.height = 400
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else 
        return false
    end 

end


function testCollision(a, b)
   
    luaunit.assertEquals(checkCollision(a, b), true)
end

function testNoCollision(a, b)
    luaunit.assertEquals(checkCollision(a, b), false)
end

os.exit( luaunit.LuaUnit.run() )