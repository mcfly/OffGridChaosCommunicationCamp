// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;
using UnityEngine.Video;

public class VideoPlayableBehaviour : PlayableBehaviour
{
    public VideoClip video;
    
    public VideoPlayableMixer mixer { get; set; }

    private RawImage image = null;

	private bool isPlaying = false;

    public void Init()
    {
        if(image == null && mixer.player != null)
        {
            image = mixer.player.GetComponent<RawImage>();
        }
    }

    public override void OnBehaviourPlay(Playable playable, FrameData info)
    {
        if (mixer.player)
        {
            mixer.player.prepareCompleted += prepareCompleted;
            mixer.player.loopPointReached += finished;

            AudioSource audioSrc = mixer.player.gameObject.GetComponent<AudioSource>();
                        
            mixer.player.renderMode = VideoRenderMode.CameraNearPlane;

            mixer.player.playOnAwake = false;
            audioSrc.playOnAwake = false;

            mixer.player.audioOutputMode = VideoAudioOutputMode.AudioSource;

            mixer.player.controlledAudioTrackCount = 1;
            mixer.player.EnableAudioTrack(0, true);
            mixer.player.SetTargetAudioSource(0, audioSrc);

            audioSrc.volume = 1.0f;

            mixer.player.clip = video;
            mixer.player.isLooping = false;
            
            mixer.player.Prepare();
        }
    }

    public override void OnBehaviourPause(Playable playable, FrameData info)
    {
        if (mixer.player)
        {
            mixer.player.Pause();

			AudioSource audioSrc = mixer.player.gameObject.GetComponent<AudioSource>();
			audioSrc.Pause();

		}
    }

    private void prepareCompleted(VideoPlayer vp)
    {
        vp.prepareCompleted -= prepareCompleted;

        vp.EnableAudioTrack(0, true);

        vp.Play();

        if(image)
        {
            image.enabled = true;
            image.texture = vp.texture;
        }        
		if (!isPlaying) {
			vp.GetTargetAudioSource(0).Play();
		}
		else {
			vp.GetTargetAudioSource(0).UnPause();
		}
        

		isPlaying = true;
    }

    private void finished(VideoPlayer vp)
    {
		isPlaying = false;

        vp.loopPointReached -= finished;

        vp.clip = null;
        vp.renderMode = VideoRenderMode.APIOnly;

        image.enabled = false;
    }
}
