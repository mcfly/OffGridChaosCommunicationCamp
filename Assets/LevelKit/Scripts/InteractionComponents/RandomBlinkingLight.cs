// Copyright Semaeopus Ltd. 2017
// This code was created as part of LevelKit on: 2019-11-26 - 9:25
// DO NOT EDIT THIS FILE - Code changes will NOT be picked up and may break your project
// Visit http://wiki.offgridthegame.com for help - Happy Hacking!

using UnityEngine;

public class RandomBlinkingLight : MonoBehaviour 
{
	[ColorUsageAttribute(false, true)]
	public Color lightColor;
	[Range(0.01f, 60f)]
	public float speed = 2f;
	public AnimationCurve blink;

#if GAME_CORE

	private float brightness = 1f;
	private float currentBrightness = 0f;
	private float interval = 0.5f;

	private Color renderColor = Color.black;
	private Renderer _renderer;
	private MaterialPropertyBlock _matBlock;
	
	// Use this for initialization
	private void Start () {
		_renderer = GetComponent<Renderer>();
		_matBlock = new MaterialPropertyBlock();

		_renderer.GetPropertyBlock(_matBlock);
		_matBlock.SetColor("_Emission", lightColor);
		_renderer.SetPropertyBlock(_matBlock);

		interval = 1f / speed;
		InvokeRepeating("BlinkLight", interval, interval + Random.Range(0.1f, 1f));
	}
	
	// Update is called once per frame
	private void Update () {
		if (!Mathf.Approximately(currentBrightness, brightness)) {
			currentBrightness = Mathf.Lerp(currentBrightness, brightness, Time.deltaTime * 6f);

			renderColor.r = lightColor.r * currentBrightness;
			renderColor.g = lightColor.g * currentBrightness;
			renderColor.b = lightColor.b * currentBrightness;
			
			_renderer.GetPropertyBlock(_matBlock);
			_matBlock.SetColor("_Emission", renderColor);
			_renderer.SetPropertyBlock(_matBlock);
			
		}
	}

	private void BlinkLight() {
		float rand = Random.value;
		brightness = blink.Evaluate(rand);
	}
#endif // GAME_CORE
}