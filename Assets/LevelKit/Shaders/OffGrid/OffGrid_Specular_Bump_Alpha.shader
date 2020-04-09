Shader "OffGrid/Transparent Specular Bumped" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
		_MainTex ("Base (RGB), Transparency (A)", 2D) = "white" {}
		_BumpTex ("Normal Map", 2D) = "bump" {}
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}
	
	SubShader {
			Tags { "Queue"="Transparent" "RenderType"="Transparent" }
			LOD 300
			
		CGPROGRAM
		#pragma surface surf BlinnPhong alpha
		
		sampler2D _MainTex;
		sampler2D _BumpTex;
		fixed4 _Color;
		half _Shininess;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal (tex2D(_BumpTex, IN.uv_MainTex));
			o.Albedo = tex.rgb * _Color.rgb;
			o.Gloss = 0.5;
			o.Alpha = tex.a * _Color.a;
			o.Specular = _Shininess;
		}
		ENDCG
	}
	
	Fallback "VertexLit"
}