device = {
	-- Stock --
	canAccess = function()
	 return true
	end,
	gui = {
		type = "ncurses",
		header = [[~ SHA Orga workstation v2.1 ~ ]],
		backgroundColour = {0.29, 0.69, 0.77},
		highlightColour = {0.0, 0.0, 1.0},
		buttons = {
			{
				name = "This is a button",
				onClick = function()
					print("Button clicked!")
				end,
				subButtons = {
					{
						name = "Sub Button 1",
						onClick = function()
							print("Sub Button 1 clicked!")
						end,
					},
					{
						name = "Sub Button 2",
						onClick = function()
							print("Sub Button 2 clicked!")
						end,
					},
				},
			},
		},
	}
}
