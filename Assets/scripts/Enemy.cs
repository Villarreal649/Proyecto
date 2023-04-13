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
    public string[] animationNames = {"RodianCaminar", "RodianMorado", "RodianRojo"};

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
        // Seleccionar animación aleatoria
        int animIndex = Random.Range(0, animationNames.Length);
        animator.Play(animationNames[animIndex]);
    }

    private void Update() 
    {
       if (player != null)
        {
            navMeshAgent.SetDestination(player.transform.position);

            // Obtener dirección de movimiento del enemigo
            Vector3 moveDir = navMeshAgent.desiredVelocity;
            moveDir.y = 0;

            // Cambiar la escala del sprite horizontalmente
            if (moveDir.x < 0)
            {
                transform.localScale = new Vector3(-1, 1, 1); // Invertir escala en X
            }
            else if (moveDir.x > 0)
            {
                transform.localScale = new Vector3(1, 1, 1); // Mantener escala en X positiva
            }
        }        
    }
}
