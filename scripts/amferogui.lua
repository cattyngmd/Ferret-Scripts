function main()

    local module = Module.new("ClickGUI", "", "CLIENT", this)

    local x = 100
    local y = 100
    local w = 420
    local h = 250

    local action = ""
    local currentCategory = "COMBAT"
    local currentModule = nil
    local currentSetting = nil
    local bindingModule = nil
    local settings = {}
    local text = ""
    local bool = false

    local categories = 
    {
        "COMBAT",
        "VISUAL",
        "MOVEMENT",
        "PLAYER",
        "MISC",
        "CLIENT"
    }

    module:body(function()

        local gui = GuiBuilder.new("Gui")

        gui:setRender(function(matrix, point)

            if(bool) then
                x = point:x() - 160
                y = point:y() 
            end

            renderer:roundedRectFilled(matrix, vec2d(x - 1, y - 1), vec2d(x + w + 1, y + h + 1), 10, color(255, 255, 255, 255))
            renderer:roundedRectFilled(matrix, vec2d(x, y), vec2d(x + w, y + h), 10, color(20, 20, 20, 255))

            for i = 1, #categories do

                local textX = x + 60 * i - renderer:width(categories[i]) / 2
                local textX2 = x + 60 * i - renderer:width(categories[i]) / 2 + renderer:width(categories[i])

                renderer:text(matrix, categories[i], vec2d(textX, y + 20), color(255, 255, 255, 255))
                
                if(action == "lcm") then

                    currentSetting = nil
                    bindingModule = nil

                    if(point:x() > textX - 2 and point:x() < textX2 + 2 and point:y() > y + 20 - 2 and point:y() < y + 30 + 2) then
                        currentCategory = categories[i]
                        currentModule = nil
                        settings = {}
                    end

                end

                if(action == "rcm") then

                    currentModule = nil
                    currentSetting = nil
                    bindingModule = nil
                    settings = {}

                end

                if(categories[i] == currentCategory) then
                    renderer:rectFilled(matrix, vec2d(textX - 2, y + 30), vec2d(textX2 + 2, y + 31), color(255, 255, 255, 255))
                else
                    renderer:rectFilled(matrix, vec2d(textX - 2, y + 30), vec2d(textX2 + 2, y + 31), color(200, 200, 200, 150))
                end

                local currentModules = {}
                local modules = client:getModuleManager()

                for j = 0, modules:size() - 1 do

                    local mod = modules:get(j)

                    if(tostring(mod:getCategory()) == currentCategory) then
                        currentModules[#currentModules + 1] = mod
                    end

                end

                table.sort(currentModules, function(a, b) return #a:getName() < #b:getName() end)

                for i = 1, #currentModules do

                    local textX1 = x + 30
                    local textX12 = x + 30 + renderer:width(currentModules[i]:getName())

                    if(currentModules[i]:isToggled()) then 
                        renderer:text(matrix, currentModules[i]:getName(), vec2d(textX1, y + 40 + 12 * i), color(100, 255, 100, 255))
                    else
                        renderer:text(matrix, currentModules[i]:getName(), vec2d(textX1, y + 40 + 12 * i), color(200, 200, 200, 255))
                    end

                    if(point:x() > textX1 - 2 and point:x() < textX12 + 2 and point:y() > y + 40 + 12 * i - 2 and point:y() < y + 40 + 12 * i + 10 + 2) then
                        if(action == "rcm") then
                            currentModule = currentModules[i]
                            for j = 1, client:getOptions():size() - 1 do
                                if(tostring(client:getOptions():get(j):getFeature():getName()) == currentModule:getName()) then
                                    settings[#settings + 1] = client:getOptions():get(j)
                                end
                            end
                            action = ""
                        end
                        if(action == "lcm") then
                            currentModules[i]:toggle()
                            action = ""
                        end
                    end

                end

                if(currentModule ~= nil) then
                    renderer:text(matrix, currentModule:getName(), vec2d(x + w - 30 - renderer:width(currentModule:getName()), y + 40 + 12), color(155, 155, 155, 255))

                    if(bindingModule == currentModule) then
                        renderer:text(matrix, "Key: " .. "..", vec2d(x + w - 65, y + h - 20), color(155, 155, 155, 255))
                    else
                        renderer:text(matrix, "Key: " .. currentModule:getKey(), vec2d(x + w - 65, y + h - 20), color(155, 155, 155, 255)) 
                    end

                    if(point:x() > x + w - 65 - 2 and point:x() < x + w - 65 + 30 and point:y() > y + h - 20 - 2 and point:y() < y + h - 10 + 2) then
                        if(action == "lcm") then
                            bindingModule = currentModule
                        end
                    end
                end

            end

            for i = 1, #settings do

                if(settings[i] == currentSetting) then
                    renderer:text(matrix, settings[i]:getName() .. ": " .. text .. "..", vec2d(x + w - 30 - renderer:width(settings[i]:getName() .. ": " .. text .. ".."), y + 60 + 12 * i), color(255, 255, 255, 255))
                else
                    renderer:text(matrix, settings[i]:getName() .. ": " .. tostring(settings[i]:getValue()), vec2d(x + w - 30 - renderer:width(settings[i]:getName() .. ": " .. tostring(settings[i]:getValue())), y + 60 + 12 * i), color(255, 255, 255, 255))
                end

                if(point:x() > x + w - 30 - renderer:width(settings[i]:getName() .. ": " .. tostring(settings[i]:getValue())) - 2 and point:x() < x + w - 30 + 2 and point:y() > y + 60 + 12 * i - 2 and point:y() < y + 60 + 12 * i + 10 + 2) then
                    if(action == "lcm") then
                        if(settings[i]:is("bool")) then
                            settings[i]:setValue(not settings[i]:getValue())
                        end
                        if(settings[i]:is("number") or settings[i]:is("text")) then
                            currentSetting = settings[i]
                            if(currentSetting == nil) then
                                settings[i]:setStringValue(text)
                            else
                                text = tostring(settings[i]:getValue())
                            end
                        end
                        action = ""
                    end
                end

            end

            action = ""

        end)

        gui:setCharTyped(function (char, modi)
            if(currentSetting ~= nil) then
                text = text .. string.char(char)
            end
        end)

        gui:setMouseReleased(function(point, button)
            bool = false
        end)

        gui:setMouseClicked(function(point, button)
            if(point:x() > x and point:x() < x + w and point:y() > y and point:y() < y + 15) then
                bool = true
            end

            handleType(button, false)
        end)

        gui:setKeyPressed(function(key, scan, modifiers)
            handleType(key, true)
        end)

        function handleType(key, iskeyboard)
            if(key == 0 and not iskeyboard) then
                action = "lcm"
            end
            if(key == 1 and not iskeyboard) then
                action = "rcm"
            end
            if(key == 257 and iskeyboard) then
                currentSetting:setStringValue(text)
                currentSetting = nil
            end
            if(key == 259 and iskeyboard and currentSetting ~= nil) then
                text = text:sub(1, -2)
            end
            if(bindingModule ~= nil) then
                bindingModule:setKey(key)
                bindingModule = nil
            end
        end

        local guibuild = gui:build()

        module:onEnable(function()
            mc:setScreen(guibuild)
            module:setToggled(false)
            currentSetting = nil
        end)

    end)

end
