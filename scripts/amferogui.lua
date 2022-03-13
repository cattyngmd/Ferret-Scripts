--gui (govnokod)
--author: amfero

function main()

    local module = Module.new("GUI", "", "CLIENT", this)

    local x = 100
    local y = 100

    local tick = 0
    local xx = 0

    module:body(function(mod)

        local categories = 
        {
            "COMBAT",
            "VISUAL",
            "MOVEMENT",
            "PLAYER",
            "MISC",
            "CLIENT"
        }

        local bool = false
        local categoriesX = {}
        local categoriesX2 = {}
        local thisCategory = 1
        local options = {}
        local typing = false
        local typingOption
        local text = ""
        local binding
        local sliderOption

        local gui = GuiBuilder.new("Gui")

        gui:setRender(function(matrix, point)

            local ms = 0
            mxy = {}
            oxy = {}

            local w = mc:getWindow():getScaledWidth()
            local h = mc:getWindow():getScaledHeight()

            renderer:rectFilled(matrix, vec2d(w - 53 - xx, h - 47), vec2d(w - 47, h - 73), color(0, 0, 0, 50))
            renderer:rectFilled(matrix, vec2d(w - 51 - xx, h - 49), vec2d(w - 49, h - 71), color(255, 255, 255, 255))
            renderer:rectFilled(matrix, vec2d(w - 50 - xx, h - 50), vec2d(w - 50, h - 70), color(20, 20, 20, 255))

            tick = tick + 1

            if(tick <= 1 and xx <= renderer:width("maidanhack b_2013") + 8) then
                xx = xx + 2
                tick = 0
            end


            if(xx >= renderer:width("maidanhack b_2013") + 8) then
                renderer:text(matrix, "maidanhack b_2013", vec2d(w - 45 - xx, h - 63), color(255, 255, 255, 255))
            end

            renderer:rectFilled(matrix, vec2d(x - 3, y - 3), vec2d(x + 500 + 3, y + 250 + 3), color(0, 0, 0, 50))
            renderer:rectFilled(matrix, vec2d(x - 1, y - 1), vec2d(x + 500 + 1, y + 250 + 1), color(255, 255, 255, 255))
            renderer:rectFilled(matrix, vec2d(x, y), vec2d(x + 500, y + 250), color(20, 20, 20, 255))

            renderer:rectFilled(matrix, vec2d(x + 40, y + 30), vec2d(x + 500 - 40, y + 31), color(255, 255, 255, 255))

            renderer:rectFilled(matrix, vec2d(x + 255, y + 30 + 8), vec2d(x + 500 - 40, y + 30 + 9), color(255, 255, 255, 15))
            renderer:rectFilled(matrix, vec2d(x + 255, y + 30 + 9), vec2d(x + 255 + 1, y + 250 - 20), color(255, 255, 255, 15))

            renderer:rectFilled(matrix, vec2d(x + 40, y + 30 + 8), vec2d(x + 245, y + 30 + 9), color(255, 255, 255, 15))
            renderer:rectFilled(matrix, vec2d(x + 245 - 1, y + 30 + 9), vec2d(x + 245, y + 250 - 20), color(255, 255, 255, 15))

            renderer:text(matrix, "maidanhack b_2013", vec2d(x + 3, y + 250 - 11), color(255, 255, 255, 255))

            for i = 1, #categories do

                local n = x + 18 + 66 * i - renderer:width(tostring(categories[i])) / 2

                renderer:text(matrix, tostring(categories[i]), vec2d(n, y + 15), color(255, 255, 255, 255))

                if(point:x() > n - 4 and point:x() < n + renderer:width(tostring(categories[i])) + 2 and point:y() > y + 14 and point:y() < y + 26) then
                    renderer:rectFilled(matrix, vec2d(n - 2, y + 24), vec2d(n + renderer:width(tostring(categories[i])) + 2, y + 26), color(255, 255, 255, 255))
                else
                    renderer:rectFilled(matrix, vec2d(n - 2, y + 24), vec2d(n + renderer:width(tostring(categories[i])) + 2, y + 26), color(255, 255, 255, 100))
                end

                modules = client:getModuleManager()

                if(thisCategory == i) then

                    renderer:rectFilled(matrix, vec2d(n - 2, y + 24), vec2d(n + renderer:width(tostring(categories[i])) + 2, y + 26), color(100, 255, 100, 255))

                    for j = 0, modules:size() - 1 do

                        local module = modules:get(j)
                        local moduleName = module:getName()
                        local moduleCategory = tostring(module:getCategory())

                        if(moduleCategory == categories[i]) then

                            ms = ms + 1
                            renderer:text(matrix, moduleName, vec2d(x + 45, y + 30 + 14 * ms), color(255, 255, 255, 255))

                            if(point:x() > x + 45 and point:x() < x + 45 + renderer:width(moduleName) and point:y() > y + 30 + 14 * ms and point:y() < y + 30 + 14 * ms + 10) then
                                renderer:rectFilled(matrix, vec2d(x + 45 - 1, y + 30 + 14 * ms + 9), vec2d(x + 45 + renderer:width(moduleName) + 1, y + 30 + 14 * ms + 10), color(255, 255, 255, 255))
                            else
                                renderer:rectFilled(matrix, vec2d(x + 45 - 1, y + 30 + 14 * ms + 9), vec2d(x + 45 + renderer:width(moduleName) + 1, y + 30 + 14 * ms + 10), color(255, 255, 255, 100))
                            end

                            if(module:isToggled()) then 
                                renderer:rectFilled(matrix, vec2d(x + 45 - 1, y + 30 + 14 * ms + 9), vec2d(x + 45 + renderer:width(moduleName) + 1, y + 30 + 14 * ms + 10), color(100, 255, 100, 255))
                            end

                            table.insert(mxy, module)
                            table.insert(mxy, x + 45 + renderer:width(moduleName) + 1)
                            table.insert(mxy, y + 30 + 14 * ms)

                        end

                    end

                end

                table.insert(categoriesX, n - 4)
                table.insert(categoriesX2, n + renderer:width(tostring(categories[i])) + 2)

            end

            for i = 1, #options do

                if(options[2] == "") then

                    renderer:text(matrix, options[1]:getName(), vec2d(x + 255 + 5, y + 30 + 14), color(255, 255, 255, 255))

                    local bindString

                    if(binding) then
                        bindString = "Key: " .. options[1]:getKey() .. "..."
                        bindingModule = options[1]
                    else
                        bindString = "Key: " .. options[1]:getKey()
                    end

                    renderer:text(matrix, bindString, vec2d(x + 255 + 5, y + 250 - 30), color(255, 255, 255, 255))

                else

                    if(typing and options[i] == typingOption) then
                        string = options[i]:getName() .. ": " .. text .. "..."
                    else
                        string = options[i]:getName() .. ": " .. tostring(options[i]:getValue())
                    end
    
                    --todo: slider
                    if((i == 1 and options[i]:is("number")) or (i % 3 == 0 and options[i]:is("number"))) then
                        --local ind = 100 / (options[i]:getMax() - options[i]:getMin()) 
                    end

                    renderer:text(matrix, options[i]:getFeature():getName(), vec2d(x + 255 + 5, y + 30 + 14), color(255, 255, 255, 255))
                    renderer:text(matrix, string, vec2d(x + 255 + 5, y + 30 + 14 + 14 * i), color(255, 255, 255, 255))

                    local bindString

                    if(binding) then
                        bindString = "Key: " .. modules:get(options[1]:getFeature():getName()):getKey() .. "..."
                        bindingModule = modules:get(options[1]:getFeature():getName())
                    else
                        bindString = "Key: " .. modules:get(options[1]:getFeature():getName()):getKey()
                    end
    
                    renderer:text(matrix, bindString, vec2d(x + 255 + 5, y + 250 - 30), color(255, 255, 255, 255))
    
                    table.insert(oxy, options[i])
                    table.insert(oxy, x + 255 + 5 + renderer:width(string) + 1)
                    table.insert(oxy, y + 30 + 14 + 14 * i)

                end

            end

            if(bool) then
                x = point:x() - 250
                y = point:y() - 5
                categoriesX = {}
                categoriesX2 = {}
            end

        end)

        gui:setMouseClicked(function(point, button)

            local pointX = math.ceil(tonumber(point:x()))
            local pointY = math.ceil(tonumber(point:y()))

            local getOptions = client:getOptions()

            if(handleType(button, false) == "lcm") then

                typing = false
                binding = false

                if(options[1] ~= nil) then
                    if(pointX > x + 255 + 5 - 1 and pointX < x + 255 + 5 + 40 and pointY > y + 250 - 30 and pointY < y + 250 - 20) then
                        binding = true
                    end
                end

                for i = 1, #mxy do
                    if(i % 3 == 0) then
                        if(pointX > x + 45 - 1 and pointX < mxy[i - 1] and pointY > mxy[i] and pointY < mxy[i] + 10) then
                            mxy[i - 2]:toggle()
                        end
                    end
                end

                for i = 1, #oxy do
                    if(i % 3 == 0) then
                        if(pointX > x + 255 + 5 - 1 and pointX < oxy[i - 1] and pointY > oxy[i] and pointY < oxy[i] + 10) then
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
                typing = false
                binding = false

                for i = 1, #mxy do
                    if(i % 3 == 0) then
                        if(pointX > x + 45 - 1 and pointX < mxy[i - 1] and pointY > mxy[i] and pointY < mxy[i] + 10) then
                            p = 0
                            for j = 1, getOptions:size() - 1 do
                                if(tostring(getOptions:get(j):getFeature():getName()) == mxy[i - 2]:getName()) then
                                    p = p + 1
                                    table.insert(options, getOptions:get(j))
                                end
                            end
                            if(p == 0) then
                                table.insert(options, mxy[i - 2])
                                table.insert(options, "")
                            end
                        end
                    end
                end

            end

            if(pointX > x and pointX < x + 500 and pointY > y and pointY < y + 12) then
                bool = true
            end

            if(pointX > categoriesX[1] and pointX < categoriesX2[1] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 1
                options = {}
            end

            if(pointX > categoriesX[2] and pointX < categoriesX2[2] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 2
                options = {}
            end

            if(pointX > categoriesX[3] and pointX < categoriesX2[3] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 3
                options = {}
            end

            if(pointX > categoriesX[4] and pointX < categoriesX2[4] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 4
                options = {}
            end

            if(pointX > categoriesX[5] and pointX < categoriesX2[5] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 5
                options = {}
            end

            if(pointX > categoriesX[6] and pointX < categoriesX2[6] and pointY > y + 14 and pointY < y + 26) then
                thisCategory = 6
                options = {}
            end

        end)

        gui:setMouseReleased(function(point, button)

            local pointX = math.ceil(tonumber(point:x()))
            local pointY = math.ceil(tonumber(point:y()))

            bool = false

        end)

        gui:setKeyPressed(function(key, scan, modifiers)
            handleType(key, true)
        end)

        gui:setCharTyped(function (char, modi)

            if typing then
                text = text .. string.char(char)
            end

        end)

        function handleType(key, iskeyboard)

            if key == 0 and not iskeyboard then
                return "lcm"
            end

            if key == 1 and not iskeyboard then
                return "rcm"
            end

            if key == 257 and iskeyboard and typing then
                typingOption:setStringValue(text)
                typing = not typing
            end

            if(key == 256 and iskeyboard) then
                typing = false
                binding = false
                module:setToggled(false)
            end

            if key == 259 and iskeyboard and typing then
                text = text:sub(1, -2)
            end

            if(binding and bindingModule ~= nil) then
                bindingModule:setKey(key)
                binding = false
            end

        end

        local guibuild = gui:build()

        module:onEnable(function(mod)
            xx = 0
            tick = 0
            mc:setScreen(guibuild)
        end)

    end)

end
