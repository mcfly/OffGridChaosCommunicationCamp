// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Collider))]
public class DoorSlideTrigger : MonoBehaviour
{
    public float _autoCloseTimer = 1f;
    private Door _door;
    private bool _canClose = true;
    private Coroutine _closeDoorCoroutine;

#if GAME_CORE
    void Start()
    {
        _door = GetComponentInParent<Door>();
    }

     private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player") && !_door.isLocked)
        {
			_canClose = false;
			OpenDoorAutomatically();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player") && !_canClose)
        {
			_canClose = true;
            if(_closeDoorCoroutine != null) { StopCoroutine(_closeDoorCoroutine); }
            _closeDoorCoroutine = StartCoroutine(CloseDoor());
        }
    }


    private void OpenDoorAutomatically()
    {
		if (!_door.isLocked && !_door.isOpen) {
			_door.Toggle(true, true);
		}
    }

    IEnumerator CloseDoor()
    {
        float closeTimer = _autoCloseTimer;
        while(closeTimer > 0 && _canClose && _door.isOpen)
        {
            closeTimer -= Time.deltaTime;
            yield return null;
        }
        if(_canClose && _door.isOpen)
        {
            _door.Toggle(false, true);
        }
    }
#endif
}
