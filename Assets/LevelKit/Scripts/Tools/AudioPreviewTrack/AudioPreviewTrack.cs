// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Klak.Timeline
{
    [TrackColor(0.8f, 0.3f, 0.4f)]
    [TrackClipType(typeof(AudioPreview))]
    public class AudioPreviewTrack : TrackAsset
    {
        #region TrackAsset overrides

        public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
        {
            return ScriptPlayable<AudioPreviewMixer>.Create(graph, inputCount);
        }

        #endregion
    }
}
