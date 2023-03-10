using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class Daño : MonoBehaviour
{
    public int hitPoints = 3;
    private int currentHitPoints;
    public GameObject explosionPrefab;

    private int damagePerShot = 1;
    private int shotsNeeded = 3;
    private float timeSinceStart = 0f;

    private void Start()
    {
        // Inicializar 'currentHitPoints' con el valor de 'hitPoints'.
        currentHitPoints = hitPoints;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        // Comprobar si el objeto que ha colisionado tiene la etiqueta "Bullet".
        if (collision.CompareTag("Bullet"))
        {
            // Reducir los puntos de vida actuales del objeto y destruir la bala que ha colisionado.
            currentHitPoints -= damagePerShot;
            Destroy(collision.gameObject);

            // Si los puntos de vida actuales son 0 o menos, destruir el objeto y crear una explosión en su posición.
            if (currentHitPoints <= 0)
            {
                Destroy(gameObject);
                GameObject explosionInstance = Instantiate(explosionPrefab, transform.position, Quaternion.identity);
                Destroy(explosionInstance, 0.5f);
            }
        }
    }

    private void Update()
    {
        // Incrementar el tiempo transcurrido desde el inicio del juego.
        timeSinceStart += Time.deltaTime;

        // Comprobar si ha pasado un minuto.
        if (timeSinceStart >= 60f)
        {
            // Aumentar los disparos necesarios para destruir el objeto y reiniciar el temporizador.
            shotsNeeded++;
            timeSinceStart = 0f;
        }

        // Actualizar el daño por disparo basándose en los disparos necesarios.
        damagePerShot = Mathf.CeilToInt(hitPoints / (float)shotsNeeded);
    }
}
