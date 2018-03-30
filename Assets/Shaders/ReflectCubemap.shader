Shader "Custom/ReflectCubemap" {

	Properties {
		_intensity ("Intensity", float) = 0.1
		_mainTex ("Albedo texture", 2D) = "white" {}
		_cubemap ("Cubemap", CUBE) = "" {}
		_norm ("Bump texture", 2D) = "bump" {}
		_normIntensity ("Bump Intensity", Range(0,5)) = 1
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		half _intensity;
		sampler2D _mainTex;
		samplerCUBE _cubemap;
		sampler2D _norm;
		half _normIntensity;

		struct Input {
			float2 uv_mainTex;
			float2 uv_norm;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf(Input IN, inout SurfaceOutput o) {
//			fixed3 sample = (tex2D(_mainTex, IN.uv_mainTex)).rgb;
			o.Emission = texCUBE(_cubemap, IN.worldRefl) * _intensity;
			o.Albedo = tex2D(_mainTex, IN.uv_mainTex);
			o.Normal = UnpackNormal(tex2D(_norm, IN.uv_norm));
			o.Normal *= float3(_normIntensity, _normIntensity, 1);
		}

		ENDCG
	}
	FallBack "Diffuse"
}