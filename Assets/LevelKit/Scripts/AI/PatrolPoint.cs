// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;
using System.Collections;

[System.Serializable]
public class patrolPointProperties {

    [HideInInspector]
	public GameObject patrolPoint;

	public float agentWaitsForMinimum = 2f;
	public float agentWaitsForMaximum = 2f;

    public bool canReach = true;
    public float lastTried = -1.0f;

    public patrolPointProperties()
    {
    }

    public patrolPointProperties(GameObject newPatrolPoint, float minWait, float maxWait) {
		patrolPoint = newPatrolPoint;
		agentWaitsForMinimum = minWait;
		agentWaitsForMaximum = maxWait;
	}
}

[DisallowMultipleComponent]
public class PatrolPoint : MonoBehaviour {

	public patrolPointProperties properties;

	void OnEnable() {
		properties.patrolPoint = this.gameObject;
	}

	public void OnDrawGizmos()
	{
		Gizmos.DrawIcon(transform.position, "PatrolPoint");
	}
}