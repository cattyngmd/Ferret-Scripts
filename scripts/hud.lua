-- Hud
-- author: Cattyn

function main()
    
    local BetterHud = Module.new("BetterHud", "Yes", "VISUAL", this)

    BetterHud:body(function(mod)
        
        local watermark = TextBuilder("ferret"):name("Watermark"):build(BetterHud)
        local info = BooleanBuilder(true):name("Info"):build(BetterHud)
        local coords = BooleanBuilder(true):name("Coords"):build(BetterHud)
        local nethercoords = BooleanBuilder(true):name("Nether"):build(BetterHud)
        local direction = BooleanBuilder(true):name("Direction"):build(BetterHud)

        BetterHud:registerCallback("events", function(event)
            if(event:getName() == "render_2d") then

                local infoArray = {
                    watermark:getValue(),
                    "server " .. globals:getServer(),
                    "fps " .. globals:getFps()
                }

                if info:getValue() then
                    
                    for i = 1, #infoArray do
                        renderer:textWithShadow(event:getStack(), infoArray[i], vec2d(2, 2 + 11 * (i - 1)), color(255, 255, 255, 255))
                    end
    
                end

                local text = "";
                
                if coords:getValue() then
                    text = string.format("xyz: %s, %s, %s ", mc.player:getBlockX(), mc.player:getBlockY(), mc.player:getBlockZ())
                    if nethercoords:getValue() then
                        local netherbp = tostring(mc.world:getRegistryKey():getValue():getPath())
                        if string.match(netherbp, "nether") then
                            text = text .. string.format("(%s, %s) ", math.floor(mc.player:getX() * 8), math.floor(mc.player:getZ() * 8))
                        else 
                            text = text .. string.format("(%s, %s) ", math.floor(mc.player:getX() / 8), math.floor(mc.player:getZ() / 8))
                        end
                    end
                end

                if direction:getValue() then
                    text = text .. mc.player:getHorizontalFacing():asString()
                end

                renderer:textWithShadow(event:getStack(), text, vec2d(2, mc:getWindow():getScaledHeight() - 11), color(255, 255, 255, 255))
            end
        end)

    end)

end
