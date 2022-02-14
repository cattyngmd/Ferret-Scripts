--gui
--author: amfero

function main()

    local module = Module.new("GUI", "", "CLIENT", this)

    module:body(function(mod) 

        local gui = GuiBuilder.new("Gui")

        local categories = 
        {
            "COMBAT",
            "VISUAL",
            "MOVEMENT",
            "PLAYER",
            "MISC",
            "CLIENT"
        }

        local mxy
        local oxy
        local x = 5
        local y = 30
        local options = {}
        local typing = false
        local typingOption
        local text = ""

        gui:setRender(function(matrix, point)

            mxy = {}
            oxy = {}
            local t1 = 0
            local t2 = 0
            local t3 = 0
            local t4 = 0
            local t5 = 0
            local t6 = 0

            renderer:rectFilled(matrix, vec2d(0, 0), vec2d(mc:getWindow():getScaledWidth(), mc:getWindow():getScaledHeight()), color(0, 0, 0, 150))

            for i = 1, #categories do

                renderer:rectFilled(matrix, vec2d(x + i * 120 - 2, y - 1), vec2d(x + i * 120 + 100 + 4, y + 11), color(10, 10, 10, 200))
                renderer:rectFilled(matrix, vec2d(x + i * 120 - 2, y + 11), vec2d(x + i * 120 + 100 + 4, y + 14), color(50, 50, 50, 100))
                renderer:textWithShadow(matrix, tostring(categories[i]), vec2d(x + i * 120, y + 1), color(255, 255, 255, 255))

            end

            local modules = client:getModuleManager()

            for i = 0, modules:size() - 1 do

                local module = modules:get(i)
                local moduleName = module:getName()
                local moduleCategory = tostring(module:getCategory())

                local rgb

                if(module:isToggled()) then
                    rgb = {55, 255, 55}
                else
                    rgb = {200, 200, 200}
                end

                if(moduleCategory == categories[1]) then

                    t1 = t1 + 1

                    renderer:rectFilled(matrix, vec2d(x + 1 * 120 - 2, y + 4 + 12 * t1 - 2), vec2d(x + 1 * 120 + 100 + 4,  y + 4 + 12 * t1 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 1 * 120, y + 4 + 12 * t1), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 1 * 120)
                    table.insert(mxy, y + 4 + 12 * t1)

                end

                if(moduleCategory == categories[2]) then

                    t2 = t2 + 1

                    renderer:rectFilled(matrix, vec2d(x + 2 * 120 - 2, y + 4 + 12 * t2 - 2), vec2d(x + 2 * 120 + 100 + 4,  y + 4 + 12 * t2 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 2 * 120, y + 4 + 12 * t2), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 2 * 120)
                    table.insert(mxy, y + 4 + 12 * t2)

                end

                if(moduleCategory == categories[3]) then

                    t3 = t3 + 1

                    renderer:rectFilled(matrix, vec2d(x + 3 * 120 - 2, y + 4 + 12 * t3 - 2), vec2d(x + 3 * 120 + 100 + 4,  y + 4 + 12 * t3 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 3 * 120, y + 4 + 12 * t3), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 3 * 120)
                    table.insert(mxy, y + 4 + 12 * t3)

                end

                if(moduleCategory == categories[4]) then

                    t4 = t4 + 1

                    renderer:rectFilled(matrix, vec2d(x + 4 * 120 - 2, y + 4 + 12 * t4 - 2), vec2d(x + 4 * 120 + 100 + 4,  y + 4 + 12 * t4 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 4 * 120, y + 4 + 12 * t4), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 4 * 120)
                    table.insert(mxy, y + 4 + 12 * t4)

                end

                if(moduleCategory == categories[5]) then

                    t5 = t5 + 1

                    renderer:rectFilled(matrix, vec2d(x + 5 * 120 - 2, y + 4 + 12 * t5 - 2), vec2d(x + 5 * 120 + 100 + 4,  y + 4 + 12 * t5 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 5 * 120, y + 4 + 12 * t5), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 5 * 120)
                    table.insert(mxy, y + 4 + 12 * t5)

                end

                if(moduleCategory == categories[6]) then

                    t6 = t6 + 1

                    renderer:rectFilled(matrix, vec2d(x + 6 * 120 - 2, y + 4 + 12 * t6 - 2), vec2d(x + 6 * 120 + 100 + 4,  y + 4 + 12 * t6 + 10), color(10, 10, 10, 200))
                    renderer:textWithShadow(matrix, moduleName, vec2d(x + 6 * 120, y + 4 + 12 * t6), color(rgb[1], rgb[2], rgb[3], 255))

                    table.insert(mxy, moduleName)
                    table.insert(mxy, x + 6 * 120)
                    table.insert(mxy, y + 4 + 12 * t6)

                end

            end

            for i = 1, #options do

                local index = find(options[i]:getFeature():getName())

                if(typing and options[i] == typingOption) then
                    string = options[i]:getName() .. ": " .. text .. "..."
                else
                    string = options[i]:getName() .. ": " .. tostring(options[i]:getValue())
                end

                renderer:rectFilled(matrix, vec2d(mxy[index + 1] + 45 - 2, mxy[index + 2] + i * 12 - 8), vec2d(mxy[index + 1] + renderer:width(string) + 48, mxy[index + 2] + i * 12 + 4), color(10, 10, 10, 255))
                renderer:textWithShadow(matrix, string, vec2d(mxy[index + 1] + 45, mxy[index + 2] + i * 12 - 6), color(255, 255, 255, 255))

                table.insert(oxy, options[i])
                table.insert(oxy, mxy[index + 1] + 45)
                table.insert(oxy, mxy[index + 2] + i * 12 - 6)

            end

        end)

        gui:setMouseClicked(function(point, button)

            local pointX = math.ceil(tonumber(point:x()))
            local pointY = math.ceil(tonumber(point:y()))

            local modules = client:getModuleManager()
            local getOptions = client:getOptions()

            if(handleType(button, false) == "lcm") then

                typing = false
                        
                for i = 1, #mxy do
                    if(i % 3 == 0 and options[1] == nil) then
                        if(pointY > mxy[i] - 1 and pointY < mxy[i] + 12 and pointX > mxy[i - 1] - 2 and pointX < mxy[i - 1] + 104) then
                            modules:get(mxy[i - 2]):toggle()
                        end
                    end
                end

                for i = 1, #oxy do
                    if(i % 3 == 0) then
                        if(pointY > oxy[i] - 1 and pointY < oxy[i] + 12 and pointX > oxy[i - 1] - 2 and pointX < oxy[i - 1] + renderer:width(oxy[i - 2]:getName()) + 34) then
                            if(typing == true) then typing = false end
                            local option = oxy[i - 2]
                            if(option:is("bool")) then
                                option:setValue(not option:getValue())
                            end
                            if(option:is("number") or option:is("text")) then
                                typingOption = oxy[i - 2]
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

                options = {}
                if(typing == true) then typing = false end

                for i = 1, #mxy do
                    if(i % 3 == 0) then
                        if(pointY > mxy[i] - 1 and pointY < mxy[i] + 11 and pointX > mxy[i - 1] - 2 and pointX < mxy[i - 1] + 104) then
                            for j = 1, getOptions:size() - 1 do
                                if(tostring(getOptions:get(j):getFeature():getName()) == mxy[i - 2]) then
                                    table.insert(options, getOptions:get(j))
                                end
                            end
                        end
                    end
                end

            end

        end)

        gui:setKeyPressed(function(key, scan, modifiers)

            if(handleType(key, true) == "backspace") then
                text = text:sub(1, -2)
            end

            if(handleType(key, true) == "enter" and typing) then
                typingOption:setStringValue(text)
                typing = not typing
            end

            if(handleType(key, true) == "esc" and typing) then
                typing = not typing
                options = {}
            end

        end)

        gui:setCharTyped(function (char, modi)

            if typing then
                text = text .. string.char(char)
            end

        end)

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

        function find(arg)

            for i = 1, #mxy do
                if(mxy[i] == arg) then
                    return i
                end
            end

        end

        local guib = gui:build()

        module:onEnable(function()
            mc:setScreen(guib)
            module:setToggled(false)
        end)

    end)

end
