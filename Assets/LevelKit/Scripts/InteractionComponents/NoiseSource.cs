// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;

[System.Serializable]
public class Noise {
    public GameObject source = null;
	public Vector3 sourcePosition = Vector3.zero;
	public float volume = 0.0f;
	public float attraction = 0.0f;
    public bool trusted = false;
        
	public Noise() { }

    public Noise(Noise other)
    {
        this.source = other.source;
        this.sourcePosition = other.sourcePosition;
        this.volume = other.volume;
        this.attraction = other.attraction;
        this.trusted = other.trusted;
    }
}

public class NoiseSource : MonoBehaviour {
	
	public Noise noise;
	
	private Color gizmoColor;
	private readonly Color gizmoColor1 = Color.blue;
	private readonly Color gizmoColor2 = Color.red;
	private new SphereCollider collider;
    public string offEvent { private get; set; }
    
	private void OnDrawGizmos()
	{
		Gizmos.DrawIcon(transform.position, "NoiseSource");
		gizmoColor = Color.Lerp(gizmoColor1, gizmoColor2, noise == null ? 0.0f : noise.attraction);
		Gizmos.color = new Color(gizmoColor.r, gizmoColor.g, gizmoColor.b, 0.9f);
		Gizmos.DrawWireSphere(transform.position, 1f/(0.6f/noise.volume));
		Gizmos.color = new Color(gizmoColor.r, gizmoColor.g, gizmoColor.b, 0.6f);
		Gizmos.DrawWireSphere(transform.position, 1f/(0.3f/noise.volume));
		Gizmos.color = new Color(gizmoColor.r, gizmoColor.g, gizmoColor.b, 0.3f);
		Gizmos.DrawWireSphere(transform.position, 1f/(0.1f/noise.volume));
	}
	
#if GAME_CORE

	private void Awake() {
        noise = noise ?? new Noise()
        {
            source = gameObject,
            sourcePosition = gameObject.transform.position,
            volume = 0.0f,
            attraction = 0.0f,
            trusted = false,
        };

        if (noise.source == null)
        {
            noise.source = gameObject;
        }

		noise.sourcePosition = transform.position;
		collider = gameObject.AddComponent<SphereCollider>();
		collider.isTrigger = true;
        collider.radius = noise.volume == 0.0f ? 0.0f : 1.0f / (0.1f / noise.volume);
    }

	private void Update() {
		collider.radius = noise.volume == 0.0f ? 0.0f : 1.0f / (0.1f / noise.volume);
		noise.sourcePosition = transform.position;
	}
	
	public void EmitNoise(float volume, float attraction, float duration, bool trusted) {
        if (noise.source == null)
        {
            noise.source = gameObject;
        }
		noise.sourcePosition = gameObject.transform.position;
		noise.volume = volume;
		noise.attraction = attraction;
        noise.trusted = trusted;
        
        AkSoundEngine.PostEvent(gameObject.name, gameObject);

        if (duration > 0f) {
			Invoke("Silence", duration);
		}
	}
	
	public void Silence() {
		noise.volume = 0f;
		noise.attraction = 0f;
        
        if(!string.IsNullOrEmpty(offEvent))
        {
            AkSoundEngine.PostEvent(offEvent, gameObject);
        }
	}
#endif // GAME_CORE
	
}