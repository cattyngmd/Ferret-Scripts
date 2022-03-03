--arraylist
--author: xhz1337

local DateFormatter = luajava.bindClass("java.time.format.DateTimeFormatter")
local LocalDateTime = luajava.bindClass("java.time.LocalDateTime")

function main()
    local arraylist = Module.new("arraylist", "j", "VISUAL", this)
    arraylistbody(function(mod)
        if(event:getName() == "render_2d") then
            local text = "Ferret [xhzcord] | "..LocalDateTime:now():format(DateFormatter:ofPattern("HH:mm:ss"))
            renderer:rectFilled(event:getStack(),vec2d(2, 1), vec2d(renderer:width(text)+4, 11), color(255, 255, 255, 150))
            renderer:textWithShadow(event:getStack(), text, vec2d(3, 1), color(255, 255, 255, 255)) 

            local fps = "fps: "..globals:getFps()
            renderer:rectFilled(event:getStack(),vec2d(renderer:windowWidth()-renderer:width(fps)-3, 1), vec2d(renderer:windowWidth()-1, 13), color(255, 255, 255, 150))
            renderer:textWithShadow(event:getStack(), fps, vec2d(renderer:windowWidth() - renderer:width(fps)-2, 3), color(255, 255, 255, 255))

            
            
            for j = 0, client:getScripts():size()-1 do
                local script = client:getScripts():get(j)
                renderer:rectFilled(event:getStack(),vec2d(2,  22 + 11 * j), vec2d(renderer:width(script:getName())+4, 11 + 11 * j), color(255, 255, 255, 150))
                renderer:textWithShadow(event:getStack(), script:getName(), vec2d(3, 11 + 11 * j), color(255, 255, 255, 255))
            end
        end
    end)
end 
