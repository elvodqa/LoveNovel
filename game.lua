game = {
    title = "",
    author = "",
    version = "",
    description = "",
    url = "",
    email = "",
    license = "",
    year = "",

    directory = "",
    state = {},
    scripts = {},
    vars = {},
    saves = {},
    dialog_tree = {},

    -- game info
    dialogSpeaker = "",
    dialogText = "",
}

function game:load(dir)
    self.directory = dir
    -- scripts are in directory, check or like: script.lua, or (script1.lua, script2.lua, script3.lua...)
    for i, v in ipairs(love.filesystem.getDirectoryItems(self.directory)) do
        if string.sub(v, -4) == ".lua" then
            -- script(1,2,3..).lua
            if string.sub(v, 1, 6) == "script" then
                table.insert(self.scripts, require(self.directory .. "." .. string.sub(v, 1, -5)))
            end
            -- var.lua
            if string.sub(v, 1, 3) == "var" then
                table.insert(self.vars, require(self.directory .. "." .. string.sub(v, 1, -5)))
            end
            -- save.lua
            if string.sub(v, 1, 4) == "save" then
                table.insert(self.saves, require(self.directory .. "." .. string.sub(v, 1, -5)))
            end
        end
    end
end

function game:say(str) 
    self.dialogText = str
    coroutine.yield()
    print(str)
    self.dialogText = nil
end


function game:run(script) 
    local f = loadfile(script)
    setfenv(f, game)
    routine = coroutine.create(f)

    -- begin execution of the script
    coroutine.resume(routine)
end

function game:resume()
    coroutine.resume(routine)
end

function game:keypressed(key, isRepeat)
    if self.dialogText and key == "space" then
        if routine and coroutine.status(routine) ~= "dead" then
            -- execute the next part of the script
            coroutine.resume(routine)
        end
    end
end