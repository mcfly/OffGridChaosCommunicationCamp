// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class ParentingPlayableAsset : PlayableAsset, ITimelineClipAsset
{
    public ExposedReference<GameObject> parentRef;

    public ClipCaps clipCaps { get { return ClipCaps.None; } }
        
    public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
    {
        ScriptPlayable<ParentingPlayableBehaviour> playable = ScriptPlayable<ParentingPlayableBehaviour>.Create(graph);
        playable.GetBehaviour().parentObj = parentRef.Resolve(graph.GetResolver());

        return playable;
    }


}

// this is essentially a one-shot/one frame 'event' because we don't
// have functions in timeline
public class ParentingPlayableBehaviour : PlayableBehaviour
{
    public GameObject parentObj = null;
    public GameObject childObj = null;

    private Transform oldParent = null;

    public override void OnBehaviourPlay(Playable playable, FrameData info)
    {
        base.OnBehaviourPlay(playable, info);
        if (childObj != null)
        {
            oldParent = childObj.transform.parent; // can be null
            if (parentObj == null)
            {
                childObj.transform.parent = null;
            }
            else
            {
                childObj.transform.parent = parentObj.transform;
            }
        }
    }

    public override void OnBehaviourPause(Playable playable, FrameData info)
    {
        base.OnBehaviourPlay(playable, info);
        if (childObj != null)
        {
            childObj.transform.parent = oldParent;
        }
    }
}

[System.Serializable]
[TrackMediaType(TimelineAsset.MediaType.Script)]
[TrackClipType(typeof(ParentingPlayableAsset))]
[TrackBindingType(typeof(GameObject))]
public class ParentingTrack : TrackAsset
{
    public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
    {
        ScriptPlayable<ParentingPlayableBehaviour> mixer = ScriptPlayable<ParentingPlayableBehaviour>.Create(graph, inputCount);
#if GAME_CORE
        PlayableDirector director = go.GetComponent<PlayableDirector>();
        GameObject sourceObject = director.GetGenericBinding(this) as GameObject;
        mixer.GetBehaviour().childObj = sourceObject;
#endif
        return mixer;
    }
}
