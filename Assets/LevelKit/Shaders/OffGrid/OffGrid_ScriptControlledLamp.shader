Shader "OffGrid/ScriptControlledLamp" {
	Properties {
		_Color ("Main Color", Color) = (0,0,0,1)
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		[PerRendererData]_Emission("Emission Color", Color) = (1,1,1,1)
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 300
		Cull Off
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0
		
		fixed4 _Color;
		fixed4 _Emission;
		half _Glossiness;
		half _Metallic;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
			o.Emission = _Emission.rgb;
			o.Alpha = _Color.a;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
}