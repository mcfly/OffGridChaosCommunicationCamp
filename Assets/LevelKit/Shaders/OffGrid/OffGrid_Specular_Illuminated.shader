Shader "OffGrid/Specular Self-Illuminated" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		[HDR]
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
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
		
		sampler2D _MainTex;
		fixed4 _Color;
		fixed4 _EmissionColor;
		half _Glossiness;
		half _Metallic;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = tex.rgb * _Color.rgb;
			o.Emission = o.Albedo * _EmissionColor;
			o.Alpha = tex.a * _Color.a;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
	CustomEditor "VertColDiffuseEmissionGUI"
}