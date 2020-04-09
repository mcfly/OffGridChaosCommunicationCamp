Shader "OffGrid/Interactable Specular Self-Illuminated" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
		_Illumination ("Self-illumination", Range(0.0, 1.0)) = 0.1
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_Glow ("Glow", Range(0.0, 1.0)) = 0.0
		_GlowColor ("Glow Color", color) = (1,1,1,1)
		_GlowPower ("Glow Falloff", range(10.0, 0.1)) = 3.0
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 300
		Cull Off
		
		CGPROGRAM
		#pragma surface surf BlinnPhong
		
		sampler2D _MainTex;
		fixed4 _Color;
		half _Shininess;
		half _Illumination;
		float _Glow;
		float4 _GlowColor;
		half _GlowPower;
		
		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Albedo = tex.rgb * _Color.rgb;
			o.Emission = (_GlowColor.rgb * pow(rim, _GlowPower) * _Glow) + (o.Albedo * _Illumination);
			o.Gloss = tex.a;
			o.Alpha = tex.a * _Color.a;
			o.Specular = _Shininess;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
}
