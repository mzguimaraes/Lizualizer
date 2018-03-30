using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pulse : MonoBehaviour {

	public FFT spectrum;
	public int index;
	public float mult = 10000f;

	public float value;

	Material mat;

	void Start() {
		mat = GetComponent<Renderer>().material;
	}

	void LateUpdate() {
		float intensity = spectrum.GetSample(index);
		intensity*=mult * (index+1);
//		Debug.Log("index: " + index + ", value: " + intensity);

		if (intensity <= 0.1f) {
			intensity = 0;
		}

		value = intensity;

		mat.SetFloat("_intensity", intensity);
	}
}
