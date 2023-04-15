using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class balaSaltamontes : MonoBehaviour
{
    public float speed = 10f;
    public Rigidbody2D rb;
    public int damage = 1;
    public GameObject explosionPrefab; // variable pública para el prefab de la explosión

    void Start()
    {
        rb.velocity = transform.right * speed;
    }

    void OnCollisionEnter2D(Collision2D collision)
    {

        if (collision.gameObject.CompareTag("Player"))
        {
            // añadir aquí la acción para hacer daño al jugador si se desea
        }
        Destroy(gameObject); // destruir la bala en cualquier caso
        Instantiate(explosionPrefab, transform.position, Quaternion.identity);

    }
}