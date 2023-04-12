using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JefeController : MonoBehaviour
{
    [SerializeField] AudioClip[] sounds;
    private AudioSource audioSource;
    public Transform playerTransform;
    public float teleportDistance = 5f;
    public float teleportCooldown = 5f;
    public float attackCooldown = 2f;
    private float lastTeleportTime;
    private float lastAttackTime;

    private void Start()
    {
        audioSource = GetComponent<AudioSource>();
        StartCoroutine(PlayRandomSoundCoroutine());

        // Busca el objeto con el tag "Player" y guarda su transform en la variable playerTransform.
        GameObject player = GameObject.FindGameObjectWithTag("Player");
        playerTransform = player.transform;
    }

    private void Update()
    {
        // Verifica si ya ha pasado el tiempo suficiente para poder teletransportarse de nuevo.
        if (Time.time - lastTeleportTime >= teleportCooldown)
        {
            // Verifica si el jugador está lo suficientemente cerca para teletransportarse.
            if (Vector2.Distance(transform.position, playerTransform.position) <= teleportDistance)
            {
                // Teletransporta el jefe a una posición aleatoria cerca del jugador.
                Vector2 randomOffset = Random.insideUnitCircle * teleportDistance;
                Vector3 newPosition = playerTransform.position + new Vector3(randomOffset.x, randomOffset.y, 0f);
                transform.position = newPosition;

                // Actualiza el tiempo del último teletransporte.
                lastTeleportTime = Time.time;
            }
        }

        // Verifica si ya ha pasado el tiempo suficiente para poder atacar de nuevo.
        if (Time.time - lastAttackTime >= attackCooldown)
        {
            // Realiza el ataque.
            Attack();

            // Actualiza el tiempo del último ataque.
            lastAttackTime = Time.time;
        }
    }

    private IEnumerator PlayRandomSoundCoroutine()
    {
        while (true)
        {
            yield return new WaitForSeconds(5f);
            PlayRandomSound();
        }
    }

    private void PlayRandomSound()
    {
        if (sounds.Length == 0)
        {
            Debug.LogWarning("No sounds assigned");
            return;
        }

        int index = Random.Range(0, sounds.Length);
        audioSource.PlayOneShot(sounds[index]);
    }

    private void Attack()
    {
        // Implementa el código para el ataque del jefe aquí.
        // Puede ser un ataque cuerpo a cuerpo, un ataque a distancia, un ataque mágico, etc.
    }
}
