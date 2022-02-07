--hud
--author: amfero & cattyn

function main()

    local ahud = Module.new("Hud", "description", "VISUAL", this)

    local DateFormatter = luajava.bindClass("java.time.format.DateTimeFormatter")
    local LocalDateTime = luajava.bindClass("java.time.LocalDateTime")

    local iW = 1
    local resetW = false

    ahud:body(function(mod)

        local watermark = BooleanBuilder(true):name("Watermark"):build(ahud)
        local coords = BooleanBuilder(true):name("CoordHud"):build(ahud)
        local dms = BooleanBuilder(true):name("DirectMsgs"):build(ahud)
        local other = BooleanBuilder(true):name("Other"):build(ahud)
        
        local width = NumberBuilder(75):name("Width"):setBounds(1, 200):build(ahud)
        local speed = NumberBuilder(2):name("Speed"):setBounds(1, 10):build(ahud)
        local r = NumberBuilder(100):name("Red"):setBounds(0, 255):build(ahud)
        local g = NumberBuilder(255):name("Green"):setBounds(0, 255):build(ahud)
        local b = NumberBuilder(150):name("Blue"):setBounds(0, 255):build(ahud)
    
        local msgs = {}

        ahud:registerCallback("events", function(event)
        
            if(event:getName() == "render_2d") then

                local w = mc:getWindow():getScaledWidth()
                local h = mc:getWindow():getScaledHeight() - 10

                if(watermark:getValue()) then
                    
                    local watermarkText = "amferohack // " .. getTime("HH:mm:ss") .. " // " .. globals:getUsername()

                    if resetW then

                        iW = 1
                        resetW = false

                    end

                    if(iW - width:getValue() > renderer:width(watermarkText) + 3) then resetW = true end

                    iW = iW + speed:getValue()

                    renderer:rectFilled(event:getStack(), vec2d(w - renderer:width(watermarkText) - 9,  4), vec2d(w - 5, 5), color(255, 255, 255, 150))
                    renderer:rectFilled(event:getStack(), vec2d(w - renderer:width(watermarkText) + math.max(iW - width:getValue(), 0) - 9,  4), vec2d(w - renderer:width(watermarkText) - 9 + math.min(iW, renderer:width(watermarkText) + 4), 5), color(r:getValue(), g:getValue(), b:getValue(), 255))
                    renderer:rectFilled(event:getStack(), vec2d(w - renderer:width(watermarkText) - 9,  5), vec2d(w - 5, 17), color(1, 1, 1, 150))
                    renderer:textWithShadow(event:getStack(), watermarkText, vec2d(w - renderer:width(watermarkText) - 7, 7), color(255, 255, 255, 255))

                end

                if(coords:getValue()) then

                    local x = mc.player:getX()
                    local y = mc.player:getY()
                    local z = mc.player:getZ()

                    local str = "nil"

                    if(string.find(tostring(mc.currentScreen), "net.minecraft.class_408") or string.find(tostring(mc.currentScreen), "net.optifine.gui.GuiChatOF")) then h = h - 15 end

                    if(mc.world:getRegistryKey():getValue():getPath() == "the_nether") then

                        str = string.format("XYZ: %.1f, %.1f, %.1f (%.1f, %.1f)", x, y, z, x * 8, z * 8)
    
                        renderer:rectFilled(event:getStack(), vec2d(1,  h - 3), vec2d(5 +  renderer:width(str), h - 2), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(1,  h - 2), vec2d(5 +  renderer:width(str), h + 10), color(1, 1, 1, 150))
                        renderer:rectFilled(event:getStack(), vec2d(1,  h + 9), vec2d(5 +  renderer:width(str), h + 10), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(5 +  renderer:width(str),  h - 2), vec2d(6 +  renderer:width(str), h + 9), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(0,  h - 2), vec2d(1, h + 9), color(255, 255, 255, 255))
                        renderer:textWithShadow(event:getStack(), str, vec2d(3, h), color(255, 255, 255, 255))
    
                    else
    
                        str = string.format("XYZ: %.1f, %.1f, %.1f (%.1f, %.1f)", x, y, z, x / 8, z / 8)
    
                        renderer:rectFilled(event:getStack(), vec2d(1,  h - 3), vec2d(5 +  renderer:width(str), h - 2), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(1,  h - 2), vec2d(5 +  renderer:width(str), h + 10), color(1, 1, 1, 150))
                        renderer:rectFilled(event:getStack(), vec2d(1,  h + 9), vec2d(5 +  renderer:width(str), h + 10), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(5 +  renderer:width(str),  h - 2), vec2d(6 +  renderer:width(str), h + 9), color(255, 255, 255, 255))
                        renderer:rectFilled(event:getStack(), vec2d(0,  h - 2), vec2d(1, h + 9), color(255, 255, 255, 255))
                        renderer:textWithShadow(event:getStack(), str, vec2d(3, h), color(255, 255, 255, 255))
    
                    end

                end

                if(other:getValue()) then

                    renderer:textWithShadow(event:getStack(), "server: " .. globals:getServer(), vec2d(w - 5 - renderer:width("server: " .. globals:getServer()), h - 3), color(255, 255, 255, 255))
                    renderer:textWithShadow(event:getStack(), "ping: " .. globals:getPing(), vec2d(w - 5 - renderer:width("ping: " .. globals:getPing()), h - 13), color(255, 255, 255, 255))
                    renderer:textWithShadow(event:getStack(), "fps: " .. globals:getFps(), vec2d(w - 5 - renderer:width("fps: " .. globals:getFps()), h - 23), color(255, 255, 255, 255))

                end

                if(dms:getValue()) then

                    for i = 1, #msgs do

                        if(msgs[i] ~= nil) then
    
                            renderer:rectFilled(event:getStack(), vec2d(4, 100 + i * 12 - 1), vec2d(6 + renderer:width(msgs[i]), 100 + i * 12 + 11), color(1, 1, 1, 150))
                            renderer:textWithShadow(event:getStack(), msgs[i], vec2d(5, 100 + i * 13), color(211, 67, 202, 255))
    
                        end
                        
                        if(i > 7) then

                            msgs = {}

                        end
    
                    end

                end

            end

            if(event:getName() == "packet_receive") then

                if(dms:getValue()) then

                    if(event:is("GameMessageS2CPacket")) then

                        local msg = event:getPacket():getMessage()
    
                        if(string.find(msg:getString(), "whispers:") and string.find(tostring(msg), "light_purple")) then
    
                            table.insert(msgs, msg:getString())
    
                        end
    
                    end
    
                    if(event:is("GameJoinS2CPacket")) then msgs = {} end

                end

            end

        end)

    end)

    function getTime(format)

        return LocalDateTime:now():format(DateFormatter:ofPattern(format))

    end

end
