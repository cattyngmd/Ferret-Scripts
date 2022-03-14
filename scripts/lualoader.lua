--author: amfero

function main()

    local module = Module.new("LuaLoader", "", "CLIENT", this)

    x = 100
    y = 100
    w = 200
    h = 300
    luas = {}
    data = {}

    module:body(function()
    
        local gui = GuiBuilder.new("Gui")

        gui:setRender(function(matrix, point)

            renderer:rectFilled(matrix, vec2d(x - 3, y - 3), vec2d(x + w + 3, y + h + 3), color(0, 0, 0, 50))
            renderer:rect(matrix, vec2d(x - 1, y - 1), vec2d(x + w, y + h), color(255, 255, 255, 255))
            renderer:rectFilled(matrix, vec2d(x, y), vec2d(x + w, y + h), color(20, 20, 20, 255))
            renderer:text(matrix, "LuaLoader", vec2d(x + 3, y + 3), color(255, 255, 255, 255))

            isLoaded()

            for i = 1, #luas do
                if(isLoaded(luas[i])) then
                    renderer:text(matrix, luas[i], vec2d(x + 3, y + 12 * i + 10), color(255, 255, 255, 255))
                    renderer:text(matrix, "unload,", vec2d(x + 3 + renderer:width(luas[i]) + 5, y + 12 * i + 10), color(100, 255, 100, 255))
                    renderer:text(matrix, "reload", vec2d(x + 3 + renderer:width(luas[i] .. "unload") + 10 , y + 12 * i + 10), color(255, 255, 100, 255))
                    data[i] = {
                        px = x + 3 + renderer:width(luas[i]),
                        py = y + 12 * i + 10
                    }
                else
                    renderer:text(matrix, luas[i], vec2d(x + 3, y + 12 * i + 10), color(255, 255, 255, 255))
                    renderer:text(matrix, "load", vec2d(x + 3 + renderer:width(luas[i]) + 5, y + 12 * i + 10), color(255, 100, 100, 255))
                    data[i] = {
                        px = x + 3 + renderer:width(luas[i]),
                        py = y + 12 * i + 10
                    }
                end
            end

        end)

        gui:setMouseClicked(function(point, button)

            local pX = math.ceil(tonumber(point:x()))
            local pY = math.ceil(tonumber(point:y()))

            for i = 1, #luas do
                if(pX > x + 3 and pX < data[i].px and pY > data[i].py and pY < data[i].py + 10) then
                    print(luas[i])
                end
                if(isLoaded(luas[i])) then
                    if(pX > data[i].px + 5 and pX < data[i].px + 5 + 35 and pY > data[i].py and pY < data[i].py + 9) then
                        mc.player:sendChatMessage("$lua get " .. luas[i] .. " action unload")
                    end
                    if(pX > data[i].px + 5 + 37 and pX < data[i].px + 5 + 40 + 33 and pY > data[i].py and pY < data[i].py + 9) then
                        mc.player:sendChatMessage("$lua get " .. luas[i] .. " action reload")
                    end
                else
                    if(pX > data[i].px + 5 and pX < data[i].px + 5 + 24 and pY > data[i].py and pY < data[i].py + 9) then
                        mc.player:sendChatMessage("$lua load " .. luas[i])
                    end
                end
            end

        end)

        local guibuild = gui:build()

        module:onEnable(function(mod)
            mc:setScreen(guibuild)
            module:setToggled(false)
            luas = {}
            data = {}
            getLuas()
        end)

    end)

    function getLuas()
        files:walk("./ferret/scripts", function(path)
            if(string.sub(tostring(path), 18):find("%.lua")) then
                luas[#luas + 1] = string.sub(tostring(path), 18)
            end
        end)
    end

    function isLoaded(script)
        for i = 0, client:getScripts():size() - 1 do
            if(client:getScripts():get(i):getName() == script) then
                return true
            end
        end
    end

end
