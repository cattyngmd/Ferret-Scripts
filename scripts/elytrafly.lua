-- ElytraFly
-- author: Lemoliam

function main()
    this:registerCallback("events", function(event)
        if event:getName() == "tick" then
            if (mc.player:isFallFlying()) then
                if mc.player:getPitch() > -30 then

                    mc.player:setVelocity(0, 0, 0)

                    local down = mc.options.keySneak:isPressed() and -0.5 or 0
            
                    if mc.player.forwardSpeed ~= 0 or mc.player.sidewaysSpeed ~= 0 then
                        mc.player:updateVelocity(1.8, vec3d(mc.player.sidewaysSpeed, down, mc.player.forwardSpeed))
                    end 
                end
            end
        end
    end)
end
