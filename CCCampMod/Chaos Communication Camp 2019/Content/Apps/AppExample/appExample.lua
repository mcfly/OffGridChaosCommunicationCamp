app = {
	name = "appExample",
	description = "See the weather before you feel it.",
	cost = 0,
	showInAppWheel = AppMenuState.byDefault,
	state = AppState.off,
	icon = "appExample.png",
	iconColor = Color.Grey,

	OnStateChange = function(state)
		if state == AppState.on then
			UI.ToggleWeather(true)
		elseif state == AppState.off or state == AppState.unavailable then
			UI.ToggleWeather(false)
		end
		app.state = state
		SetState(app.state)
	end,

}
