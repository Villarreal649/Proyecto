using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemigosControlador : MonoBehaviour
{
    private GameObject player;
    private NavMeshAgent navMeshAgent;
    private AudioSource audioSource;
    [SerializeField] int vidas;
    [SerializeField] AudioClip sonidoMuerte;
    public AudioClip[] audioClips;
    public float audioDelay = 0.5f;
    private Animator animator;
    public GameObject explosion;
    [SerializeField] int bulletDamage = 25;
    [SerializeField] int bulletEscopetaDamage = 50;
    [SerializeField] int escala;

    private bool isDead= false;

     // Nombre de la animación de caminar
    [SerializeField] string animacion = "nombre";

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
        animator.Play(animacion);

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
                transform.localScale = new Vector3(-escala, escala, escala); // Invertir escala en X
            }
            else if (moveDir.x > 0)
            {
                transform.localScale = new Vector3(escala, escala, escala); // Mantener escala en X positiva
            }
        }        
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (isDead) return; // Si el jefe ya está muerto, no hace nada

        if (other.gameObject.CompareTag("Bullet"))
        {
            vidas -= bulletDamage; // Reduce el daño de la bala al jefe

            if (vidas <= 0) // Si la vida llega a cero, ajusta el slider a cero y desactiva el fill area
            {

                // Ejecuta la animación de muerte correspondiente
                isDead = true;
                if (transform.position.x < 0)
                {
                    Instantiate(explosion,transform.position,Quaternion.identity);
                    Destroy(gameObject);
                }
                else
                {
                    Instantiate(explosion,transform.position,Quaternion.identity);
                    Destroy(gameObject);
                }

                AudioSource audioSource = GetComponent<AudioSource>();
                audioSource.clip = sonidoMuerte;
                audioSource.Play(); // Reproduce el sonido de muerte
                Debug.Log("Enemigo Muerto!"); // Lanza un mensaje de "Boss defeated!"
            }
        }
        else if (other.gameObject.CompareTag("BulletEscopeta"))
        {
            vidas -= bulletEscopetaDamage; // Reduce el daño de
            if (vidas <= 0) // Si la vida llega a cero, ajusta el slider a cero y desactiva el fill area
                    {
                        // Ejecuta la animación de muerte correspondiente
                        isDead = true;
                        if (transform.position.x < 0)
                        {
                            Instantiate(explosion,transform.position,Quaternion.identity);
                            Destroy(gameObject);
                        }
                        else
                        {
                            Instantiate(explosion,transform.position,Quaternion.identity);
                            Destroy(gameObject);
                        }

                        AudioSource audioSource = GetComponent<AudioSource>();
                        audioSource.clip = sonidoMuerte;
                        audioSource.Play(); // Reproduce el sonido de muerte
                        Debug.Log("Enemigo Muerto!"); // Lanza un mensaje de "Boss defeated!"
                    }
            }
    }
}






