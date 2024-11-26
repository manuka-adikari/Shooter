EnemyClass = {}
EnemyClass.__index = EnemyClass

function EnemyClass.new()
    local self = setmetatable({}, EnemyClass)
    self.SpawnRadiusX = {100, 600}
    self.SpawnRadiusY = {100, 400}
    self.SpawnX = math.random(self.SpawnRadiusX[1], self.SpawnRadiusX[2])
    self.SpawnY = math.random(self.SpawnRadiusY[1], self.SpawnRadiusY[2])
    self.isAlive = true

    self.HitboxOffsetX = 23
    self.HitboxOffsetY = 10
    self.HitboxWidth = 13
    self.HitboxHeight = 50

    self.enemyIdle = love.graphics.newImage("assets/enemy-idle.png")
    self.enemyIdleGrid = anim8.newGrid(64, 64, self.enemyIdle:getWidth(), self.enemyIdle:getHeight())
    self.enemyIdleAnimation = anim8.newAnimation(self.enemyIdleGrid('1-6', 1), 0.1)

    self.enemyDeath = love.graphics.newImage("assets/enemy-death.png")
    self.enemyDeathGrid = anim8.newGrid(64, 64, self.enemyDeath:getWidth(), self.enemyDeath:getHeight())
    self.enemyDeathAnimation = anim8.newAnimation(self.enemyDeathGrid('1-3', '1-3'), 0.1)

    self.enemyCanvas = self.enemyIdle
    self.enemyAnimation = self.enemyIdleAnimation
    return self
end

function EnemyClass:Update(deltaTime)
    if self.isAlive == true then
        if ShotX >= self.SpawnX + self.HitboxOffsetX and ShotX <= self.SpawnX + self.HitboxOffsetX + self.HitboxWidth and ShotY >= self.SpawnY + self.HitboxOffsetY and ShotY <= self.SpawnY + self.HitboxOffsetY + self.HitboxHeight then --Checks if the fired shot is inside the cube
            --Enemy is shot
            Score = Score + 1
            self.isAlive = false
            self.enemyCanvas = self.enemyDeath
            self.enemyAnimation = self.enemyDeathAnimation --Starts death animation
            return
        end
    end

    self.enemyDeathAnimation.onLoop = function() 
        --When death animation ends run these
        if self.isAlive == false then 
            self.SpawnX = math.random(self.SpawnRadiusX[1], self.SpawnRadiusX[2])
            self.SpawnY = math.random(self.SpawnRadiusY[1], self.SpawnRadiusY[2])
            self.isAlive = true
            self.enemyCanvas = self.enemyIdle
            self.enemyAnimation = self.enemyIdleAnimation
        end
    end

    self.enemyAnimation:update(deltaTime)
end

function EnemyClass:Draw()
    --- Hitbox
    --love.graphics.rectangle("fill", self.SpawnX + self.HitboxOffsetX, self.SpawnY + self.HitboxOffsetY, self.HitboxWidth, self.HitboxHeight)

    self.enemyAnimation:draw(self.enemyCanvas, self.SpawnX, self.SpawnY)
end

return EnemyClass