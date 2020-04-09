// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!


using UnityEngine;
using System.Collections;
using System;

[ExecuteInEditMode]
public class InteractableLight : Hackable
{

    #region PUBLIC VARIABLES

    [Header("Bulb")]
    public MeshRenderer bulb;
    [ColorUsageAttribute(false, true)]
    public Color bulbOffColor;
    [ColorUsageAttribute(false, true)]
    public Color bulbOnColor;
    public bool activeByDefault;
    #endregion

    [Header("Light")]
    public Light lightGO;
    public float lightIntensityMultiplier = 1f;

    #region PRIVATE VARIABLES
    private MaterialPropertyBlock bulbMaterialBlock;
    #endregion

#if GAME_CORE

    #region UNITY & INIT
    // TODO remove below update function as it is a hack to test interactable lights ahead of them being Lua controllable

    void Update()
    {

    }

    void OnEnable()
    {
        bulbMaterialBlock = new MaterialPropertyBlock();
        SetActive(activeByDefault);
    }

    #endregion
    
    // Active means the device is doing what ever it's default "job" would be. Security camera actually monitoring things, printer spitting oput paper etc.
    public override void OnActiveChange(bool active)
    {
        if (active)
        {
            SetBulbColor(bulbOnColor);
            lightGO.intensity = bulbOnColor.grayscale * lightIntensityMultiplier;
            lightGO.color = bulbOnColor;
        }
        else
        {
            SetBulbColor(bulbOffColor);
            lightGO.intensity = bulbOffColor.grayscale * lightIntensityMultiplier;
            lightGO.color = bulbOffColor;
        }
    }

    #region PUBLIC METHODS
    public void Toggle()
    {
        ToggleActive();
    }
    #endregion

    #region PRIVATE METHODS

    private void SetBulbColor(Color newColour)
    {
        bulb.GetPropertyBlock(bulbMaterialBlock);
        bulbMaterialBlock.SetColor("_Emission", newColour);
        bulb.SetPropertyBlock(bulbMaterialBlock);
    }
    #endregion

#endif //GAME_CORE

}

