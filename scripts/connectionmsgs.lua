-- ConnectionMessages
-- by mrnv

function main( )
    -- module
    local ConnectionMessages = Module.new( "ConnectionMessages",
        "Displays connection messages in chat", "MISC", this );

    local method_getPlayerListEntry = remapper:remapMethod( nil, "getPlayerListEntry", "NAMED" );
    method_getPlayerListEntry = method_getPlayerListEntry.intermediary;

    local Text = luajava.bindClass( "net.minecraft.text.Text" );
    local Formatting = luajava.bindClass( "net.minecraft.util.Formatting" );

    ConnectionMessages:body( function( mod )
        -- settings
        local join = BooleanBuilder( true ):name( "join" ):build( ConnectionMessages );
        local leave = BooleanBuilder( true ):name( "leave" ):build( ConnectionMessages );

        -- for later usage
        local lastjoin = "";
        local lastleave = "";

        -- todo Do Something About method_11113 ???
        -- method_11113 -> onPlayerList
        local mixin = ConnectionMessages:mixinInject(
            "net.minecraft.client.network.ClientPlayNetworkHandler",
            "method_11113",
            "HEAD",
            1
        );

        ConnectionMessages:registerCallback( mixin, function( event )
            if( event.args[ 1 ] ~= nil and mc.player ~= nil and mc.player:getGameProfile( ) ~= nil ) then
                local packet = event.args[ 1 ];
                if( packet:getEntries( ):size( ) == 1 ) then
                    local action = tostring( packet:getAction( ) );
                    if( action == "ADD_PLAYER" ) then
                        local data = packet:getEntries( ):get( 0 );
                        if( not data:getProfile( ):getId( ):equals( mc.player:getGameProfile( ):getId( ) ) ) then
                            local name = data:getProfile( ):getName( );
                            if( lastjoin ~= name ) then
                                if( join:getValue( ) ) then
                                    PrintChat( name .. " joined" );
                                end

                                lastjoin = name;
                            end
                        end
                    elseif( action == "REMOVE_PLAYER" ) then
                        local data = packet:getEntries( ):get( 0 );
                        if( not data:getProfile( ):getId( ):equals( mc.player:getGameProfile( ):getName( ) ) ) then
                            local entry = GetPlayerListEntry( data:getProfile( ):getId( ) );
                            if( entry ~= nil and entry:getProfile( ) ~= nil ) then
                                local name = entry:getProfile( ):getName( );
                                if( lastleave ~= name ) then
                                    if( leave:getValue( ) ) then
                                        PrintChat( name .. " left" );
                                    end
                                    
                                    if( lastleave == lastjoin ) then
                                        lastjoin = "";
                                    end

                                    lastleave = name;
                                end
                            end
                        end
                    end
                end
            end
        end );

        function GetPlayerListEntry( uuid )
            return mc:getNetworkHandler( )[ method_getPlayerListEntry ]( mc:getNetworkHandler( ), uuid );
        end

        function PrintChat( text )
            mc.inGameHud:getChatHud( ):addMessage(
                Text:of( tostring( Formatting:byName( "GRAY" ):toString( ) ) .. text ) );
        end
    end );
end
