function main()

    local module = Module.new("BowAimbot", "", "COMBAT", this)

    module:body(function()
    
        local range = NumberBuilder(20):name("Range"):setBounds(0, 100):build(module)
        local auto = BooleanBuilder(false):name("Auto"):build(module)

        module:onDisable(function()
            mc.options.keyUse:setPressed(false)
        end)

        module:registerCallback("events", function(event)

            if(event:getName() == "render_3d_pre") then
                ents = {}
                if(not mc.player:isAlive() and not itemInHand()) then return end

                local entities = globals:getEntities()

                for i = 0, entities:size() - 1 do
                    local entity = entities:get(i)
                    if(#entity:getEntityName() < 32 and entity:getEntityName() ~= globals:getUsername() and mc.player:distanceTo(entity) < range:getValue()) then
                        ents[#ents + 1] = entity
                    end
                end

                table.sort(ents, function(a, b) return a:getHealth() < b:getHealth() end)

                target = ents[1]

                if(target == nil) then return end

                if(auto:getValue()) then
                    aim(event:getDelta(), target)
                    if(mc.player:getItemUseTime() >= 20) then
                        mc.options.keyUse:setPressed(false)
                    else
                        mc.options.keyUse:setPressed(true)
                    end
                else
                    if(mc.options.keyUse:isPressed() and itemInHand()) then
                        aim(event:getDelta(), target)
                    end
                end

            end
           
        end)

    end)

    function aim(tickDelta, target)

        local velocity = mc.player:getItemUseTime() / 20
        velocity = (velocity * velocity + velocity * 2) / 3
        if(velocity > 1) then velocity = 1 end

        local posX = target:getX() + (target:getX() - target.prevX) * tickDelta
        local posY = target:getY() + (target:getY() - target.prevY) * tickDelta
        local posZ = target:getZ() + (target:getZ() - target.prevZ) * tickDelta

        posY = posY - (1.9 - target:getHeight())

        local relativeX = posX - mc.player:getX()
        local relativeY = posY - mc.player:getY()
        local relativeZ = posZ - mc.player:getZ()

        local hDistance = math.sqrt(relativeX * relativeX + relativeZ * relativeZ)
        local hDistanceSq = hDistance * hDistance
        local g = 0.006
        local velocitySq = velocity * velocity
        local pitch = -math.deg(math.atan((velocitySq - math.sqrt(velocitySq * velocitySq - g * (g * hDistanceSq + 2 * relativeY * velocitySq))) / (g * hDistance)))

        if(tostring(pitch) ~= "nan") then
            rotations:set(rotations:calcRotations(target)[1], pitch)
        end

    end

    function itemInHand() 
        return tostring(mc.player:getMainHandStack():getItem()) == "bow" or tostring(mc.player:getMainHandStack():getItem()) == "crossbow"
    end

end
