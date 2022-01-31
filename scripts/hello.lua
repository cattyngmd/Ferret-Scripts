--hello

this:registerCallback("events", function(event)
    if(event:getName() == "render_2d") then
        local text = "hi, "..globals:getUsername()
        renderer:textWithShadow(event:getStack(), text, vec2d(renderer:windowWidth()/2 - renderer:width(text)/2 , 4), color(255, 255, 255, 255))
    end
end)

function main()

end 