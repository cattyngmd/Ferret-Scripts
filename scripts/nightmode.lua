--nightmode
--author: amfero

function main()

    local nightmode = Module.new("NightMode", "xd", "VISUAL", this)

    nightmode:body(function(mod)

        local time = NumberBuilder(15):name("Time"):setBounds(0, 23):build(nightmode)

        nightmode:registerCallback("events", function(event)
        
            if(event:getName() == "tick") then
                mc.world:setTimeOfDay(time:getValue() * 1000)
            end

            if(event:getName() == "packet_receive") then
                if(event:is("WorldTimeUpdateS2CPacket")) then
                    event:cancel()
                end
            end
        
        end)

    end)

end