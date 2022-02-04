--visualrange
--author: amfero

function main()

	local vrange = Module.new("VisualRange", "xd", "MISC", this)

	local Text = luajava.bindClass("net.minecraft.text.Text")

	vrange:body(function(mod)

		local known = {}

		vrange:registerCallback("events", function(event)

			if(event:getName() == "tick") then	

				if(mc.world == nil) then
					known = {}
				end

				local iterator = mc.world:getEntities():iterator()
				while iterator:hasNext() do
  					local entity = iterator:next()
  					if(string.find(tostring(entity), "class_745")) then
  						local ind = string.find(tostring(entity), "'")
  						local ind1 = string.find(tostring(entity), "'/")
  						local username = string.sub(tostring(entity), ind + 1, ind1 - 1)
  						if(check(username) == false) then
  							mc.inGameHud:getChatHud():addMessage(Text:of("§a+§f " .. username .. " §a> §7VisualRange"))
  						end
  					end
				end

				for i = 1, #known - 1 do
					if(known[i] ~= nil and not string.find(tostring(mc.world:getEntities()), known[i])) then
						mc.inGameHud:getChatHud():addMessage(Text:of("§6-§f " .. known[i] .. " §6> §7VisualRange"))
						table.remove(known, i)
					end
				end

			end

		end)

		function check(username)
			for i = 1, 1000 do
				if(known[i] ~= nil and known[i] == username) then
					return true
				else
					if(i > #known) then
						table.insert(known, username)
						return false
					end
				end
			end
		end

	end)

end
