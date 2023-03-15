require("util.string")
require("game")

local mainMenuCanvas
local gameplayCanvas
local pauseMenu = {
    state = "save", -- save, load, options 
    menuSelectionCanvas = nil,
    saveCanvas = nil,
    loadCanvas = nil,
    optionsCanvas = nil,
}

local state = "mainMenu" -- mainMenu, gameplay, pauseMenu
local dialogSpeaker = ""
local dialogText = ""
local gameDirectory = ""


function love.load(args)
    for i, v in ipairs(args) do
        print(i, v)
    end

    for i, v in ipairs(love.filesystem.getDirectoryItems("")) do
        print(i, v)
    end

    gameDirectory = args[1]
    game:load(gameDirectory)
    print("Running script: " .. game.scripts[1])
    game:run(game.scripts[1])
    
    mainMenuCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    gameplayCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    pauseMenu.menuSelectionCanvas = love.graphics.newCanvas(200, love.graphics.getHeight())
    pauseMenu.saveCanvas = love.graphics.newCanvas(love.graphics.getWidth() - 200, love.graphics.getHeight())
    pauseMenu.loadCanvas = love.graphics.newCanvas(love.graphics.getWidth() - 200, love.graphics.getHeight())
    pauseMenu.optionsCanvas = love.graphics.newCanvas(love.graphics.getWidth() - 200, love.graphics.getHeight())

    state = "mainMenu"
end

function love.update(dt)
end


function love.draw()
    if state == "mainMenu" then
        love.graphics.setCanvas(mainMenuCanvas)
            love.graphics.clear()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Main Menu", 10, 10)
            -- draw [Main Menu]


        love.graphics.setCanvas()
        love.graphics.draw(mainMenuCanvas)
    elseif state == "gameplay" then
        love.graphics.setCanvas(gameplayCanvas)
            love.graphics.clear()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Gameplay", 10, 10)
            -- draw [Gameplay]


        love.graphics.setCanvas()
        love.graphics.draw(gameplayCanvas)
    elseif state == "pauseMenu" then
        love.graphics.setCanvas(pauseMenu.menuSelectionCanvas)
            love.graphics.clear()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Save", 10, 10)
            love.graphics.print("Load", 10, 30)
            love.graphics.print("Options", 10, 50)
            -- draw [Pause SelectionMenu]

        love.graphics.setCanvas()
        love.graphics.draw(pauseMenu.menuSelectionCanvas)

        if pauseMenu.state == "save" then
            love.graphics.setCanvas(pauseMenu.menuSelectionCanvas)
                love.graphics.clear()
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Save", 10, 10)
                -- draw [Save]


            love.graphics.setCanvas()
            love.graphics.draw(pauseMenu.menuSelectionCanvas)
        elseif pauseMenu.state == "load" then
            love.graphics.setCanvas(pauseMenu.menuSelectionCanvas)
                love.graphics.clear()
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Load", 10, 10)
                -- draw [Load]


            love.graphics.setCanvas()
            love.graphics.draw(pauseMenu.menuSelectionCanvas)
        elseif pauseMenu.state == "options" then
            love.graphics.setCanvas(pauseMenu.menuSelectionCanvas)
                love.graphics.clear()
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Options", 10, 10)
                -- draw [Options]


            love.graphics.setCanvas()
            love.graphics.draw(pauseMenu.menuSelectionCanvas)
        end
    end
end

function love.keypressed(key, isRepeat)
    game:keypressed(key, isRepeat)
end