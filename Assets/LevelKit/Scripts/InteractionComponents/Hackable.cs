// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

[System.Serializable]
public class StringEvent : UnityEvent<string> { }

public enum ItemSlotsID { RightHandDefault/*, LeftHandDefault*/ }

public class Hackable : MonoBehaviour
{
    [System.Serializable]
    public class SaveInfo
    {
        public string name = string.Empty;
        public bool powered = false;
        public bool active = false;
        public bool amok = false;
        public string value = string.Empty;

        public bool preservedActive = false;
    }

    [SerializeField] private bool powered = true;
    [SerializeField] private bool active = false;
    [SerializeField] private bool amok = false;
    [SerializeField] private string value = string.Empty;

    [Tooltip("If true, when power is cycled, Active status will be retained")]
    [SerializeField] private bool preserveActive = true;
    [Tooltip("The only time this should be set to true in the Editor is when creating a device without power that should become active the first time it gains power")]
    [SerializeField] private bool preservedActive = false;

    [SerializeField] public UnityEvent PowerOnEvent = new UnityEvent();
    [SerializeField] public UnityEvent PowerOffEvent = new UnityEvent();
    [SerializeField] public UnityEvent ActiveOnEvent = new UnityEvent();
    [SerializeField] public UnityEvent ActiveOffEvent = new UnityEvent();
    [SerializeField] public UnityEvent AmokOnEvent = new UnityEvent();
    [SerializeField] public UnityEvent AmokOffEvent = new UnityEvent();
    [SerializeField] public UnityEvent RunOnceEvent = new UnityEvent();
    [SerializeField] public StringEvent SetValueEvent = new StringEvent();
    [SerializeField] public StringEvent NPCuseEvent = new StringEvent();


    public delegate string GetValueDelegate();
    public GetValueDelegate getValueDelegate = null;

    public GameObject animationItemProp = null;
    public ItemSlotsID slotItemProp = ItemSlotsID.RightHandDefault;

    protected virtual void Start()
    {

    }

    protected void OnEnable()
    {
#if GAME_CORE
        MissionRunnerBase.OnMissionStarted += Init;
#endif
    }

    protected void OnDisable()
    {
#if GAME_CORE
        MissionRunnerBase.OnMissionStarted -= Init;
#endif
    }

    public virtual void Init()
    {
#if GAME_CORE
        OnPowerChange(powered);
        OnActiveChange(active);
        OnAmokChange(amok);
#endif
    }

    public SaveInfo OnSave()
    {
        return new SaveInfo()
        {
            name = gameObject.name,

            powered = this.powered,
            active = this.active,
            amok = this.amok,
            value = this.value,
            preservedActive = this.preservedActive,
        };
    }

    public void OnLoad(SaveInfo info)
    {
        powered = info.powered;
        active = info.active;
        amok = info.amok;
        value = info.value;
        preservedActive = info.active;
    }

#if GAME_CORE
    // Powering on a device should switch on any lights or displays, allow it to connect to networks etc.
    public void SetPower(bool tf)
    {
        if (powered != tf)
        {
            powered = tf;
            
            // if we are losing power, we set to inactive, and preserve the value in case we need it.
            if (!powered)
            {
                preservedActive = GetActive();
                SetActive(false);
            }

            OnPowerChange(powered);

            if(powered)
            {
                PowerOnEvent.Invoke();
            }
            else
            {
                PowerOffEvent.Invoke();
            }
            
            // after all the events - if we have gained power, preserved the active state AND want to use it, activate here.
            if(powered && preserveActive && preservedActive)
            {
                SetActive(true);
                preservedActive = false;
            }
        }
    }

    public void TogglePower()
    {
        SetPower(!GetPower());
    }

	public bool GetPower()
    {
        return powered;
    }

    public virtual void OnPowerChange(bool powered)
    {

    }

	// Active means the device is doing what ever its default "job" would be. Security camera actually monitoring things, printer spitting oput paper etc.
	public void SetActive(bool tf)
    {
        if(!GetPower())
        {
            Logger.Log(Channel.NetDevice, "Attempting to set a powerless device to active");
        }

        if (!tf || GetPower()) // only allow this to become active if it has power
        {
            if (active != tf)
            {
                active = tf;
                OnActiveChange(active);

                if (active)
                {
                    ActiveOnEvent.Invoke();
                }
                else
                {
                    ActiveOffEvent.Invoke();
                }
            }
        }
    }

    public void ToggleActive()
    {
        SetActive(!GetActive());
    }

	public bool GetActive()
    {
        return active;
    }

    public virtual void OnActiveChange(bool active)
    {

    }

    // Toggle chaotic, broken state. Smoke, sparks, bangs etc...
    public void SetAmok(bool tf)
    {
        if (amok != tf)
        {
            amok = tf;
            OnAmokChange(amok);

            if (amok)
            {
                AmokOnEvent.Invoke();
            }
            else
            {
                AmokOffEvent.Invoke();
            }
        }
    }

    public void ToggleAmok()
    {
        SetAmok(!GetAmok());
    }

    public bool GetAmok()
    {
        return amok;
    }

    public virtual void OnAmokChange(bool amok)
    {

    }

    // Single-shot version of SetActive. For example printer printing single sheet, or vending machine spitting out single can of soda.
    // If single-shot action doesn't fit with the device, make it a short-timed one instead (single sweep of security camera, or open lock for 10 seconds etc)
    public void RunOnce()
    {
        OnRunOnce();
        RunOnceEvent.Invoke();
    }


    public virtual void OnRunOnce()
    {

    }
    
    // For more specific state control
    public virtual void SetValue(string newState)
    {
        value = newState;
        SetValueEvent.Invoke(newState);
    }

    public virtual string GetValue()
    {
        if(getValueDelegate == null)
            return value;

        return getValueDelegate();
    }

    public virtual void NPCuse(string npc)
    {
        NPCuseEvent.Invoke(npc);
    }


    // TODO: We *might* want these in the future?

    //// Get/Set key file needed to operate the device (unlock a door, print a sheet etc)
    //void SetUseKey(DataPointInfo newKey);
    //DataPointInfo GetUseKey();
    //// Check if a key is needed (should return false if key is null)
    //bool RequiresUseKey();

    //// Get/set the key file needed to connect to the device (SSH conenction to control panel)4
    //void SetAccessKey(DataPointInfo newKey);
    //DataPointInfo GetAccessKey();
    //// Check if a key is needed (should return false if key is null)
    //bool RequiresAccessKey();

#endif // GAME_CORE

}
