function main()
    
    local strafe = Module.new("Strafe", "Makes u faster", "MOVEMENT", this)

    strafe:body(function(mod)
        
        local speed = NumberBuilder(0.27):name("Speed"):setBounds(0.1, 2.0):build(strafe)

        strafe:registerCallback("events", function (event)
            
            if event:getName() == "tick" then

                if mc.player.forwardSpeed ~= 0 or mc.player.sidewaysSpeed ~= 0 then
                    
                    if not mc.player:isSprinting() then
                        mc.player:setSprinting(true)
                    end

                    mc.player:setVelocity(vec3d(0, mc.player:getVelocity().y, 0))
                    mc.player:updateVelocity(speed:getValue(),
						vec3d(mc.player.sidewaysSpeed, 0, mc.player.forwardSpeed))
                    
                    local vel = math.abs(mc.player:getVelocity():getX()) + math.abs(mc.player:getVelocity():getZ());

                    if mc.player:isOnGround() and vel > 0.12 then
                        mc.player:jump();
                    end
                
                else
                    mc.player:setVelocity(vec3d(0, mc.player:getVelocity().y, 0))
                end

            end
        end)

    end)

end
