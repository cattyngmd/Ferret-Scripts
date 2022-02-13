--gui
--author: amfero

function main()

    local guim = Module.new("Gui", "description", "CLIENT", this)

    guim:body(function(mod)

        local categories = 
        {
            "COMBAT",
            "VISUAL",
            "MOVEMENT",
            "PLAYER",
            "MISC",
            "CLIENT"
        }
    
        local gui = GuiBuilder.new("Gui")

        local modules = client:getModuleManager()

        local opts = {}

        local text = ""

        local typing = false

        local opti

        gui:setRender(function(matrix, point)

            local mxy = {}
            local oxy = {}

            local c = 0
            local v = 0
            local m = 0
            local p = 0
            local mi = 0
            local co = 0
        
            renderer:rectFilled(matrix, vec2d(0, 0), vec2d(mc:getWindow():getScaledWidth(), mc:getWindow():getScaledHeight()), color(0, 0, 0, 150))

            for i = 1, #categories do

                renderer:rectFilled(matrix, vec2d(i * 100 - 2, 28), vec2d(i * 100 + 80, 40), color(0, 0, 0, 255))
                renderer:textWithShadow(matrix, tostring(categories[i]), vec2d(i * 100, 30), color(255, 255, 255, 255))

            end

            for i = 0, modules:size() - 1 do

                local module = modules:get(i)
                
                local clr

                if(module:isToggled()) then
                    clr = 
                    {
                        55,
                        255,
                        55
                    }

                else
                    clr = 
                    {
                        255,
                        255,
                        255
                    }
                end

                if(tostring(module:getCategory()) == "COMBAT") then
                    c = c + 1
                    renderer:rectFilled(matrix, vec2d(1 * 100 - 2, 42 + c * 11 - 11), vec2d(1 * 100 + 80, 42 + c * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(1 * 100, 32 + c * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 100)
                    table.insert(mxy, 32 + c * 11)
                end

                if(tostring(module:getCategory()) == "VISUAL") then
                    v = v + 1
                    renderer:rectFilled(matrix, vec2d(2 * 100 - 2, 42 + v * 11 - 11), vec2d(2 * 100 + 80, 42 + v * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(2 * 100, 32 + v * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 200)
                    table.insert(mxy, 32 + v * 11)
                end

                if(tostring(module:getCategory()) == "MOVEMENT") then
                    m = m + 1
                    renderer:rectFilled(matrix, vec2d(3 * 100 - 2, 42 + m * 11 - 11), vec2d(3 * 100 + 80, 42 + m * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(3 * 100, 32 + m * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 300)
                    table.insert(mxy, 32 + m * 11)
                end

                if(tostring(module:getCategory()) == "PLAYER") then
                    p = p + 1
                    renderer:rectFilled(matrix, vec2d(4 * 100 - 2, 42 + p * 11 - 11), vec2d(4 * 100 + 80, 42 + p * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(4 * 100, 32 + p * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 400)
                    table.insert(mxy, 32 + p * 11)
                end

                if(tostring(module:getCategory()) == "MISC") then
                    mi = mi + 1
                    renderer:rectFilled(matrix, vec2d(5 * 100 - 2, 42 + mi * 11 - 11), vec2d(5 * 100 + 80, 42 + mi * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(5 * 100, 32 + mi * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 500)
                    table.insert(mxy, 32 + mi * 11)
                end

                if(tostring(module:getCategory()) == "CLIENT") then
                    co = co + 1
                    renderer:rectFilled(matrix, vec2d(6 * 100 - 2, 42 + co * 11 - 11), vec2d(6 * 100 + 80, 42 + co * 11), color(0, 0, 0, 200))
                    renderer:textWithShadow(matrix, module:getName(), vec2d(6 * 100, 32 + co * 11), color(clr[1], clr[2], clr[3], 255))
                    table.insert(mxy, module:getName())
                    table.insert(mxy, 600)
                    table.insert(mxy, 32 + co * 11)
                end

            end

            gui:setKeyPressed(function(key, scan, modifiers)

                if(handleType(key, true) == "backspace") then
                    text = text:sub(1, -2)
                end

                if(handleType(key, true) == "enter" and typing) then
                    opti:setStringValue(text)
                    typing = not typing
                end

                if(handleType(key, true) == "esc" and typing) then
                    typing = not typing
                end

            end)

            gui:setMouseClicked(function(point, button)

                if(handleType(button, false) == "lcm") then

                    typing = false

                    local x = math.ceil(tonumber(point:x()))
                    local y = math.ceil(tonumber(point:y()))
        
                    for i = 1, #mxy do
                        if(i % 3 == 0) then
                            if(y > mxy[i] - 1 and y < mxy[i] + 11 and x > mxy[i - 1] and x < mxy[i - 1] + 80) then
                                client:getModuleManager():get(mxy[i - 2]):toggle()
                            end
                        end
                    end

                    for i = 1, #oxy do
                        if(i % 3 == 0) then
                            if(y > oxy[i] - 1 and y < oxy[i] + 11 and x > oxy[i - 1] and x < oxy[i - 1] + 80) then
                                local option = oxy[i - 2]
                                opti = option
                                if(option:is("bool")) then
                                    option:setValue(not option:getValue())
                                end
                                if(option:is("number") or option:is("text")) then
                                    typingOption = oxy[1 - 2]
                                    typing = not typing
                                    if(not typing) then
                                        option:setStringValue(text)
                                    else
                                        text = tostring(option:getValue())
                                    end
                                end
                            end
                        end
                    end

                end

                if(handleType(button, false) == "rcm") then

                    opts = {}

                    typing = false

                    local x = math.ceil(tonumber(point:x()))
                    local y = math.ceil(tonumber(point:y()))
        
                    for i = 1, #mxy do
                        if(i % 3 == 0) then
                            if(y > mxy[i] - 1 and y < mxy[i] + 11 and x > mxy[i - 1] and x < mxy[i - 1] + 80) then
                                for j = 1, client:getOptions():size() - 1 do
                                    if(tostring(client:getOptions():get(j):getFeature():getName()) == mxy[i - 2]) then
                                        table.insert(opts, client:getOptions():get(j))
                                    end
                                end
                            end
                        end
                    end

                end

            end)

            if(opts[1] ~= nil) then
                renderer:rectFilled(matrix, vec2d(7 * 100 - 2, 28), vec2d(7 * 100 + 100, 40), color(0, 0, 0, 255))
                renderer:textWithShadow(matrix, opts[1]:getFeature():getName(), vec2d(700, 30), color(255, 255, 255, 255))
            end

            for i = 1, #opts do
                renderer:rectFilled(matrix, vec2d(7 * 100 - 2, 42 + i * 11 - 11), vec2d(7 * 100 + 100, 42 + i * 11), color(0, 0, 0, 200))
                if(typing and opts[i] == opti) then
                    renderer:textWithShadow(matrix, opts[i]:getName() .. ": " .. text .. "...", vec2d(700, 32 + i * 11), color(255, 255, 255, 255))
                else
                    renderer:textWithShadow(matrix, opts[i]:getName() .. ": " .. tostring(opts[i]:getValue()), vec2d(700, 32 + i * 11), color(255, 255, 255, 255))
                end
                table.insert(oxy, opts[i])
                table.insert(oxy, 700)
                table.insert(oxy, 32 + i * 11)
            end

            function handleType(key, iskeyboard)

                if key == 256 and iskeyboard then
                    return "esc"
                end

                if key == 257 and iskeyboard then
                    return "enter"
                end

                if key == 259 and iskeyboard then
                    return "backspace"
                end

                if key == 0 and not iskeyboard then
                    return "lcm"
                end

                if key == 1 and not iskeyboard then
                    return "rcm"
                end

            end

        end)

        gui:setCharTyped(function (char, modi)
            if typing then
                text = text .. string.char(char)
            end
        end)

        local theGui = gui:build()

        guim:onEnable(function()
            mc:setScreen(theGui)
            guim:setToggled(false)
        end)

    end) 

end