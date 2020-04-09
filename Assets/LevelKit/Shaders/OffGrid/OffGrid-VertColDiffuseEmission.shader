Shader "OffGrid/VertColDiffEmission" {
	Properties {
		_DataColor("Data Color", color) = (1,1,1,1)
		_DataTex("Data texture", 2D) = "white" {}
		_RimPower("Data Falloff",Range(10.0,0.1)) = 3.0
		_Emission("Emission", float) = 1.0

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
			fixed4 color : COLOR;
		};

		half _Emission;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = IN.color;
			#if UNITY_COLORSPACE_GAMMA
				// do nothing. There's no '#if not' in shaderlab
			#else
				c.rgb = float3(GammaToLinearSpace(c.rgb));
			#endif

			o.Albedo = c.rgb;
			o.Alpha = 1.0;
			o.Emission = c.rgb * _Emission;
		}
		ENDCG
	}
	FallBack "Diffuse"
	CustomEditor "VertColDiffuseEmissionGUI"
}
