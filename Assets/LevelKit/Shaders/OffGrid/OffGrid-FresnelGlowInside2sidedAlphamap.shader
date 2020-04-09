Shader "OffGrid/Fresnel Glow Inside 2-sided alphamap" {
	Properties {
		_MainTex ("Base (RGBA)", 2D) = "white" {}
		_BumpTex ("Normal Map",2D) = "bump" {}
		_RimColor ("Rim Color", color) = (1,1,1,1)
		_RimPower ("Rim Power",Range(10.0,0.1)) = 3.0
	}
	
	SubShader {
		Tags {"Queue"="Transparent" "RenderType" = "Transparent"}
		Cull Off
		//ZWrite Off
		
		CGPROGRAM
		#pragma surface surf NoLight alpha noambient novertexlights nolightmap nodirlightmap noforwardadd
	
		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};
		sampler2D _MainTex;
		sampler2D _BumpTex;
		float4 _RimColor;
		float _RimPower;
		half rim;
		
		inline half4 LightingNoLight (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) { 
			float4 c;
			c.rgb = s.Albedo;
			c.a = s.Alpha;
			return c;
		}
		
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal (tex2D(_BumpTex, IN.uv_MainTex));
			half direction = dot(IN.viewDir, o.Normal);
			if (direction >= 0.0) {
				rim = dot(normalize(IN.viewDir), o.Normal);
			}
			else {
				 rim = dot(-1 * normalize(IN.viewDir), o.Normal);
			}
			o.Albedo = _RimColor.rgb;
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
			o.Alpha = _RimColor.a * c.a * pow(rim, _RimPower);
		}
		
		ENDCG
	}
	
	Fallback "Diffuse"
}