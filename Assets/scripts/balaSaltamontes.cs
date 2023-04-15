using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class balaSaltamontes : MonoBehaviour
{
    public float speed = 10f;
    public Rigidbody2D rb;
    public int damage = 1;
    public GameObject explosionPrefab; // variable pública para el prefab de la explosión
    public float followTime = 3f; // tiempo durante el cual la bala sigue al jugador
    public float repeatTime = 3f; // tiempo entre cada disparo
    private float followTimer = 0f; // temporizador de seguimiento
    private GameObject player; // referencia al objeto jugador

    void Start()
    {
        rb.velocity = transform.right * speed;
        player = GameObject.FindGameObjectWithTag("Player");
        InvokeRepeating("Shoot", followTime, repeatTime);
         Invoke("DestroyBullet", followTime);
    }

    void Shoot()
    {
        followTimer = 0f;
    }

    void Update()
    {
        if (player != null && followTimer < followTime)
        {
            Vector2 targetPosition = player.transform.position;
            Vector2 shootDirection = (targetPosition - (Vector2)transform.position).normalized;
            rb.velocity = shootDirection * speed;
            followTimer += Time.deltaTime;
        }
    }

    void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player") || collision.gameObject.CompareTag("Wall"))
        {
            // añadir aquí la acción para hacer daño al jugador si se desea
        }
        Destroy(gameObject); // destruir la bala en cualquier caso
        Instantiate(explosionPrefab, transform.position, Quaternion.identity);
    }
     void DestroyBullet()
{
    Destroy(gameObject);
    Instantiate(explosionPrefab, transform.position, Quaternion.identity);
}
}
