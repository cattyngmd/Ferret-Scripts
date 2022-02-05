--antimagma
--author: amfero

function main()
	
	local antimagma = Module.new("AntiMagma", "xd", "MOVEMENT", this)

	antimagma:body(function(mod)

		local adolf = luajava.bindClass("net.minecraft.network.packet.c2s.play.ClientCommandC2SPacket$Mode")

		local bool = false

		antimagma:registerCallback("events", function(event)

			if(event:getName() == "tick") then
				if(getBlock(mc.player:getX(), mc.player:getY() - 0.5, mc.player:getZ()) == "Block{minecraft:magma_block}") then
					mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.ClientCommandC2SPacket", mc.player, adolf:valueOf("PRESS_SHIFT_KEY")))
					if (mc.player.age % 80 == 0) then
						mc.options.keySneak:setPressed(true)
						mc.options.keySneak:setPressed(false)
					end
					bool = true
				else
					if(bool) then
						mc.player.networkHandler:sendPacket(luajava.newInstance("net.minecraft.network.packet.c2s.play.ClientCommandC2SPacket", mc.player, adolf:valueOf("RELEASE_SHIFT_KEY")))
						bool = false
					end
				end
			end
		end)

	end)

	function getBlock(x, y, z)
		return tostring(globals:getBlock(x, y, z))
	end

end
