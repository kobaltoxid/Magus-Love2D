-- Default enemy object.
Player = {
    xPos = 0,
    yPos = 0,
    originX = 0,
    originY = 0,
    width = 16,
    height = 16,
    damage = 1,
    health = 420,
    speed = 50,
    dir = 1,
    lives = 1,
    keys = 0,
    alive = true
}

-- Initialize player object.
function Player:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- Self explanatory.
function Player:attack(eo)
    local result = eo.health - self.damage
    return result
end

-- Set player position.
function Player:setPos(xPos, yPos)
    self.xPos = xPos
    self.yPos = yPos
    self.originX = xPos
    self.originY = yPos
end

-- Reset player position in case of death for instance.
function Player:resetPos()
    self.xPos, self.yPos = self.originX, self.originY
    return self.originX, self.originY
end

-- Self explanatory.
function Player:updateSpritePos(p)
    p.x, p.y = self.xPos, self.yPos
    return p
end

-- Set player sprite.
function Player:setSprite(quad)
    self.sprite = quad
    -- self.sprite = love.graphics.newImage(path)
end

-- Move player
function Player:move(direction, p, dt)
    local goalX, goalY
    local speed = self.speed

    if direction == 'up' then
        goalX, goalY = p.x, p.y - speed * dt
    end
    if direction == 'down' then
        goalX, goalY = p.x, p.y + speed * dt
    end
    if direction == 'left' then
        goalX, goalY = p.x - speed * dt, p.y
    end
    if direction == 'right' then
        goalX, goalY = p.x + speed * dt, p.y
    end

    self.xPos, self.yPos = goalX, goalY
    return goalX, goalY
end

-- Calculate distance between two points.
function dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

-- Flip player spite left or right.
function Player:flip(direction)
    self.dir = direction
end

-- Mark player as dead.
function Player:die()
    self.lives = self.lives - 1
    if self.lives <= 0 then
        self.alive = false
    end
end

-- Restore player health after death.
function Player:revive()
    self.health = 421
end

-- Update player's current health after changes.
function Player:heal(health, p, world)
    self.health = health
    if self.health <= 0 then
        self:die()
        self:revive()
        self:resetPos()
        world:remove(p)
        self:updateSpritePos(p)
        world:add(p, p.x, p.y, 16 / 10, 16 / 50)

    end
end

function Player:changeSpeed(speed)
    self.speed = speed
end

function Player:takeKey(key)
    self.keys = self.keys + key
end

return Player
