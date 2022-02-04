function main()
    
    local entityspeed = Module.new("EntitySpeed", "Speeeeeeeed", "MOVEMENT", this)

    entityspeed:body(function(mod)
        
        local speed = NumberBuilder(1.2):name("Speed"):setBounds(0.1, 5):build(entityspeed)
        local autowalk = BooleanBuilder(false):name("Auto Walk"):build(entityspeed)
        local copyangles = BooleanBuilder(true):name("Copy Angles"):build(entityspeed)

        entityspeed:registerCallback("events", function(event)
            
            if event:getName() == "tick" then
                
                local e = mc.player:getVehicle()
                local forward = mc.player.forwardSpeed
                local strafe = mc.player.sidewaysSpeed
                local yaw = mc.player:getYaw()

                if e ~= nil then

                    if copyangles:getValue() then
                        e:setYaw(mc.player:getYaw())
                    end
                    
                    if autowalk:getValue() then
                        forward = 1
                    end

                    if forward ~= 0 then
                        
                        if strafe > 0 then
                            yaw = yaw + (forward > 0 and -45 or 45)
                        elseif strafe < 0 then    
                            yaw = yaw + (forward > 0 and 45 or -45)
                        end

                        if forward > 0 then
                            forward = 1
                        elseif forward < 0 then    
                            forward = -1
                        end

                        strafe = 0

                    end

                    e:setVelocity(forward * speed:getValue() * math.cos(math.rad(yaw + 90.0)) + strafe * speed:getValue() * math.sin(math.rad(yaw + 90.0)) ,e:getVelocity().y, forward * speed:getValue() * math.sin(math.rad(yaw + 90.0)) - strafe * speed:getValue() * math.cos(math.rad(yaw + 90.0)))

                end

            end

        end)
        
    end)

end