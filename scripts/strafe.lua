local Mode = luajava.bindClass("net.minecraft.network.packet.c2s.play.ClientCommandC2SPacket$Mode")

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




        -- function transform(speed)
            
        --     local input = mc.player.input

        --     local forward = input.movementForward;
        --     local strafeSpeed = input.movementSideways;
        --     local yaw = mc.player:getYaw();

        --     if not ( mc.player.moveForward ~= 0.0 or mc.player.moveStrafing ~= 0.0 ) then
        --         return {0, 0}
        --     elseif forward ~= 0.0 then
                
        --         if strafeSpeed >= 1 then
                    
        --             if forward > 0 then
        --                 yaw = yaw - 45
        --             else
        --                 yaw = yaw + 45
        --             end
        --             strafeSpeed = 0

        --         elseif strafeSpeed <= -1 then    
                
        --             if forward > 0 then
        --                 yaw = yaw - 45
        --             else
        --                 yaw = yaw + 45
        --             end
        --             strafeSpeed = 0

        --         end

        --         if forward > 0 then
        --             forward = 1.0
        --         elseif forward < 0 then
        --             forward = -1.0
        --         end    
        --     end

        --     local sin = math.sin( math.rad( yaw + 90.0 ) )
        --     local cos = math.cos( math.rad( yaw + 90.0 ) )

        --     return {forward * moveSpeed * cos + strafeSpeed * moveSpeed * sin,
        --     forward * moveSpeed * sin - strafeSpeed * moveSpeed * cos
        --     }

        -- end

                    -- elseif event:getName() == "player_move" then

            --     if mc.player.horizontalSpeed ~= 0 then
                    
            --         if mc.player:isOnGround() then
            --             stage = 2 -- jump
            --         end

            --     end

            --     -- pre
            --     if stage == 1 and mc.player.horizontalSpeed ~= 0 then
                    
            --         stage = 2
            --         moveSpeed = 1.38 * (speed:getValue() / 10)
            --         -- TODO make compatibility with speed potion

            --     elseif stage == 2 then -- jump
                    
            --         stage = 3 -- post
            --         event:setVelocityY(0.3994)
            --         moveSpeed = moveSpeed * 2.149
                    
            --     elseif stage == 3 then -- post

            --         stage = 4 -- cycle
            --         moveSpeed = lastDist - ( 0.66 * ( lastDist - (speed:getValue( )/10) ) );

            --     else

            --         if not mc.world:isSpaceEmpty(mc.player:getBoundingBox():offset(0.0, mc.player:getVelocity().y, 0.0)) or mc.player.verticalCollision and stage > 0 then
            --             stage = 1
            --         end

            --         moveSpeed = lastDist - ( lastDist / 159.0 );

            --     end

            --     moveSpeed = math.min( math.max( moveSpeed, (speed:getValue( )/10) ), 0.551 )

            --     local trans = transform(moveSpeed)

            --     event:setVelocityXZ(trans[1], trans[2])
                

            --     -- if not ( mc.player.moveForward ~= 0.0 or mc.player.moveStrafing ~= 0.0 ) then
            --     --    event:setVelocityXZ(0, 0) 
            --     -- end