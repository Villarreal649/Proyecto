using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class JefeController : MonoBehaviour
{

    private GameObject player;
    [SerializeField] private Transform objetivo;
    private NavMeshAgent navMeshAgent;
    private AudioSource audioSource;
    public AudioClip[] audioClips;
    public float speed = 3.5f;
    public float audioDelay = 0.5f;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        navMeshAgent = GetComponent<NavMeshAgent>();
        navMeshAgent.updateRotation = false;
        navMeshAgent.updateUpAxis = false;
        navMeshAgent.speed = speed; // Asignar velocidad al NavMeshAgent
        // Obtener componente AudioSource
        audioSource = GetComponent<AudioSource>();
        // Reproducir sonido aleatorio
        if (audioClips.Length > 0)
        {
            int randomIndex = Random.Range(0, audioClips.Length);
            audioSource.clip = audioClips[randomIndex];
            audioSource.PlayDelayed(audioDelay);
        }
    }

    private void Update()
    {
        navMeshAgent.SetDestination(objetivo.position);
        if (player != null)
        {
            // Obtener dirección de movimiento del enemigo
            Vector3 moveDir = navMeshAgent.desiredVelocity;
            moveDir.y = 0;

            // Cambiar la escala del sprite horizontalmente
            if (moveDir.x < 0)
            {
                transform.localScale = new Vector3(-2, 2, 2); // Invertir escala en X
            }
            else if (moveDir.x > 0)
            {
                transform.localScale = new Vector3(2, 2, 2); // Mantener escala en X positiva
            }
        }
    }

    void OnCollisionEnter2D(Collision2D other)
    {
        // Restringir el movimiento del personaje en la dirección del objeto del escenario
        if (other.gameObject.CompareTag("Wall"))
        {
            if (Mathf.Abs(other.contacts[0].normal.x) > 0.5f)
            {
                navMeshAgent.velocity = new Vector2(0f, navMeshAgent.velocity.y);
            }
            if (Mathf.Abs(other.contacts[0].normal.y) > 0.5f)
            {
                navMeshAgent.velocity = new Vector2(navMeshAgent.velocity.x, 0f);
            }
        }
    }
}
