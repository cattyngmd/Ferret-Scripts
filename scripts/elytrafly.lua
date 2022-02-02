-- elytrafly
-- author: lemoliam

function main()

    local elytrafly = Module.new("ElytraFly", "Makes elytra easier to use", "MOVEMENT", this)

    elytrafly:body(function(mod)

        local speed = NumberBuilder(1.8):name("Speed"):setBounds(0.5, 5.0):build(elytrafly)
        local multiplier = NumberBuilder(0.5):name("DownMultiplier"):setBounds(0.1, 1.5):build(elytrafly)
        local pitch = NumberBuilder(30):name("BoostPitch"):setBounds(10, 60):build(elytrafly)
        local strict = BooleanBuilder(false):name("StrictPitch"):build(elytrafly) -- no clue if this works

        elytrafly:registerCallback("events", function(event)
            if event:getName() == "tick" then
                if (mc.player:isFallFlying()) then
                    if mc.player:getPitch() > -pitch:getValue() then
        
                        mc.player:setVelocity(0, 0, 0)
                        if strict:getValue() then
                            mc.player:setPitch(-2.0214846) -- lel
                        end
        
                        local down = mc.options.keySneak:isPressed() and -multiplier:getValue() or 0
            
                        if mc.player.forwardSpeed ~= 0 or mc.player.sidewaysSpeed ~= 0 then
                            mc.player:updateVelocity(speed:getValue(), vec3d(mc.player.sidewaysSpeed, down, mc.player.forwardSpeed))
                        end
                    end
                end
            end
        end)
    end)
end
