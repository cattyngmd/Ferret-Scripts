--autofish
--author: amfero

function main()

	local autofish = Module.new("AutoFish", "xd", "MISC", this)
	local Hand = luajava.bindClass("net.minecraft.util.Hand")

	autofish:body(function(mod)

		local shouldThrow = false
		local ticks = 0

		autofish:registerCallback("events", function(event)

			if(event:getName() == "tick") then
				if(shouldThrow) then
					ticks = ticks + 1
					if(ticks == 20) then
						mc.interactionManager:interactItem(mc.player, mc.world, Hand:valueOf("MAIN_HAND"))
						ticks = 0
                				shouldThrow = false
					end
				end
			end

			if(event:getName() == "packet_receive") then
        			if(event:is("PlaySoundS2CPacket") and string.lower(event:getPacket():getSound():getId():toString()) == "minecraft:entity.fishing_bobber.splash") then
        				mc.interactionManager:interactItem(mc.player, mc.world, Hand:valueOf("MAIN_HAND"))
                			shouldThrow = true
        			end
    			end

		end)

	end)

end
