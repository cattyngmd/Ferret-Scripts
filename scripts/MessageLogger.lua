function main()

    module = Module.new("WebhookSender", "идите нахуй пожалуйста", "MISC", this)

    local HttpRequest = luajava.bindClass("com.github.kevinsawicki.http.HttpRequest")

    local url = "webhookURL"
    local avatarUrl = ""

    module:body(function(mod)

        module:registerCallback("events", function(event)

            if(event:getName() == "packet_receive") then
                if(event:is("GameMessageS2CPacket")) then
                    local message = event:getPacket():getMessage():getString()
                    send(globals:getUsername(), message)
                end
            end

        end)

    end)

    function send(username, string)
        local request = HttpRequest:post(url)
        request:acceptJson()
        request:contentType("application/json")
        request:header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686) Gecko/20071127 Firefox/2.0.0.11")
        request:send(string.format([[ { "username": "%s", "avatar_url": "%s", "content": "%s" } ]], username, avatarUrl, string))
        request:body()
    end

end
