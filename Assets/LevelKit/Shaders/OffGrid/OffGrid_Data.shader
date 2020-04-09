Shader "OffGrid/Data" {
	Properties {
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
		_RimPower ("Data Falloff",Range(10.0,0.1)) = 3.0
	}
	SubShader {
		Tags { "Queue"="Transparent" "RenderType" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf NoLight alpha

		struct Input {
			float2 uv_MainTex;
		};

		inline half4 LightingNoLight (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) { 
			float4 c;
			c.rgb = s.Albedo;
			c.a = 0;
			return c;
		}

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = half3(1,1,1);
			o.Alpha = 0;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
