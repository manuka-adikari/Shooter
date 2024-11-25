EnemyClass = {}
EnemyClass.__index = EnemyClass

function EnemyClass.new()
    local self = setmetatable({}, EnemyClass)
    self.SpawnRadiusX = {100, 600}
    self.SpawnRadiusY = {100, 400}
    self.SpawnX = 0
    self.SpawnY = 0
    self.isAlive = false
    return self
end

function EnemyClass:Update()
    if self.isAlive == true then
        if ShotX >= self.SpawnX and ShotX <= self.SpawnX + 20 and ShotY >= self.SpawnY and ShotY <= self.SpawnY + 20 then --Checks if the fired shot is inside the cube
            Score = Score + 1
            self.isAlive = false
        end
    elseif self.isAlive == false then 
        self.SpawnX = math.random(self.SpawnRadiusX[1], self.SpawnRadiusX[2])
        self.SpawnY = math.random(self.SpawnRadiusY[1], self.SpawnRadiusY[2])
        self.isAlive = true
    end
end

function EnemyClass:Draw()
    love.graphics.rectangle("fill", self.SpawnX, self.SpawnY, 20, 20)
end

return EnemyClass