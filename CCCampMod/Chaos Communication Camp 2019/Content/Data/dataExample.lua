
function StartNextObjective()
	RunMissionCommand('Mission.CompleteObjective(YOUROBJECTIVE)')
end

if DeviceName == "player" then
	print("Yee")
elseif DeviceName == "YOURDEVICE" then
	print("Yee")
	--Scheduler.CallInSecsReal(StartNextObjective,0.5)
	RunMissionCommand('Mission.CompleteObjective(YOUROBJECTIVE)')
	print("should have completed objective")
end
