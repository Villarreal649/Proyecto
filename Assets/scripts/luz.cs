using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class luz : MonoBehaviour
{
    public bool titila = false;
    public float timeDelay;
    public Light2D light2D;

    // Start is called before the first frame update
    void Start()
    {
        light2D = GetComponent<Light2D>();
    }

    // Update is called once per frame
    void Update()
    {
        if (titila == false)
        {
            StartCoroutine(LuzQueTitila());
        }
    }

    IEnumerator LuzQueTitila()
    {
        titila = true;
        light2D.enabled = false;
        timeDelay = Random.Range(0.01f, 0.2f);
        yield return new WaitForSeconds(timeDelay);
        light2D.enabled = true;
        timeDelay = Random.Range(0.01f, 0.2f);
        yield return new WaitForSeconds(timeDelay);
        titila = false;
    }
}
//prueba de main