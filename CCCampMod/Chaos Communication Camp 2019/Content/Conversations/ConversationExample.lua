
sendData = true
encrypted = true
singleMessage = false

characters = {
	"character1",
	"character2",
}

begin = function()
	Send( {"character2", "Hi!."} )
	SendResponse( {"Hey" } )
	Send( {"character2", "So you want to script a conversation?"})
	SendResponse( {"Yap, that's why I'm here" } )
	Send( {"character2", "Here's a link to help you http://wiki.offgridthegame.com/index.php?title=Conversations " } )
	SendResponse( { "Thx :D ", nice }, { "lol, I already knew that", rude } )

end

nice = function ()

	Send( {"character2", "np <3"} )
	continue()
end

rude = function ()

	Send( {"character2", ":("} )
	continue()
end

continue = function()«
	End()
end
