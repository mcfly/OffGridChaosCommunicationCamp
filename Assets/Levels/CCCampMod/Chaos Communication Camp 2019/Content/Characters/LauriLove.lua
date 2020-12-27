--[[
	Character data sheet

]]

Character = {
	Stats = {
		{ data = 0.4, tags = {"Motivation"}},
		{ data = 0.3, tags = {"Sociability"}},
		{ data = 0.5, tags = {"Gluttony"}},
		-- Mood?
		-- Tiredness?
		-- InNeedOfToilet?
	},
	Colors = {
		--{data = { --[[1, 0.8004598, 0.1490196, 1]] Color.Purple }, tags = {"FavouriteColor"}}
	},

	Profile = {

--[[Names]]
		{ data = "Mr", tags = {"Title"} },
		{ data = "Lauri", tags = {"FirstName", "name"} },
		{ data = "X", tags = {"MiddleName", "name"} },
		{ data = "Love", tags = {"LastName", "name"} },
		{ data = {"Lau", "LA", "lal", "lars",}, tags = {"NickName", "name"} },
		{ data = {"ingrate", "reprobate", "thumbslate", "bad-date", "triumvirate",}, tags = {"DerogatoryName"} },
		{ data = {"...","...","...", "...",}, tags = {"HusbandWifePetname", "name"} },
		{ data =  {"l.love", "mrlove",}, tags = {"Usernames"} },
		{ data = {"nsh", "xeb",}, tags = {"Screennames"} },
		-- / account names (could be generated from first name 1st char "." + Lastname etc)


--[[Accounts]]
		-- Social Networking Sites:
		{ data = {"@moonbase.su", "@freeserve.net"}, tags = {"EmailProviders"} },
		-- Websites, Favorite Game Servers, Owned Game Servers
		{ data = {"wikipedia.org", "screwgle scholar", "code-overlow", "archive.org", "searchenginefortheinternetofsh*t.com", "boxgrepper.com"}, tags = {"WebsiteName"} },


-- [[Family and relationshsips]]
		{ data = {"single", "unmarried", "non-subscriber to the state santioned partial patronage of particular religions and the arbiter of human relationships"}, tags = {"MaritalStatus"} },



		-- Relatives:
		-- TODO Figues out if this categorisation is useful?
		--Do we also need "RelativeRelationship"?
				-- Parent Names:
		{ data = {"The Reverend Alexander"}, tags = {"RelativeName", "Father"} },
-- Lauris Mum can only be reference if she is the good part of the game
		{ data = {"Mum"}, tags = {"RelativeName", "Mother"} },
		{ data = {""}, tags = {""} },
				-- Siblings:
		--{ data = {"Kat"}, tags = {"RelativeName", "Sister"} },
		--{ data = "Michael", tags = {"friend", "BestFriend"} },
		-- Pet-type
		--{	data = {"Cat"}, tags = {"PetAnimalType"} },
		-- Pet names
		--{	data = {"Benny"}, tags = {"PetAnimalName"} },
--[[ Sensitive info]]
		{ data = {"1600, Pensylvania Avenue, DC20500"}, tags = {"HomeAddress"} },
		-- Addresses, current and past
		-- D.O.B
		-- Birthplace
		{ data = {"Burnley General Hospital"}, tags = {"Birthplace"} },
		-- SSN (Social Security Numbers):
		-- (Credit Card details)
		{ data = {"Bank of Orion"}, tags = {"BankName"} },
		-- Passwords
		-- Phone Cell, landline#:
		-- Screwgle Advertising Id 81-4v678462-b387a36-3756nd-274
		{ data = {"56-5f85647392-y674v36-3756nd-885"}, tags = {"ScrewgleAdvertisingId"} },

--[[ Background ]]

--[[

		* Dialect [Estuary, Northern, RP, Country, Americanized]
		* Social Status
		* Education
		* Size of vocabulary
		* Flamboyance of vocabulary
		* Verbosity
		* English as first languge [Y/N]
		* Mothertongue

]]

--[[ Psycology ]]

-- Extrovert etc

		{ data = {
			"antisocial",
			"overwhelmed",
			"exuberant",
			"manic",
			"stoned",
			"deferential",
			"helpful",
			"wrathfully indignant"
			},
			tags = {"mood"}
		},


--[[Exclamations]]
		{ data = {"gee willikers", "posho"}, tags = {"FavouriteSwear"} },

		{ data = {
			"lmao",
			"mmmmmm mmmmm mmmm",
			"fexsake",
			"general exasperation",
			},
			tags = {"exclamation"}
		},
		{ data = {
			"huummmm",
			"wadadadada",
			"well",
			"craic",
			"imho",
			"gubbins",
			},
			tags = {"pre-fixes"}
		},

		{ data = {
			"aye",
			"rumhad",
			"surewhynot",
			"＼o／",
			"craic",
			"mebbes",
			"dealwaeit",
			":)",
			},
			tags = {"post-fixes"}
		},

		{ data = {
			"#NotAFanOfTheHashtags",
			},
			tags = {"hashtag"}
		},

--sayings
{ data = {
	"worse things happen at sea",
	"wifi over canon",
	":)",
	},
	tags = {"sayings"}
},

--quotes
{ data = {
	"liberate te ex inferes",
	"Mens sana in corpore sano",
	"It is by deduction that we prove, but it is by intuition that we discover",
	},
	tags = {"quotes"}
},


--[[Consumeables]]
-- Singular

		{ data = {
			"fry up",
			"roast dinner",
			"dark chocolate",
			},
			tags = {"FavouriteFood", "food", "singular"} },

-- Plural
		{ data = {"cashew nuts","prawn cocktail crisps",}, tags = {"FavouriteSnack", "food", "plural"} },

-- Drink
		{ data = {
			"club mate",
			"rum",
			"the black stuff",
			"nitrogenated stout",
			"tarmac",
			"infused gin",
			"non pretentious wine",
			"fine whiskies when other people buy them",
			},
			tags = {"FavouriteDrink", "drink"} },

--[[ Verbs and Actions - past tense ]]
		{ data = {
			"left the country",
			"went to CCC",
			"went for a run",
			"went climbing",
			"hacked the planet",
			"used a hilarious vulnerability in telnet",
			"reserved the right to hack the planet",
			"charged my phone",
			"visited family",
			"got a haircut",
			"went to a television studio",
			},
			tags = {"PastEvent"} },

--[[ Verbs and Actions - future tense]]
		{ data = {
			"go on holiday",
			"go to CCC",
			"go for a run",
			"go climbing",
			"hack the planet",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			},
			tags = {"FutureEvent"}
		},
	}
}
