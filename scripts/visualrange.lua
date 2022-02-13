--visualrange
--author: amfero

function main()

	local vrange = Module.new("VisualRange", "xd", "MISC", this)

	local Text = luajava.bindClass("net.minecraft.text.Text")

	vrange:body(function(mod)

		local known = {}

		vrange:registerCallback("events", function(event)

			if(event:getName() == "tick") then	

				local entities = globals:getEntities()

				for i = 0, entities:size() - 1 do

					local username = entities:get(i):getEntityName()

					if(#username < 32 and username ~= globals:getUsername()) then
						
						if(not check(username)) then mc.inGameHud:getChatHud():addMessage(Text:of("§8[Ferret]: §6" .. username .. " entered visual range")) end

					end

				end

				for i = 1, #known do

					if(known[i] ~= nil and not string.find(tostring(entities), known[i])) then

						mc.inGameHud:getChatHud():addMessage(Text:of("§8[Ferret]: §6" .. known[i] .. " left visual range"))
						table.remove(known, i)

					end

				end

			end

		end)

		function check(username)

			for i = 0, 1000 do

				if(known[i] ~= nil and known[i] == username) then return true else
					if(i > #known) then

						table.insert(known, username)
						return false
					
					end
				
				end
			
			end
		
		end

	end)

end
