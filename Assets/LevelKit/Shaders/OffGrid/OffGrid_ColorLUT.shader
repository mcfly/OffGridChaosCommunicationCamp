Shader "OffGrid/OffGrid_ColorLUT" {
	Properties {
		[PerRendererData]_MainTex ("Albedo (RGB)", 2D) = "white" {}
		[PerRendererData]_MetSmoothTex("Smoothness(BW), Metallic (-A)", 2D) = "black" {}
		_DataColor("Data Color", color) = (1,1,1,1)
		_DataTex("Data texture", 2D) = "white" {}
		_RimPower("Data Falloff",Range(10.0,0.1)) = 3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _MetSmoothTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 m = tex2D(_MetSmoothTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			//o.Metallic = (m.r + m.g + m.b) / 3;
			//o.Smoothness = m.a;
			float s = (m.r + m.g + m.b) / 3;  // luminance 0->1 for rough->smooth
			o.Smoothness = clamp(s, 0.0, 0.9);  // limit smoothness a bit since too smooth looks just weird
			o.Metallic = 1 - m.a; // alpha 1->0 for dielectric->metallic
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
