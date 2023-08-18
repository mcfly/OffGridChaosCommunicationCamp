--[[
	Character data sheet

]]

Character = {
	Stats = {
		{ data = 0.4, tags = {"Motivation"}},
		{ data = 0.3, tags = {"Sociability"}},
		{ data = 0.9, tags = {"Gluttony"}},
		-- Mood?
		-- Tiredness?
		-- InNeedOfToilet?
	},
	Colors = {
		{data = { 1, 0.8004598, 0.1490196, 1 }, tags = {"FavouriteColor"}}
	},

	Profile = {

--[[Names]]
		{ data = "Ms", tags = {"Title"} },
		{ data = "Dianne", tags = {"FirstName", "name"} },
		{ data = "Fab", tags = {"MiddleName", "name"} },
		{ data = "Bot", tags = {"LastName", "name"} },
		{ data = {"Chicken","KFC","Hoover"}, tags = {"NickName", "name"} },
		{ data = {"ingrate", "disease", "fish", "plum", "lemon", "sillypants"}, tags = {"DerogatoryName"} },
		{ data = {"Deary","Cuteypie","Sugar", "Honey",}, tags = {"HusbandWifePetname", "name"} },
		{ data =  {"h.lecoq", "cocko", "henryhoover"}, tags = {"Usernames"} },
		{ data = "LeHen", tags = {"Screennames"} },
		-- / account names (could be generated from first name 1st char "." + Lastname etc)


--[[Accounts]]
		-- Social Networking Sites:
		{ data = {"@gmc.net", "@coolmail.com"}, tags = {"EmailProviders"} },
		-- Websites, Favorite Game Servers, Owned Game Servers
		{ data = {"food4you.com"}, tags = {"WebsiteName"} },


-- [[Family and relationshsips]]
		{ data = {"married", "tied down"}, tags = {"MaritalStatus"} },



		-- Relatives:
		-- TODO Figues out if this categorisation is useful?
		--Do we also need "RelativeRelationship"?
				-- Parent Names:
		{ data = {"Samuel"}, tags = {"RelativeName", "Father"} },
		{ data = {"Stacey"}, tags = {"RelativeName", "Mother"} },
				-- Siblings:
		{ data = {"Kat"}, tags = {"RelativeName", "Sister"} },
		{ data = "Michael", tags = {"friend", "BestFriend"} },
		-- Pet-type
		{	data = {"Cat"}, tags = {"PetAnimalType"} },
		-- Pet names
		{	data = {"Benny"}, tags = {"PetAnimalName"} },
--[[ Sensitive info]]
		{ data = {"37,new Springs Ave,8A2E"}, tags = {"HomeAddress"} },
		-- Addresses, current and past
		-- D.O.B
		-- Birthplace
		-- SSN (Social Security Numbers):
		-- (Credit Card details)
		{ data = {"SmartBanking"}, tags = {"BankName"} },
		-- Passwords
		-- Phone Cell, landline#:
		-- Screwgle Advertising Id 81-4v678462-b387a36-3756nd-274

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
			"happy",
			"excited",
			"sad",
			"frustrated",
			"upset",
			"down",
			"good",
			},
			tags = {"mood"}
		},


--[[Exclamations]]
		{ data = "bejesus", tags = {"FavouriteSwear"} },

		{ data = {
			"Golly",
			"Oh man",
			"Cripes",
			"Gosh",
			"Geez",
			"Geewhiz",
			"Grrr",
			"gahhh!",
			"Ahhh",
			"WTF",
			},
			tags = {"exclamation"}
		},
		{ data = {
			"hmmm",
			"well...",
			"ok",
			},
			tags = {"pre-fixes"}

		},
		{ data = {
			"#ROFL",
			"#Grrr",
			"LMAO",
			"LOL",
			"#Tots",
			"#BigGuns",
			"#Life",
			"#WTF",
			},
			tags = {"hashtag"}
		},

--sayings

--quotes


--[[Consumeables]]
-- Singular

		{ data = {
			"chocolate bar",
			"apple",
			"slice of bread",
			"haggis"
			},
			tags = {"FavouriteFood", "food", "singular"} },

-- Plural
		{ data = "pistachios", tags = {"FavouriteSnack", "food", "plural"} },

-- Drink
		{ data = {
			"Irn Bru",
			"lager",
			"blood",
			},
			tags = {"FavouriteDrink", "drink"} },

--[[ Verbs and Actions - past tense ]]
		{ data = {
			"ate",
			"had lunch",
			"went for a walk",
			"got up",
			"travelled to Serbia",
			"broke into your house",
			"repainted the house",
			"spoke to my doctor",
			"partied hard",
			"released a mobile game",
			"checked the scores",
			"procrastinated",
			},
			tags = {"PastEvent"} },

--[[ Verbs and Actions - future tense]]
		{ data = {
			"eat",
			"have lunch",
			"take a nap",
			"go skydiving",
			"join the army",
			"watch the stars",
			"speak to my wife",
			"sleep",
			"procrastinate",
			"speak to your wife",
			"speak to my doctor",
			"get my doctor's degree",
			"run in the rain",
			},
			tags = {"FutureEvent"}
		},
	}
}
