-- Step (Vanilla)
-- author: Cattyn

function main()
    
    local step = Module.new("Step", "ste...p", "MOVEMENT", this)

    step:body(function(mod)
        
        local height = NumberBuilder(2):name("Step Height"):setBounds(0.6, 2.5):build(step)

        step:registerCallback("events", function(event)
            
            if event:getName() == "tick" then
                mc.player.stepHeight = height:getValue()
            end

        end)

    end)

end
