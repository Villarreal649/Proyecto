using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnerMunicion : MonoBehaviour
{
    [SerializeField] Transform[] spawn;
    [SerializeField] GameObject ammunition;
    [SerializeField] int maxAmmo; // Límite máximo de munición a instanciar
    private int ammoCount; // Cantidad actual de munición instanciada

    private void Start()
    {
        ammoCount = 0; // Inicializar la cantidad de munición instanciada a cero
        InvokeRepeating("SpawnAmmo", 0.5f, 10f);
    }

    void SpawnAmmo()
    {
        if (ammoCount < maxAmmo) // Si la cantidad de munición instanciada es menor al límite máximo
        {
            int index = Random.Range(0, spawn.Length);
            Instantiate(ammunition, spawn[index].position, Quaternion.identity);
            ammoCount++; // Aumentar la cantidad de munición instanciada
        }
    }
}
