Shader "Custom/ColorEmit" {

	Properties {
		_color ("Base Color", Color) = (1,1,1,1)
		_intensity ("Intensity", float) = 0.1
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _color;
		half _intensity;

		struct Input {
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed3 intense = _color.rgb * _intensity;
			o.Emission = intense;
			o.Albedo = _color.rgb;
		}

		ENDCG
	}

}