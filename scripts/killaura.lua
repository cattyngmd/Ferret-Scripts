function main()

    local module = Module.new("KillAura", "", "COMBAT", this)
    local Hand = luajava.bindClass("net.minecraft.util.Hand")
    local del = 0

    module:body(function()

        local range = NumberBuilder(5.2):name("Range"):setBounds(0, 20):build(module)
        local delay = NumberBuilder(0):name("Delay"):setBounds(0, 20):build(module)
        local cd = BooleanBuilder(false):name("Cooldown"):build(module)
        local rotate = BooleanBuilder(false):name("Rotate"):build(module)
        local crits = BooleanBuilder(false):name("Crits"):build(module)

        module:onEnable(function()
            del = 0
        end)

        module:registerCallback("events", function(event)
           
            if(event:getName() == "tick") then

                del = del + 1
                local entities = globals:getEntities()

                for i = 0, entities:size() - 1 do

                    local entity = entities:get(i)

                    if(#entity:getEntityName() < 32 and entity:getEntityName() ~= globals:getUsername() and mc.player:distanceTo(entity) < range:getValue()) then

                        if(rotate:getValue()) then
                            rotations:set(rotations:calcRotations(entity)[1], rotations:calcRotations(entity)[2]) 
                        end

                        if(del >= delay:getValue()) then

                            local isSprinting = false
                            if (mc.player:isSprinting()) then
                                mc.player:setSprinting(false)
                                isSprinting = true
                            end
                            if(cd:getValue()) then
                                if(mc.player:getAttackCooldownProgress(mc:getTickDelta()) == 1) then
                                    if(crits:getValue()) then
                                        mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.11, mc.player:getZ(), false))
                                        mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.1100013579, mc.player:getZ(), false))
                                        mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.0000013579, mc.player:getZ(), false))
                                        mc.player:addCritParticles(entity)
                                    end
                                    mc.interactionManager:attackEntity(mc.player, entity)
                                    mc.player:swingHand(Hand:valueOf("MAIN_HAND"))
                                end
                            else
                                if(crits:getValue()) then
                                    mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.11, mc.player:getZ(), false))
                                    mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.1100013579, mc.player:getZ(), false))
                                    mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.PlayerMoveC2SPacket$PositionAndOnGround", mc.player:getX(), mc.player:getY() + 0.0000013579, mc.player:getZ(), false))
                                    mc.player:addCritParticles(entity)
                                end
                                mc.interactionManager:attackEntity(mc.player, entity)
                                mc.player:swingHand(Hand:valueOf("MAIN_HAND"))
                            end
                            mc.player:setSprinting(isSprinting)
                            del = 0
    
                        end

                    end

                end

            end

        end)

    end)

end
