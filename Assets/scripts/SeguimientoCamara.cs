using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeguimientoCamara : MonoBehaviour
{
    // Establece los límites de la cámara en X e Y
    public Vector2 minCamPos, maxCampos;

    // El objeto que la cámara seguirá
    public GameObject seguir;

    // La velocidad de movimiento de la cámara
    public float movSuave;

    // La velocidad actual de la cámara
    private Vector2 velocidad;

    // Start es llamado antes del primer frame
    void Start()
    {
        // No hace nada aquí
    }

    // Update es llamado una vez por frame
    void Update()
    {
        // Calcula la nueva posición en X de la cámara
        float posX = Mathf.SmoothDamp(transform.position.x, seguir.transform.position.x, ref velocidad.x, movSuave);

        // Calcula la nueva posición en Y de la cámara
        float posY = Mathf.SmoothDamp(transform.position.y, seguir.transform.position.y, ref velocidad.y, movSuave);

        // Establece la posición de la cámara en X e Y, restringiéndola a los límites especificados
        transform.position = new Vector3(
            Mathf.Clamp(posX, minCamPos.x, maxCampos.x),
            Mathf.Clamp(posY, minCamPos.y, maxCampos.y),
            transform.position.z
        );
    }
}
