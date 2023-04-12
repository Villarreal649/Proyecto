using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    [SerializeField] Transform[] spawn;
    [SerializeField] GameObject enemy;
    [SerializeField] int maxEnemies; // Límite máximo de enemigos a instanciar
    private int enemyCount; // Cantidad actual de enemigos instanciados

    private void Start()
    {
        enemyCount = 0; // Inicializar la cantidad de enemigos instanciados a cero
        InvokeRepeating("SpawnEnemies",0.5f, 10f);
    }

    void SpawnEnemies()
    {
        if (enemyCount < maxEnemies) // Si la cantidad de enemigos instanciados es menor al límite máximo
        {
            int index = Random.Range(0, spawn.Length);
            Instantiate(enemy, spawn[index].position,Quaternion.identity);
            enemyCount++; // Aumentar la cantidad de enemigos instanciados
        }
    }
}

/* using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    [SerializeField] Transform[] spawn;
    [SerializeField] GameObject enemy;

    private void Start()
    {
        InvokeRepeating("SpawnEnemies",0.5f, 1f);
    }

    void SpawnEnemies()
    {
        int index = Random.Range(0, spawn.Length);
        Instantiate(enemy, spawn[index].position,Quaternion.identity);
    }
}
 */