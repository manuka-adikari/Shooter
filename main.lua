love._openConsole() -- Debug

local Config = require("src.Config")
local ShooterClass = require("src.ShooterClass")
local EnemyClass = require("src.EnemyClass")
local ScoreCounter = require("src.ScoreCounter")

-- Global variables
_G.Score = 0

_G.MouseX = 0
_G.MouseY = 0

_G.ShotX = -100
_G.ShotY = -100

_G.SpawnX = -10
_G.SpawnY = -10

function love.load()
    Config()
    anim8 = require("libraries.anim8")

    Shooter = ShooterClass.new()

    Enemy1 = EnemyClass.new()
    Enemy2 = EnemyClass.new()
    Enemy3 = EnemyClass.new()
    Enemy4 = EnemyClass.new()
    Enemy5 = EnemyClass.new()
end

function love.update(deltaTime)
    MouseX, MouseY = love.mouse.getPosition()
    Shooter:Update(deltaTime)
    Enemy1:Update()
    Enemy2:Update()
    Enemy3:Update()
    Enemy4:Update()
    Enemy5:Update()
end

function love.draw()
    Enemy1:Draw()
    Enemy2:Draw()
    Enemy3:Draw()
    Enemy4:Draw()
    Enemy5:Draw()

    Shooter:Draw()

    ScoreCounter:Draw()
end

function love.mousepressed(x, y, button) 
    if button == 1 then 
        if Shooter.gunAnimation ~= Shooter.gunShootAnimation then Shooter.gunAnimation = Shooter.gunShootAnimation end --Changes gun animation from idle to shoot doesnt need to change it back to idle because it pauses at the idle frame
        Shooter.gunAnimation:resume()
        Shooter:Shoot()
    end 
end