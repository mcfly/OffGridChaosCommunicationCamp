Shader "OffGrid/VertColTransparentSpecFull" {
	Properties {

		_MainTex ("Albedo (RGB), Transparency(A)", 2D) = "white" {}
		_BumpTex ("Normal Map", 2D) = "bump" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_Transparency("Transparency", Range(0,1)) = 0.5

		_DataColor("Data Color", color) = (1,1,1,1)
		_DataTex("Data texture", 2D) = "white" {}
		_RimPower("Data Falloff",Range(10.0,0.1)) = 3.0

	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True"}
		Zwrite Off
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
			fixed4 color : COLOR;
		};

		sampler2D _MainTex;
		sampler2D _BumpTex;
		half _Glossiness;
		half _Metallic;
		half _Transparency;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// textures
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal (tex2D(_BumpTex, IN.uv_MainTex));
			// Albedo comes from a texture tinted by color
			fixed4 c = IN.color;
			#if UNITY_COLORSPACE_GAMMA
				// do nothing. There's no '#if not' in shaderlab
			#else
				c.rgb = float3(GammaToLinearSpace(c.rgb));
			#endif

			o.Albedo = tex.rgb * c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;

			o.Alpha = tex.a * _Transparency;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
