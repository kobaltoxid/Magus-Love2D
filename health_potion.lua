local health_potion = {
    x = 0,
    y = 0,
    hp = 50,
    taken = false
}

-- Initialize health potion object.
function health_potion:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function health_potion:setPos(xPos, yPos)
    self.x, self.y = xPos, yPos
end

function health_potion:take(curr)
    self.taken = true
    curr = curr + self.hp
    self.hp = 0
    return curr
end

function health_potion:damage()
    self.hp = self.hp * -1
end

return health_potion