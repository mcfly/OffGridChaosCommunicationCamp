device = {
	updateRate = 1.0,
	canAccess = function()
	 --return Player.HasDataFile("PlayerPGPKey")
	 return true
	end,
	gui = {
		type = "ncurses",
		header = [[Internet Beer Tap - Technologia Incognita, Amsterdam, Netherlands]],
		backgroundColour = {0.4, 0.1, 0.7176},
		highlightColour = {0, 0.6588, 1.0},
		buttons = {
			about = {
				name = "About the Internet Beer Tap",
				subButtons = {
					{
						name = "https://wiki.techinc.nl/Internet_Beer_Tap",
					},
					{
						name = "Once upon a time, a lovely piece of Purple networking hardware got pushed into the obscene job of having to function in tapping the internet for law-enforcement purposes. After liberating the quarter-million-dollar-networking-switch, we have taken it upon ourselves to offer it a worthy retirement plan that allows it to re-socialize itself. The Internet Beer Tap became a fact.",
					},
					{
						name = "History - The Internet Tap has performed service for a fair number of years at a dutch ISP who, after upgrading to smaller, lighter, faster hardware found themselves with the problem of just how to get this huge piece of hardware out of the rack it was in. Luckily a solution was available that suited all parties involved.After getting rid of a number of unneeded parts involving the routing of bits, we replaced them with the materials required to route beer instead. This involved getting rid of about 80% of it's weight and putting only a fraction back. At current, it's a water-bath-cooler based tap, entirely self-contained within the unit. The only external parts required are the kegs and CO2. There's two taps that provide cooled beverages. The middle one is left to supply IPAv4, which hasnt been in stock for ages. Future upgrades will involve making the middle tap also cooled via the water-based chill-bath.",
					},
					{
						name = "Status : Functional! * Beer-cooler fitted with 2 spirals to cool beer *check*. * Center tap currently not connected. * Most right connection on the bottom plate is for filling the water-level of beer-cooler *check* * Driptray installed (Slot B) LED-animations while system is powered on *check* * A box containing keg-couplers, pressure-reducer and instruction-cards *check*", 
					},
					{
						name = "Future : * Add last spiral cooler for middle tap. * Add small pump for starting cooling-line flow along beer-delivery-lines to faucets * Add floater-controlled valve on input for coolant-water to auto-fill water-bath * Inspect possibility of setting coolant-bath temperature (does Gamko support this ?) * Add ESP32's with ESPHome for controlling lights * Add ESP32's for checking beer-temp, beer-flow, water-level * Add ESP32's for displaying E-Ink's above the taps",
					},
				},
			},
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
