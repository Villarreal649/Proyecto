using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CambioNivel : MonoBehaviour
{
    private float timer = 0f;
    private float timeToChangeScene = 60f; // tiempo para cambiar de escena
    private float timeToShowMessage = 5f; // tiempo para mostrar el mensaje
    public GameObject mensaje; // referencia al gameobject Mensaje
    public TMPro.TextMeshProUGUI Tiempo;
    public AudioSource sonidoVictoria; // variable para agregar el sonido de victoria desde el inspector

    void Update()
    {
        if (timer < timeToChangeScene)
        {
            timer += Time.deltaTime;
            Debug.Log("Time elapsed: " + timer.ToString("F0") + " seconds");
            Tiempo.text = timer.ToString("F0");
        }

        if (timer >= timeToChangeScene)
        {
            foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Rodians"))
            {
                obj.SetActive(false);
            }
            StartCoroutine(ShowMessageAndWait());
        }
    }

    IEnumerator ShowMessageAndWait()
    {
        yield return null; // esperar un frame antes de activar el mensaje
        mensaje.SetActive(true); // activa el mensaje
        yield return new WaitForSeconds(timeToShowMessage); // espera para mostrar el mensaje
        mensaje.SetActive(false); // desactiva el mensaje
        sonidoVictoria.GetComponent<AudioSource>().Play(); // reproducir el sonido de victoria
        yield return new WaitForSeconds(1f); // espera adicional
        SceneManager.LoadScene("Nivel2"); // cambia de escena
    }
}
