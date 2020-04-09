Shader "OffGrid/Interactable Diffuse" {
	Properties {
		_Color ("Base Color", color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Glow ("Glow", Range(0.0, 1.0)) = 0.0
		_GlowColor ("Glow Color", color) = (1,1,1,1)
		_GlowPower ("Glow Falloff", range(10.0, 0.1)) = 3.0
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float4 _Color;
		float _Glow;
		float4 _GlowColor;
		half _GlowPower;

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _GlowColor.rgb * pow(rim, _GlowPower) * _Glow;
			o.Albedo = c.rgb * _Color.rgb;
			o.Alpha = c.a * _Color.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
