using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class RondaController : MonoBehaviour
{
    private float timer = 0f;
    private float timeToChangeScene = 60f; // tiempo para cambiar de escena
    private float timeToShowMessage = 5f; // tiempo para mostrar el mensaje
    public GameObject mensaje; // referencia al gameobject Mensaje
    public TMPro.TextMeshProUGUI Tiempo;
    public GameObject spawnersSegundaRonda;
    public GameObject enemigo;

    void Update()
    {
        
            timer += Time.deltaTime;
            Debug.Log("Time elapsed: " + timer.ToString("F0") + " seconds");
            Tiempo.text = timer.ToString("F0");


        if (timer >= timeToChangeScene)
        {
            foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Enemy"))
            {
                Destroy(obj);
            }
            GameObject spawners = GameObject.Find("Spawners");
            if (spawners != null)
            {
                spawners.SetActive(false);
            }
            spawnersSegundaRonda.SetActive(true);
            enemigo.SetActive(true); // activa el GameObject


            StartCoroutine(ShowMessageAndWait());
        }
    }

    IEnumerator ShowMessageAndWait()
    {
        mensaje.SetActive(true); // activa el mensaje
        yield return new WaitForSeconds(timeToShowMessage); // espera para mostrar el mensaje
        Destroy(mensaje);

    }
}
