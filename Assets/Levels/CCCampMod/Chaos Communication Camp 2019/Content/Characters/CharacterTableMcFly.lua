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
		{data = { 255, 0, 0, 1 }, tags = {"FavouriteColor"}}
	},

	Profile = {

--[[Names]]
		{ data = "Mr", tags = {"Title"} },
		{ data = "Brian", tags = {"FirstName", "name"} },
		{ data = "mc.fly", tags = {"LastName", "name"} },
		{ data = {"mc.fly"}, tags = {"NickName", "name"} },
		{ data = {"ingrate", "disease", "fish", "plum", "lemon", "sillypants"}, tags = {"DerogatoryName"} },
		{ data = {"Deary","Cuteypie","Sugar", "Honey",}, tags = {"HusbandWifePetname", "name"} },
		{ data =  {"mc.fly", "elmar", "EL"}, tags = {"Usernames"} },
		{ data = "mc.fly", "Eris", "Henry", "EL"= {"Screennames"} },
		-- / account names (could be generated from first name 1st char "." + Lastname etc)


--[[Accounts]]
		-- Social Networking Sites:
		{ data = {"@mc.fly", "@milliways.info"}, tags = {"EmailProviders"} },
		-- Websites, Favorite Game Servers, Owned Game Servers
		{ data = {"milliways.info"}, tags = {"WebsiteName"} },


-- [[Family and relationshsips]]
		{ data = {"married", "tied down"}, tags = {"MaritalStatus"} },



		-- Relatives:
		-- TODO Figues out if this categorisation is useful?
		--Do we also need "RelativeRelationship"?
				-- Parent Names:
		{ data = {"Elmar"}, tags = {"RelativeName", "Father"} },
		{ data = {"Brigitte"}, tags = {"RelativeName", "Mother"} },
				-- Siblings:
		{ data = {"Tobias"}, tags = {"RelativeName", "Brother"} },
		{ data = "Michael", tags = {"friend", "BestFriend"} },
		-- Pet-type
		{	data = {"Dog"}, tags = {"PetAnimalType"} },
		-- Pet names
		{	data = {"Dusty"}, tags = {"PetAnimalName"} },
--[[ Sensitive info]]
		{ data = {"114, Forrest Street, 11206"}, tags = {"HomeAddress"} },
		-- Addresses, current and past
		-- D.O.B
		{ data = {23. May 1984} },
		-- Birthplace
		{ data = {"Treibestraße 9, 3200 Hildesheim"}, tags = {"Birthplace"} },
		-- SSN (Social Security Numbers):
		-- (Credit Card details)
		{ data = {"HildesheimerBankHaus"}, tags = {"BankName"} },
		-- Passwords
		-- Phone Cell, landline#:
		{ data == {"+49506485070"}, tags = {"PhoneNumber"} }
		-- Screwgle Advertising Id 23-4v678462-b387a36-3756nd-423
		{ data == {"23-4v678462-b387a36-3756nd-423"}, tags = {"ScrewgleAdvertisingId"} }

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
		{ data = "godverdamme", tags = {"FavouriteSwear"} },

		{ data = {
			"Uuh Yeah",
			"Hmmmm",
			"Hallo",
			"sheet",
			"oh god",
			"Heck",
			"Grrr",
			"Uh-oh",
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
			"imho",
			"right?",
			"ok",
			"aye",
			"oder?",
			},
			tags = {"post-fixes"}

		},
		{ data = {
			"#ROFTL",
			"#mad",
			"LMAO",
			"LOL",
			"#milliways",
			"#Lebe",
			"#WTF",
			},
			tags = {"hashtag"}
		},

--sayings
		{ data = {
			"Whisky is life",
			"We are Legion. We do not forgive. We do not forget.",
			"Puff puff pass",
			"want a beer? Get to the tap and get one",
			"always sanatize your input",
			"always escape your output",
			"Die Nacht ist nicht allein zum Schlafen da",
			"look who do you trust",
			"where is your towel?",
			"willste nen Bier?",
			"Perimeter security is dead",
			"Run your own fucking infrastructure",
			},
			tags = {"sayings"}

		},

--quotes
		{ data = {
			"Whisky is life",
			"where's your towel?",
			"We are Legion. We do not forgive. We do not forget.",
			"the usenes is full. Go away.",
			"which BBS were you on?",
			"Perimeter security is dead",
			"Run your own fucking infrastructure",
			},
			tags = {"quotes"}

		},


--[[Consumeables]]
-- Singular

		{ data = {
			"Burger",
			"slice of sourdough bread",
			"Schweinebraten",
			"Schnitzel"
			},
			tags = {"FavouriteFood", "food", "singular"} },

-- Plural
		{ data = {"nutz"
			"Cherries"
			},
			tags = {"FavouriteSnack", "food", "plural"} },

-- Drink
		{ data = {
			"Club Mate",
			"Bier",
			"Whisky",
			},
			tags = {"FavouriteDrink", "drink"} },

--[[ Verbs and Actions - past tense ]]
		{ data = {
			"worked",
			"wrote a repot",
			"wrote a exploit",
			"had lunch",
			"went for a walk",
			"got up",
			"travelled to Austria",
			"broke into your box",
			"repainted the hackerspace",
			"spoke to my doctor",
			"partied hard",
			"released a weird game",
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
