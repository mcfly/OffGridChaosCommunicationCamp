device = {
	canAccess = function()
	 return true
	end,
	gui = {
		type = "ncurses",
		updateEveryFrame = false,
		header = [[Semaeopus Ltd. Developer Console]],
		backgroundColour = Color.Black,
		highlightColour = Color.DarkGrey,
		foregroundColour = {0.2, 1.0, 0.1},
		buttons = {
			objectives = {
					name = "Objectives",
					subButtons = {
						{
							--[[ This is best used either in kitchen, or in basement. ]]
							name = "Reach servers.",
							onClick = function()
								Mission.CompleteObjective("enterbuilding")
								Mission.CompleteObjective("securitykey")
								Mission.CompleteObjective("bathroom")
								Mission.StartObjective("serverroom")
							end
						},
					},
					{
						name = "Complete mission",
						onClick = function()
							Mission.MissionCompleted()
						end,
					},
			},
		 	doors = {
		 		name = "Door access",
		 		subButtons = {
		 			{
		 				name = "Copy file: Staff_key.pgp",
				 		onClick = function()
							Doors.AssignKeyToCharacter("Maintenance", Player.GetName())
				 		end,
		 			},
					{
		 				name = "Copy file: Admin_key.pgp",
				 		onClick = function()
							Doors.AssignKeyToCharacter("Admin", Player.GetName())
				 		end,
		 			},
		 		},
		 	},
		 	networks = {
		 		name = "Networks",
		 		subButtons = {
					wifi = {
		 				name = "WiFi Access [OFF]",
				 		onClick = function()
							ToggleWiFi()
				 		end,
		 			},
					mesh = {
		 				name = "MESH Access [OFF]",
				 		onClick = function()
							ToggleMESH()
				 		end,
		 			},

		 		},
		 	},
			apps = {
				name = "Apps",
				subButtons = {
					ghost = {
						name = "Ghost.lua",
						onClick = function()
							Scheduler.CallInSecs(function()
								Apps.RequestAppState("Ghost", AppState.off)
								UI.ShowNotification(NotificationType.download, "System", "Installed new application: <b>Ghost</b>", 10)
							end, 1)
						end,
					},
					debug = {
						name = "Debug.lua",
						onClick = function()
							Scheduler.CallInSecs(function()
								Apps.RequestAppState("Debug", AppState.off)
								UI.ShowNotification(NotificationType.download, "System", "Installed new application: <b>Debug</b>", 10)
							end, 1)
						end,
					},
					multiTool = {
						name = "MultiTool.lua",
						onClick = function()
							Scheduler.CallInSecs(function()
								Apps.RequestAppState("MultiTool", AppState.off)
								UI.ShowNotification(NotificationType.download, "System", "Installed new application: <b>MultiTool</b>", 10)
							end, 1)
						end,
					},
				},
			},
			player = {
		 		name = "Player settings",
		 		subButtons = {
					invisible = {
		 				name = "Invisible [OFF]",
				 		onClick = function()
							ToggleInvisible()
				 		end,
		 			},
					ragdoll = {
		 				name = "Always ragdoll [OFF]",
				 		onClick = function()
							ToggleRagdoll()
				 		end,
		 			},

		 		},
		 	},
			sound = {
		 		name = "Sound settings",
		 		subButtons = {
					track = {
		 				name = "Music track [1]",
				 		onClick = function()
							ChangeMusicTrack()
				 		end,
		 			},

		 		},
		 	},
		}
	}
}

wifi = false
function ToggleWiFi()
	wifi = not wifi
	if wifi then
		device.gui.buttons.networks.subButtons.wifi.name = "WiFi Access [ON]"
		Network.ConnectToNetwork(Player.GetName(), "ApostleWiFi", "user")
	else
		device.gui.buttons.networks.subButtons.wifi.name = "WiFi Access [OFF]"
		Network.ConnectToNetwork(Player.GetName(), "ApostleWiFi", "")
	end
	RefreshUI()
end

mesh = false
function ToggleMESH()
	mesh = not mesh
	if mesh then
		device.gui.buttons.networks.subButtons.mesh.name = "MESH Access [ON]"
		Network.ConnectToNetwork(Player.GetName(), "MESH", "user")
	else
		device.gui.buttons.networks.subButtons.mesh.name = "MESH Access [OFF]"
		Network.ConnectToNetwork(Player.GetName(), "MESH", "")
	end
	RefreshUI()
end

invisible = false
function ToggleInvisible()
	invisible = not invisible
	if invisible then
		device.gui.buttons.player.subButtons.invisible.name = "Invisible [ON]"
		Player.SetInvisible(true)
	else
		device.gui.buttons.player.subButtons.invisible.name = "Invisible [OFF]"
		Player.SetInvisible(false)
	end
	RefreshUI()
end

ragdoll = false
function ToggleRagdoll()
	ragdoll = not ragdoll
	if ragdoll then
		device.gui.buttons.player.subButtons.ragdoll.name = "Always ragdoll [ON]"
		Player.SetAlwaysRagdoll(true)
	else
		device.gui.buttons.player.subButtons.ragdoll.name = "Always ragdoll [OFF]"
		Player.SetAlwaysRagdoll(false)
	end
	RefreshUI()
end

currentTrack = 1
totalTracks = 2
function ChangeMusicTrack()
	currentTrack = currentTrack + 1
	if currentTrack > totalTracks then
		currentTrack = 1
	end
	soundEvent = "Set_MX_Mission_" .. currentTrack
	Sound.TriggerEvent(soundEvent)
	Sound.TriggerEvent("Set_State_MX_Mission_Gameplay")
	device.gui.buttons.sound.subButtons.track.name = "Music track [" .. currentTrack .."]"
	RefreshUI()
end
