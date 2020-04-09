// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class SoundEvent : MonoBehaviour 
{
	
	[Header("The sound event to trigger when the mission starts")]
	public string soundEvent;
	
#if GAME_CORE
	private void OnEnable() {
		MissionRunnerBase.OnMissionStarted += OnMissionStarted;
	}

	private void OnDisable() {
		MissionRunnerBase.OnMissionStarted -= OnMissionStarted;
	}

	private void OnMissionStarted() {
		if (!string.IsNullOrEmpty(soundEvent)) {
			OffGridSound.SoundEvent(soundEvent, gameObject);
		} 
    }
#endif // GAME_CORE
	
}
