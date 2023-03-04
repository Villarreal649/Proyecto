using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour
{

    private GameObject player;
    private NavMeshAgent navMeshAgent;
    private AudioSource audioSource;
    public AudioClip[] audioClips;
    public float audioDelay = 0.5f;
    private Animator animator;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        navMeshAgent = GetComponent<NavMeshAgent>();
        navMeshAgent.updateRotation = false;
        navMeshAgent.updateUpAxis = false;
        // Obtener componente AudioSource
        audioSource = GetComponent<AudioSource>();
        // Reproducir sonido aleatorio
        if (audioClips.Length > 0)
        {
            int randomIndex = Random.Range(0, audioClips.Length);
            audioSource.clip = audioClips[randomIndex];
            audioSource.PlayDelayed(audioDelay);
        }
        // Obtener componente Animator
        animator = GetComponent<Animator>();
        // Reproducir animación de caminar
        animator.Play("caminar1");
    }

    private void Update() {
        if (player != null)
        {
            navMeshAgent.SetDestination(player.transform.position);
        }
    }

   
   /*  [SerializeField] float speed;
    GameObject player;
    //Animator anim;
    bool isAlive = true;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        //anim = GetComponentInChildren<Animator>();
    }

    private void Update()
    {
        if (player != null && isAlive)
        {
            transform.position = Vector2.MoveTowards(transform.position, player.transform.position, speed * Time.deltaTime);
        }
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.CompareTag("Bullet"))
        {
            //anim.SetTrigger("Dead");
            isAlive = false;
            Destroy(gameObject, 0.3f);
        }
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        // Restringir el movimiento del enemigo en la dirección del objeto del escenario
        if (other.gameObject.CompareTag("Wall"))
        {
            if (Mathf.Abs(other.contacts[0].normal.x) > 0.5f)
            {
                speed = 0f;
            }
            if (Mathf.Abs(other.contacts[0].normal.y) > 0.5f)
            {
                speed = 0f;
            }
        }
    } */
}
