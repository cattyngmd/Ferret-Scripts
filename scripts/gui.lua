--[[ 
	Click Gui
	author: Cattyn
	the code is bad.. sorry.
]]--

function main()
    local module = Module.new("SimpleGui", "Funny", "VISUAL", this)

    module:body(function(mod)

        local gui = GuiBuilder.new("simple gui")

        local current = 0

        local help = {
            "§eControls: ",
            "§bUp Arrow§r - step forward",
            "§bDown Arrow§r - step backward",
            "§bRight Arrow§r - next page",
            "§bLeft Arrow§r - previous page",
            "§bEnter§r - toggle"
        }

        local pagesName = {
            "§eScript Page",
            "§eModule Page",
            "§eOption Page"
        }

        function page(index)
            if index == 1 then
                return client:getScripts()
            elseif index == 2 then
                return client:getModuleManager()
            else
                return client:getOptions()
            end
        end

        local typing = false
        local text = ""
        local currentType = -1
        local currentPage = 1

        function drawList(matrix, point)

            renderer:textWithShadow(matrix, pagesName[currentPage], vec2d(point:x() + 6, point:y() - 11 * (current + 1)), color(255, 255, 255, 255))

            for i = 0, page(currentPage):size() - 1 do
                local script = page(currentPage):get(i)
                local l_text = "s"

                if currentPage ~= 3 then
                    if script:isToggled() then
                        l_text = string.format("§b%s", script:getName())
                    else
                        l_text = string.format("%s", script:getName())
                    end
                else
                    if typing and i == currentType then
                        l_text = string.format("§b%s§r %s[§e%s§r] <- Editing", script:getFeature():getName(), script:getName(), text)
                    else 
                        l_text = string.format("§b%s§r %s[§e%s§r]", script:getFeature():getName(), script:getName(), tostring(script:getValue()))
                    end
                end
                renderer:textWithShadow(matrix, l_text, vec2d(point:x() + 6, point:y() + 11 * i - 11 * current), color(255, 255, 255, 255))
            end
        end

        gui:setRender(function(matrix, point)
            renderer:rectFilled(matrix, vec2d(0,0), vec2d(renderer:windowWidth(), renderer:windowHeight()), color(0, 0, 0, 150))
            for j = 1, #help do
                renderer:textWithShadow(matrix, help[j], vec2d(2, 2 + 11 * j), color(255, 255, 255, 255))
            end

            drawList(matrix, point)


        end)

        function handleType(key, iskeyboard)
            if key == 257 and iskeyboard or key == 0 and not iskeyboard then
                if currentPage ~= 3 then
                    page(currentPage):get(current):toggle()
                else 
                    local option = page(currentPage):get(current)
                    if option:is("bool") then
                        option:setValue(not option:getValue())
                    elseif option:is("combo") then
                        option:increase()
                    elseif option:is("number") or option:is("text") then
                        currentType = current
                        typing = not typing
                        if not typing then
                            option:setStringValue(text)
                            return
                        else
                            text = tostring(option:getValue())   
                        end
                    end
                end
            end
        end

        gui:setKeyPressed(function(key, scan, modifiers)
            handleType(key, true)

            if typing then
                
                if key == 259 then
                   text = text:sub(1, -2)
                end

            else
                if key == 265 then
                    current = current - 1
                elseif key == 264 then
                    current = current + 1
                elseif key == 263 then
                    currentPage = currentPage - 1
                elseif key == 262 then
                    currentPage = currentPage + 1
                end

                currentPage = math.min(math.max(1, currentPage), 3)
                current = math.min(math.max(0, current), page(currentPage):size() - 1)
            end
        end)

        gui:setMouseClicked(function(point, button)
            handleType(button, false)
        end)

        gui:setMouseScrolled(function (point, amount)
            current = current - amount
            current = math.min(math.max(0, current), page(currentPage):size() - 1)
        end)

        gui:setCharTyped(function (char, modi)
            if typing then
                text = text .. string.char(char)
            end
        end)

        local theGui = gui:build()

        module:onEnable(function()
            mc:setScreen(theGui)
            module:setToggled(false)
        end)

    end)

end
