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
		joe = {
			displayName = "Joe Harman",
			internalName = "Joe",
			characterType = "player",
			prefab = "player",
			spawnpoint = "PlayerSpawn",
		},
		-- mcfly = {
		-- 	displayName = "mc.fly",
		-- 	internalName = "mcfly",
		-- 	characterType = "enemy",
		-- 	--prefab = "mcfly",
		-- 	spawnpoint = "mcflySpawn",
		-- },
		laurilove = {
			displayName = "nsh",
			internalName = "lauri",
			agent = "LauriAgent.lua",
			characterType = "npc",
			profile = "LauriLove",
			prefab = "Masculine_Med_OpenShirt_Enemy",
			activity = {
				points = {
					"LauriPatrol01",
					"LauriPatrol02",
				},
				cyclic = false,
			},
			spawnpoint = "LauriSpawn",
		},
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

	-- Add all characters:
	for k, character in pairs(mission.characters) do
		Mission.AddCharacter(character)
	end

	-- Add all networks:
	for k, network in pairs(mission.networks) do
	Mission.AddNetwork(network)
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
	Mission.ConnectToNetwork(mission.characters.joe, mission.networks.Semaeopus4G.name, mission.networks.Semaeopus4G.userAccessKey )

end

-- Triggers

-- Talk to secretary with intercom in Reception
MissionObjects["Lauri_Speakerpram"].OnStopInteracting = function(name)
	if name == Player.GetName() then
		--TODO this is temp and so the states and audio need updating
	--	if Mission.GetBool("useIntercomObjectiveCompleted") then
			Sound.TriggerEvent("Radio_Music_Set_Station_UpBeat_1", "Lauri_Speakerpram")
			Sound.TriggerEvent("Play_Radio_Music_On", "Lauri_Speakerpram")
			AI.AlterNPCWorldState("lauri", "state", true)
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
