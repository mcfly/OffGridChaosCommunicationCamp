using UnityEngine;
using UnityEditor;
using System;

public class VertColDiffuseEmissionGUI : ShaderGUI {
	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties) {
		// render the default gui
		base.OnGUI(materialEditor, properties);

		Material targetMat = materialEditor.target as Material;

		materialEditor.LightmapEmissionProperty(MaterialEditor.kMiniTextureFieldLabelIndentLevel + 1);
		MaterialGlobalIlluminationFlags flags = targetMat.globalIlluminationFlags;
		if ((flags & (MaterialGlobalIlluminationFlags.BakedEmissive | MaterialGlobalIlluminationFlags.RealtimeEmissive)) != 0) {
			flags &= ~MaterialGlobalIlluminationFlags.EmissiveIsBlack;
			targetMat.globalIlluminationFlags = flags;
		}

	}
}
