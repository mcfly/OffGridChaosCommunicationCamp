Shader "OffGrid/VertColDiffFull" {
	Properties {

		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpTex ("Normal Map", 2D) = "bump" {}

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

		struct Input {
			float2 uv_MainTex;
			fixed4 color : COLOR;
		};

		sampler2D _MainTex;
		sampler2D _BumpTex;


		void surf (Input IN, inout SurfaceOutputStandard o) {
			// textures
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal (tex2D(_BumpTex, IN.uv_MainTex));
			fixed4 c = IN.color;
			#if UNITY_COLORSPACE_GAMMA
				// do nothing. There's no '#if not' in shaderlab
			#else
				c.rgb = float3(GammaToLinearSpace(c.rgb));
			#endif

			o.Albedo = tex.rgb * c.rgb;

			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
