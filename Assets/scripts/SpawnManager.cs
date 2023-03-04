using System.Collections;
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
