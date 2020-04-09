Shader "OffGrid/DisplayPanel" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TexWidth ("Texture Width", float) = 1024.0
		_TexHeight ("Texture Height", float) = 1024.0
		_Rows ("Rows", float) = 4.0
		_Columns ("Columns", float) = 4.0
		_Speed ("Speed", Range(0.01, 32)) = 12
		_Brightness ("Brightness", Range(0.1, 1)) = 0.8
		_SpecularColor ("Specular color", color) = (1,1,1,1)
		_SpecularPower ("Glossiness", Range(0.01, 1)) = 3
		_DataColor ("Data Color", color) = (1,1,1,1)
		_DataTex ("Data texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf DisplayPanel halfasview
		#pragma target 3.0

		sampler2D _MainTex;
		float _TexWidth;
		float _TexHeight;
		float _Rows;
		float _Columns;
		float _Speed;
		float _Brightness;
		float4 _SpecularColor;
		float _SpecularPower;
		struct Input {
			float2 uv_MainTex;
		};
		
		// BlinnPhong specular lighting with self-illumination (viewDir is already half between lightDir/viewDir):
		inline fixed4 LightingDisplayPanel (SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten) {
			//half3 halfVector = normalize(lightDir + viewDir);
			fixed diff = max(0, dot(s.Normal, lightDir));
			
			//float nh = max(0, dot(s.Normal, halfVector));
			float nh = max(0, dot(s.Normal, viewDir));
			float spec = pow(nh, s.Specular*128.0) * s.Gloss;
			
			fixed4 c;
			c.rgb = ((s.Albedo * _LightColor0.rgb * diff * _Brightness + (s.Albedo * _Brightness))+ _LightColor0.rgb * _SpecularColor.rgb * spec) * (atten * 2);
			c.a = s.Alpha + _LightColor0.a * _SpecularColor.a * spec * atten;
			return c;
		}
		
		inline fixed4 LightingDisplayPanel_PrePass (SurfaceOutput s, half4 light) {
			fixed spec = light.a * s.Gloss;
			
			fixed4 c;
			c.rgb = (s.Albedo * light.rgb + light.rgb * _SpecularColor.rgb * spec * _Brightness + (s.Albedo * _Brightness));
			c.a = s.Alpha + spec * _SpecularColor.a;
			return c;
		}

		void surf (Input IN, inout SurfaceOutput o) {
			float2 spriteUV = IN.uv_MainTex;
			float cellPixelWidth = _TexWidth / _Columns;
			float cellPixelHeight = _TexHeight / _Rows;
			float cellUPercentage = cellPixelWidth / _TexWidth;
			float cellVPercentage = cellPixelHeight / _TexHeight;
			
			float timeVal = fmod(_Time.y * _Speed, _Rows * _Columns);
			timeVal = ceil(timeVal);
			
			float xValue = spriteUV.x;
			xValue += cellUPercentage * timeVal * _Columns;
			xValue *= cellUPercentage;
			
			float yValue = spriteUV.y - (cellVPercentage * _Rows);
			yValue -= cellVPercentage * floor(timeVal / _Columns) * _Rows;
			yValue *= cellVPercentage;
			
			spriteUV = float2(xValue, yValue);
			
			half4 c = tex2D (_MainTex, spriteUV);
			o.Specular = _SpecularPower;
			o.Gloss = _SpecularColor.a;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
