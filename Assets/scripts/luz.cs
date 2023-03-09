using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class luz : MonoBehaviour
{
    public bool titila = false; // indica si la luz está titilando actualmente
    public float timeDelay; // tiempo de espera para cambiar entre encendido y apagado de la luz
    public Light2D light2D; // componente de luz 2D de Unity

    // Start is called before the first frame update
    void Start()
    {
        light2D = GetComponent<Light2D>(); // obtener el componente de luz 2D en el objeto actual
    }

    // Update is called once per frame
    void Update()
    {
        if (titila == false)
        {
            StartCoroutine(LuzQueTitila()); // si la luz no está titilando, iniciar la corrutina para titilarla
        }
    }

    // Corrutina que hace que la luz titile de manera aleatoria
    IEnumerator LuzQueTitila()
    {
        titila = true; // establecer que la luz está titilando
        light2D.enabled = false; // apagar la luz
        timeDelay = Random.Range(0.01f, 0.2f); // establecer un tiempo aleatorio de espera
        yield return new WaitForSeconds(timeDelay); // esperar el tiempo aleatorio antes de volver a encender la luz
        light2D.enabled = true; // encender la luz
        timeDelay = Random.Range(0.01f, 0.2f); // establecer un tiempo aleatorio de espera
        yield return new WaitForSeconds(timeDelay); // esperar el tiempo aleatorio antes de volver a apagar la luz
        titila = false; // establecer que la luz dejó de titilar
    }
}
//prueba de main
