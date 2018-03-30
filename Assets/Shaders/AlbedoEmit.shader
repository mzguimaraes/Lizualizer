Shader "Custom/AlbedoEmit" {

	Properties {
		_intensity ("Intensity", float) = 0.1
		_mainTex ("Albedo texture", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		half _intensity;
		sampler2D _mainTex;

		struct Input {
			float2 uv_mainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
//			fixed3 sample = (tex2D(_mainTex, IN.uv_mainTex)).rgb;
			o.Emission = tex2D(_mainTex, IN.uv_mainTex) * _intensity;
			o.Albedo = tex2D(_mainTex, IN.uv_mainTex);
		}

		ENDCG
	}

}