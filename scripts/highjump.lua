function main() 

end

this:registerCallback("events", function(event)
    if (event:getName() == "player_move") then
        event:setVelocityY(event:getVelocity().y * 2)
    end
end)