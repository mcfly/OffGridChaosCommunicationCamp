Shader "OffGrid/Specular Self-Illuminated Alpha 2-Sided" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
		_Glossiness ("Glossiness", Range(0.01, 1)) = 0.5
		_Illumination ("Self-illumination", Range(0.0, 1.0)) = 0.1
		_LightTex ("Self-illumination (RGBA)", 2D) = "white" {}
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}

	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent"}
		LOD 300
		Cull Off
		
		CGPROGRAM
		#pragma surface surf BlinnPhong alpha
		
		sampler2D _LightTex;
		fixed4 _Color;
		half _Shininess;
		half _Glossiness;
		half _Illumination;
		
		struct Input {
			float2 uv_LightTex;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_LightTex, IN.uv_LightTex);
			o.Albedo = _Color.rgb;
			o.Emission = o.Albedo * _Illumination * tex.rgb * tex.a;
			o.Gloss = _Glossiness;
			o.Alpha = tex.a * _Color.a;
			o.Specular = _Shininess;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
}