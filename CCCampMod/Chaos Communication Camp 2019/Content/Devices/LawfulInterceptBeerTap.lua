device = {
	updateRate = 1.0,
	canAccess = function()
	 --return Player.HasDataFile("PlayerPGPKey")
	 return true
	end,
	gui = {
		type = "ncurses",
		header = [[Amsterdam Hackerspace Lawful Intercept Beer Tap]],
		backgroundColour = {0.4, 0.1, 0.7176},
		highlightColour = {0, 0.6588, 1.0},
		buttons = {
			users = {
				name = "Currently Targeted Users",
				subButtons = {
					{
						name = "<color=#ffffffff>mc.fly</color>",
					},
					{
						name = "-----------------------------",
					},
					{
						name = [[www.milliways.info]],
					},
					{
						name = [[germanbeerisbest.com]],
					},
					{
						name = [[<color=orange>thepiratebay.org/search/Off%20Grid/0/99/0</color>]],
					},
					{
						name = [[<color=red>torproject.org</color>]],
					},
					{
						name = [[.... 9,598 more entries]],
					},
					{
						name = "-----------------------------",
					},
					{
						name = "<color=#ffffffff>laurilove</color>",
					},
					{
						name = "-----------------------------",
					},
					{
						name = "<color=orange>army-surplus.com/mining-gear</color>",
					},
					{
						name = "popular-finnish-site.fi",
					},
					{
						name = "facebook.com",
					},
					{
						name = "doj.gov",
					},
					{
						name = [[.... 16,001 more entries]],
					},
					{
						name = "-----------------------------",
					},
					{
						name = "<color=#ffffffff>Barrett Brown</color>",
					},
					{
						name = "-----------------------------",
					},
					{
						name = [[reddit.com/r/linux_gaming]],
					},
					{
						name = [[<color=red>https://barrettbrown.medium.com/how-michael-hastings-was-assassinated-by-the-press-61728ca321a1</color>]],
					},
					{
						name = [[<color=orange>www.giantbomb.com</color>]],
					},
					{
						name = [[youtube.com/watch?v=dQw4w9WgXcQ]],
					},
					{
						name = [[.... 13,370 more entries]],
					},
					{
						name = "-----------------------------",
					},
					{
						name = "<color=#ffffffff>Biella Coleman</color>",
					},
					{
						name = "-----------------------------",
					},
					{
						name = [[twitter.com]],
					},
					{
						name = [[<color=orange>reddit.com/r/anonymous</color>]],
					},
					{
						name = [[<color=red>https://gabriellacoleman.org/</color>]],
					},
					{
						name = [[duckduckgo.com/?q=phineas+fisher]],
					},
					{
						name = [[.... 7,279 more entries]],
					},
					{
						name = "-----------------------------",
					},
				},
			},
			{
				name = "System Settings",
				subButtons = {
					{
						name = "<color=white>IP(v4)Ale</color>",
					},
					{
						name = "<color=white>	Version</color>: v3.0.6",
					},
					{
						name = "<color=white>	Last Update</color>: 2y 4m 1d",
					},
					{
						name = "<color=white>	Storage Total</color>: 46 PB",
					},
					{
						name = "<color=white>	Storage Left</color>: 789 TB",
					},
				},
			},
		 },
	},
}
