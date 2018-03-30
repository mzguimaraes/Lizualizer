using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class FFT : MonoBehaviour {

	public int numChannels = 64;
	public int dChannel = 8;

	float[] samples;
	float[] newSamples;

	AudioSource source;

	// Use this for initialization
	void Start () {
		samples = new float[numChannels];
		newSamples = new float[numChannels];
		source = GetComponent<AudioSource>();
	}
	
	// Update is called once per frame
	void Update () {
		
		source.GetSpectrumData(newSamples, 0, FFTWindow.BlackmanHarris);
		for (int i = 0; i < numChannels; i++) {
			float lerpValue = (newSamples[i] > samples[i] ? .5f : .025f);
			samples[i] = Mathf.Lerp(samples[i], newSamples[i], lerpValue);
		}
//		Debug.Log(samples[56]);
	}

	public float GetSample(int index) {
		if (index >= numChannels) {
			throw new UnityException();
		}

		float res = 0;

		for (int i = 0; i < dChannel; i++) {
			res += samples[(index * dChannel) + i];
		}

		return res;
	}
}
