// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

[System.Serializable]
public class VideoPlayableMixer : PlayableBehaviour
{
    public UnityEngine.Video.VideoPlayer player { get; set; }
    public PlayableDirector timeline { get; set; }

    public override void OnGraphStart(Playable playable)
    {
        for (int i = 0; i < playable.GetInputCount(); i++)
        {
            ScriptPlayable<VideoPlayableBehaviour> inputPlayable = (ScriptPlayable<VideoPlayableBehaviour>)playable.GetInput(i);
            VideoPlayableBehaviour input = inputPlayable.GetBehaviour();
            
            input.mixer = this;
            input.Init();
        }
    }
}
