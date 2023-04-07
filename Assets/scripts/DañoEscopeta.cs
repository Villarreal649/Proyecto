using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DañoEscopeta : MonoBehaviour
{
    public int hitPoints = 3;
    private int currentHitPoints;
    public GameObject explosionPrefab;

    private int damagePerShot = 1;
    private int shotsNeeded = 3;
    private float timeSinceStart = 0f;

    private void Start()
    {
        currentHitPoints = hitPoints;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.CompareTag("BulletEscopeta"))
        {
            currentHitPoints -= damagePerShot;
            Destroy(collision.gameObject);

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
        timeSinceStart += Time.deltaTime;

        if (timeSinceStart >= 60f)
        {
            shotsNeeded++;
            timeSinceStart = 0f;
        }

        damagePerShot = Mathf.CeilToInt(hitPoints / (float)shotsNeeded);
    }
}
