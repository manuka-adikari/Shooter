ShooterClass = {}
ShooterClass.__index = ShooterClass

EnemyClass = require("src.EnemyClass")

function ShooterClass.new()
    local self = setmetatable({}, ShooterClass)

    self.crosshair = love.graphics.newImage("assets/crosshair.png")
    self.crosshairScale = {0, 0}
    self.crosshairScale[1], self.crosshairScale[2] = self.crosshair:getDimensions()

    self.gun = love.graphics.newImage("assets/guns.png")
    self.gunGrid = anim8.newGrid(215, 200, self.gun:getWidth(), self.gun:getHeight())
    self.gunShootAnimation = anim8.newAnimation(self.gunGrid('1-5', 1), 0.1, 'pauseAtStart')
    self.gunIdleAnimation = anim8.newAnimation(self.gunGrid('1-1', 1), 0.1, 'pauseAtStart')
    self.gunAnimation = self.gunIdleAnimation --Has to set it to idle first or it will play the shoot animation when games starts without any input

    return self
end

function ShooterClass:Update(deltaTime)
    --Gun
    function love.mousepressed(x, y, button) if button == 1 then 
        if self.gunAnimation ~= self.gunShootAnimation then self.gunAnimation = self.gunShootAnimation end --Changes gun animation from idle to shoot doesnt need to change it back to idle because it pauses at the idle frame
        self.gunAnimation:resume()
        ShooterClass:Shoot()
        end end
    self.gunAnimation:update(deltaTime)
end

function ShooterClass:Draw()
    --Crosshair
    love.graphics.draw(self.crosshair, MouseX - self.crosshairScale[1] / 2, MouseY - self.crosshairScale[2] / 2) -- Divide draw-coordinates by image width and height so the center of the image gets drawn at mouse cursor
    ---Gun
    self.gunAnimation:draw(self.gun, MouseX, love.graphics.getHeight() - 200, nil)
end

function ShooterClass:Shoot()
    ShotX = MouseX
    ShotY = MouseY
end

return ShooterClass