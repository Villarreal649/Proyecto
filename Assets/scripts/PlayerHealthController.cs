using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class PlayerHealthController : MonoBehaviour
{
    [SerializeField] int vidas;
    [SerializeField] Slider sliderVidas;
    [SerializeField] Animator animatorMuerto;
    [SerializeField] Animator animatorMuertoN;

    private bool isDead = false;

    private void Start()
    {
        sliderVidas.maxValue = vidas;
        sliderVidas.value = sliderVidas.maxValue;
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        if (isDead) return; // Si el jugador ya está muerto, no hace nada

        if (other.gameObject.CompareTag("Rodians"))
        {
            vidas -= 15; // Reduce 15 puntos de vida al jugador
            sliderVidas.value = vidas;

            // Reproduce un sonido de golpe
            AudioSource audioSource = GetComponent<AudioSource>();
            if (audioSource != null)
            {
                audioSource.Play();
            }

            if (vidas <= 0) // Si la vida llega a cero, ajusta el slider a cero y desactiva el fill area
            {
                sliderVidas.value = 0;
                sliderVidas.fillRect.gameObject.SetActive(false);

                // Ejecuta la animación de muerte correspondiente y desactiva el control del jugador
                isDead = true;
                GetComponent<PlayerController>().enabled = false;
        
                if (transform.position.x < 0)
                {
                    animatorMuertoN.Play("MuertoN");
                    SceneManager.LoadScene("GameOver");
                }
                else
                {
                    animatorMuerto.Play("Muerto");
                    SceneManager.LoadScene("GameOver");
                }

                Debug.Log("Game Over"); // Lanza un mensaje de "Game Over"
            }
        }
    }
}
