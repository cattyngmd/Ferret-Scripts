--autowalk
--author: amfero

function main()

	local autowalk = Module.new("AutoWalk", "xd", "MOVEMENT", this)

	autowalk:body(function(mod)

		autowalk:registerCallback("tick", function(tick)
    			mc.options.keyForward:setPressed(true)
		end)	

		autowalk:onDisable(function()
			mc.options.keyForward:setPressed(false)
		end)

	end)

end
