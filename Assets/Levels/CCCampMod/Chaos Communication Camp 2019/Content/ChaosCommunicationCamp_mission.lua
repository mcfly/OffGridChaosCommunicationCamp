mission = {

-- Mission info
	startTime = {2009, 04, 27, 21, 13, 00},

-- State - named variables of type number, string or bool will be saved & loaded
	state = {
	--	hasEnteredBuilding = true,
	--	sideObjectivesComplete = 17,
	--	mostAnnoyedGuard = "Brian",
	},

-- Character definitions:
	characters = {
		player = {
			displayName = "Joe Harman",
			internalName = "player",
			characterType = "player",
			prefab = "Player_Joe",
			spawnpoint = "PlayerSpawn",
		},
		mcfly = {
			displayName = "mc.fly",
			internalName = "mcfly",
			agent = "LauriAgent.lua",
			characterType = "npc",
			profile = "CharacterTableMcFly.lua",
			prefab = "Masculine_Med_TShirt_NPC",
			activity = {
				points = {
					"LauriPatrol01",
					"LauriPatrol02",
				},
				cyclic = false,
			},
			spawnpoint = "mcflySpawn",
		},
		laurilove = {
			displayName = "nsh",
			internalName = "laurilove",
			agent = "LauriAgent.lua",
			characterType = "npc",
			profile = "LauriLove.lua",
			prefab = "Masculine_Med_OpenShirt_NPC",
			activity = {
				points = {
					"LauriPatrol01",
					"LauriPatrol02",
				},
				cyclic = false,
			},
			spawnpoint = "LauriSpawn",
		},
		--[[ FRIENDLY CHARACTERS ]]
		JakeDavis = {
			displayName = "Jake Davis",
			internalName = "JakeDavis",
			characterType = "npc",
			prefab = "Masculine_Med_BomberJacket_NPC",
			profile = "LauriLove.lua",
			agent = "LauriAgent.lua",
			activity = {
				points = {
					"LauriPatrol01",
					"LauriPatrol02",
				},
				cyclic = false,
			},
			spawnpoint = "JakeSpawn",
		},
		BiellaColeman = {
			displayName = "Biella Coleman",
			internalName = "BiellaColeman",
			characterType = "npc",
			prefab = "Feminine_Med_CardiganNecklace_NPC",
			-- colorTexture = "Cameos/March_Col.png",
			-- metalSmoothTexture = "Vest_Met_Security-Apostle.png",
			profile = "LauriLove.lua",
			agent = "LauriAgent.lua",
			spawnpoint = "BiellaSpawn",
			activity = {
				points = {
					"LauriPatrol01",
					"LauriPatrol02",
				},
				cyclic = false,
			},
		},
		BarrettBrown = {
			displayName = "Barrett Brown",
			characterType = "npc",
			prefab = "Masculine_Med_CasualBlazer_NPC",
			-- colorTexture = "Cameos/March_Col.png",
			-- metalSmoothTexture = "Vest_Met_Security-Apostle.png",
			profile = "LauriLove.lua",
			headProps =
			{
			-- "M_Med_Glasses-Square-Frame_01",
			},
			agent = "LauriAgent.lua",
			spawnpoint = "BarrettSpawn",
			activity = {
				points = {
					"TechnoTrolley",
					"Computer",
					"Snacks",
				},
				cyclic = false,
			},
		},
		-- Shad = {
		-- 	displayName = "Shad",
		-- 	characterType = "npc",
		-- 	prefab = "Masculine_Med_CasualJumper_NPC",
		-- 	-- colorTexture = "Cameos/March_Col.png",
		-- 	-- metalSmoothTexture = "Vest_Met_Security-Apostle.png",
		-- 	profile = "Cameos/Shad.lua",
		-- 	headProps = {
		-- 	--	"﻿M_Med_Hair-Short-Fringe_01", --TODO work out why missing
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_04",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 			},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- DarrenMartyn = {
		-- 	displayName = "Darren Martyn",
		-- 	characterType = "npc",
		-- 	prefab = "Masculine_Med_CoatScarf_NPC",
		-- 	-- colorTexture = "Cameos/March_Col.png",
		-- 	-- metalSmoothTexture = "Vest_Met_Security-Apostle.png",
		-- 	profile = "Cameos/DarrenMartyn.lua",
		-- 	headProps = {
		-- 		--"﻿",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_05",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 			},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- MarchOneill = {
		-- 	displayName = "March O'neill",
		-- 	characterType = "npc",
		-- 	prefab = "Masculine_Med_LeatherJacket_NPC",
		-- 	-- colorTexture = "Cameos/March_Col.png",
		-- 	-- metalSmoothTexture = "Vest_Met_Security-Apostle.png",
		-- 	profile = "Cameos/MarchOneill.lua",
		-- 	headProps =
		-- 	{
		-- 		-- "M_Med_Glasses-Square-Frame_01",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_08",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 		},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- EmmanuelGoldstein = {
		-- 	displayName = "Emmanuel Goldstein",
		-- 	characterType = "npc",
		-- 	--prefab = "Masculine_Med_LongJacket_NPC",
		-- 	prefab = "Masculine_Med_LongJacket-2600-Gasmask_NPC",
		-- 	-- colorTexture = "Cameos/LongJacket_Col_2600.png",
		-- 	-- metalSmoothTexture = "LongJacket_Met_2600.png",
		-- 	profile = "Cameos/EmmanuelGoldstein.lua",
		-- 	headProps =
		-- 	{
		-- 	-- "M_Med_FawkesHat",
		-- 	-- "M_Med_Anonmask",
		-- 	-- "LongHair",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_09",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 		},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- KyleDrosdick = {
		-- 	displayName = "Kyle Drosdick",
		-- 	characterType = "npc",
		-- 	--prefab = "Masculine_Med_LongJacket_NPC",
		-- 	prefab = "Masculine_Med_LongJacket-2600-Hat_NPC",
		-- 	-- colorTexture = "Cameos/LongJacket_Col_2600.png",
		-- 	-- metalSmoothTexture = "LongJacket_Met_2600.png",
		-- 	profile = "Cameos/KyleDrosdick.lua",
		-- 	headProps =
		-- 	{
		-- 		--"M_Med_Gasmask",
		-- 		-- "LongHair",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_10",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 		},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- MustafaAlBassam = {
		-- 	displayName = "Mustafa Al Bassam",
		-- 	characterType = "npc",
		-- 	--prefab = "Masculine_Med_SmartJumper_NPC",
		-- 	prefab = "Masculine_Med_SmartJumper-Mustafa_NPC", --TODO remove
		-- 	-- colorTexture = ".png",
		-- 	-- metalSmoothTexture = ".png",
		-- 	profile = "Cameos/MustafaAlBassam.lua",
		-- 	headProps =
		-- 	{
		-- 		--"M_Med_Hair-Short-Buzz_01",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_12",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 		},
		-- 		cyclic = false,
		-- 		-- create random option aswell as cyclic and ping pong?
		-- 	},
		-- },
		-- NaomiColvin = {
		-- 	displayName = "Naomi Colvin",
		-- 	characterType = "npc",
		-- 	--prefab = "Feminine_Med_Shirt_NPC",
		-- 	prefab = "Feminine_Med_Shirt-Naomi_NPC",
		-- 	-- colorTexture = ".png",
		-- 	-- metalSmoothTexture = ".png",
		-- 	profile = "Cameos/NaomiColvin.lua",
		-- 	headProps =
		-- 	{
		-- 	-- "M_Med_Glasses-Square-Frame_01",
		-- 	},
		-- 	agent = "CourtHouseNPCAgent.lua",
		-- 	spawnpoint = "TestSpawn_13",
		-- 	activity = {
		-- 		points = {
		-- 			"TechnoTrolley",
		-- 			"Computer",
		-- 			"Snacks",
		-- 		},
		-- 		cyclic = false,
		-- 	},
		-- },
		-- [[ VIRTUAL FRIENDLY CHARACTERS ]]--
		-- pathfinder = {
		-- 	displayName = "pathfinder",
		-- 	characterType = "virtual",
		-- 	profile = "Cameos/pathfinder.lua", --TODO Create character profile
		-- },
		-- Spoonzy = {
		-- 	displayName = "Spoonzy",
		-- 	characterType = "virtual",
		-- 	profile = "Cameos/Spoonzy.lua", --TODO Create character profile
		-- },
	},

-- Inventory items:
	items = {
		-- usbkey = {
		-- 	internalName = "USBDongle",
		-- 	displayName = "USB dongle",
		-- 	description = "Modified USB Bluetooth dongle given to you by the hackers",
		-- 	--[[This isn't really used, The UI uses internalName as class instead. Should change it to use image file name from this field.]]--
		-- 	uiSpriteName = "usbdongle.png",
		-- },
	},

--[[ Data files:
Available data types: generic, text, SMS, encrypted, audio, video, location, key, UUID
Table key is used as the internalName value on Unity side.
]]--
	data = {
		PlayerPGPKey = {
			internalName = "PlayerPGPKey",
			name = "Personal PGP encryption key",
			immutable = true,
			dataType = 7,
			creatorName = "Player",
			dataString = "PGP Fingerprint: 1d7d ef54 7a63 5756 63a7 cf14 fbd8 775c c39d 4e51",
			description = "AES 256-bit",
			dataColor = {0.0, 0.6, 1.0, 0.3},
		},

	},

-- Networks:
--[[ types: 0 = mobile, 1 = WiFi, 2 = mesh ]]--
	networks = {
		Semaeopus4G = {
			name = "Semaeopus4G",
			networkType = 0,
			allowPlayerDisconnect = false,
			userAccessKey = "user",
			adminAccessKey = "admin",
			rootAccessKey = "root",
		},
	},

-- Mission objectives:
	objectives = {
		-- exampleObjective = {
		-- 	name = "Example",
		-- 	description = "This is an example objective",
		-- 	messages = {
		-- 	},
		-- 	onStart = function()
		-- 		print("Started Example objective")
		-- 	end,
		-- 	onCompleted = function()
		-- 		print("Completed Example objective")
		-- 	end,
		-- },
	},

	devices = {

	},
}


--[[ Mission Setup ]]--
-- Is called every time the mission is loaded, set up characters, networks, devices etc.
-- Do not add to inventories, connect to networks etc this state is for StartMission
function SetupMission()

--	Add all characters:
for internalName, _ in pairs(mission.characters) do
	Mission.SpawnCharacter(internalName)
end

--Mission.SpawnCharacter("player")
--Mission.SpawnCharacter("laurilove")
--Mission.SpawnCharacter("mcfly")
--Mission.SpawnCharacter("JakeDavis")



	-- Add all networks:
	for k, network in pairs(mission.networks) do
--	Mission.AddNetwork(network)
	end

	Mission.MissionStarted()
end

--[[ Mission logic  ]]--
-- This function is only called when the mission is loaded with no save,
-- It should set up initial state for characters including their inventories and networks
function StartMission()
-- Add items to player inventory:
	Player.ClearInventory()

	--  Add files to data inventory:
	Player.ClearDataFiles()

	-- Set up player's network connections:
	Network.ConnectToNetwork({
		"player",
		"laurilove",
		"mcfly",
		"JakeDavis", 
		"BarrettBrown",
		"BiellaColeman",
	}, "Semaeopus4G", "user")

	-- Network.ConnectToNetwork({
	-- 	"player", "MeshleaksSecureDrop",
	-- 	"secretary", "guard1", "guard2",
	-- 	"Boss_Computer", "Joe_Computer", "Printer", "DevLaptop",
	-- 	 "BossAlarm", "Laptop_ISP_ServerRoom_1"
	--  }, "WorkWiFi", "user")
	--
	-- Network.ConnectToNetwork({
	-- 	"employee_isp_1", "guard_isp_1",
	-- }, "FirestreamWiFi", "user")
	--
	-- Network.ConnectToNetwork("MeshleaksSecureDrop", "MESH", "user")


end

-- Triggers

MissionObjects["Lauri_Speakerpram"].OnStopInteracting = function(name)
	if name == Player.GetName() then
		--TODO this is temp and so the states and audio need updating
	--	if Mission.GetBool("useIntercomObjectiveCompleted") then
			Sound.TriggerEvent("Radio_Music_Set_Station_UpBeat_1", "Lauri_Speakerpram")
			Sound.TriggerEvent("Play_Radio_Music_On", "Lauri_Speakerpram")
			AI.AlterNPCWorldState("laurilove", "Danced", false)
			print("started techno trolley")
		else
				-- do nothing
		end
	end

MissionObjects["ExitTrigger"].OnTriggerEnter = function(name)
	if name == Player.GetName() then
		Mission.MissionCompleted()
	end
end
