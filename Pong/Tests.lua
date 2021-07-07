luaunit = require('luaunit')
os.exit( luaunit.LuaUnit.run() )
require("main")


function TestItem:load()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = 20
    self.height = 20
    self.speed = 100
end



function testCollision(a, b)
    luaunit.assertEquals(checkCollision(a, b), true)
end

function testNoCollision(a, b)
    luaunit.assertEquals(checkCollision(a, b), false)
end