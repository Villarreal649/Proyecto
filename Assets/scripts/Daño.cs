using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Daño : MonoBehaviour
{
    public int hitPoints = 3;
    private int currentHitPoints;
    public GameObject explosion;

    private int damagePerShot = 1;
    private int shotsNeeded = 3;
    private float timeSinceStart = 0f;

    private void Start()
    {
        currentHitPoints = hitPoints;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.CompareTag("Bullet"))
        {
            currentHitPoints -= damagePerShot;
            Destroy(collision.gameObject);
            if (currentHitPoints <= 0)
            {
                Destroy(gameObject);
                Instantiate(explosion, transform.position, Quaternion.identity);
            }
        }
    }

    private void Update()
    {
        // Increment time since start
        timeSinceStart += Time.deltaTime;

        // Check if a minute has passed
        if (timeSinceStart >= 60f)
        {
            // Increase shots needed to destroy enemy and reset timer
            shotsNeeded++;
            timeSinceStart = 0f;
        }

        // Update damage per shot based on shots needed
        damagePerShot = Mathf.CeilToInt(hitPoints / (float)shotsNeeded);
    }
}
