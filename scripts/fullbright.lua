function main()
    
    local fullBright = Module.new("FullBright", "omg so bright", "VISUAL", this)

    fullBright:body(function (mod)
       
        fullBright:registerCallback("tick", function ()
            mc.options.gamma = 1337
        end)

    end)

end