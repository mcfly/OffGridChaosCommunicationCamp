// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

[RequireComponent(typeof(BoxCollider))]
public class SoundTrigger : MonoBehaviour 
{
	public string soundEvent;
	public bool onceOnly;

	private void OnDrawGizmos() 
	{
        Gizmos.color = Color.cyan;
        BoxCollider col = GetComponent<BoxCollider>();
        if (col)
        {
			Matrix4x4 oldMatrix = Gizmos.matrix;
			Gizmos.matrix = transform.localToWorldMatrix;
			Gizmos.DrawWireCube(col.center, col.size);
			Gizmos.DrawIcon(col.bounds.center, "AtmosTrigger");
			Gizmos.matrix = oldMatrix;
		}
	}
	
#if UNITY_EDITOR
	[MenuItem("GameObject/Off Grid/Audio/Sound Trigger", false, 10)]
	private static void CreateSoundTrigger(MenuCommand menuCommand)
	{
		// Create a custom game object
		GameObject newObject = new GameObject("NewSoundTrigger");
        
		// Ensure it gets reparented if this was a context click (otherwise does nothing)
		GameObjectUtility.SetParentAndAlign(newObject, menuCommand.context as GameObject);
        
		// Register the creation in the undo system
		Undo.RegisterCreatedObjectUndo(newObject, "Create " + newObject.name);

		// Set up the component(s)
		Undo.AddComponent<SoundTrigger>(newObject);
		BoxCollider boxCollider = Undo.AddComponent<BoxCollider>(newObject);
		boxCollider.isTrigger = true;
		boxCollider.size = new Vector3(3, 3, 3);
		
		// Set the mission objects layer
		Selection.activeObject = newObject;
	}
#endif // UNITY_EDITOR

#if GAME_CORE
	private bool triggered = false;
	
	private void OnTriggerEnter(Collider other) {
		if (other.gameObject.CompareTag("Player")) {
			if (!triggered || !onceOnly) {
				AkSoundEngine.PostEvent(soundEvent, gameObject);
				triggered = true;
				Logger.Log(Channel.Audio, "Sound event: " + soundEvent);
			}
			else if (onceOnly && triggered) {
				Logger.Log(Channel.Audio, "Ignored sound event: " + soundEvent + " (Already triggered once!)");
			}
			else  {
				Logger.Log(Channel.Audio, "Ignored sound event: " + soundEvent);
			}
		}
	}
#endif // GAME_CORE

}