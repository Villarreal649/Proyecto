using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class enemigoRango : MonoBehaviour
{
    public GameObject bulletPrefab;
    public float bulletSpeed = 10f;
    public float shootRange = 5f;
    public float shootDelay = 1f; // tiempo de espera entre disparos
    public float minDistance = 2f; // distancia mínima que el enemigo debe mantener con el jugador
    private float shootTimer = 0f; // temporizador de disparo   

    private GameObject player;

    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        InvokeRepeating("ShootAtPlayer", 0f, shootDelay);
    }

    public void Shoot(Vector2 targetPosition)
    {
        GameObject bullet = Instantiate(bulletPrefab, transform.position, Quaternion.identity);
        Rigidbody2D bulletRigidbody = bullet.GetComponent<Rigidbody2D>();
        Vector2 shootDirection = (targetPosition - (Vector2)transform.position).normalized;
        bulletRigidbody.velocity = shootDirection * bulletSpeed;
    }

    void Update()
    {
        float distanceToPlayer = Vector2.Distance(transform.position, player.transform.position);

        if (distanceToPlayer <= shootRange && distanceToPlayer > minDistance)
        {
            // mover hacia el jugador
            transform.position = Vector2.MoveTowards(transform.position, player.transform.position, Time.deltaTime * bulletSpeed);
        }

        if (distanceToPlayer < shootRange)
        {
            shootTimer += Time.deltaTime; // incrementar el temporizador

            if (shootTimer >= shootDelay)
            {
                Shoot(player.transform.position);
                shootTimer = 0f; // reiniciar el temporizador
            }
        }
        else
        {
            shootTimer = 0f; // reiniciar el temporizador si el jugador está fuera del rango
        }
    }   

    void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            Destroy(gameObject); // destruir el enemigo al colisionar con el jugador
        }
    }
}
