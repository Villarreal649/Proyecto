using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class JefeSaludController : MonoBehaviour
{
    [SerializeField] int vidas;
    [SerializeField] Slider sliderVidas;
    [SerializeField] Animator animatorMuerto;
    [SerializeField] Animator animatorMuertoN;
    [SerializeField] AudioClip sonidoMuerte;

    private bool isDead = false;

    private void Start()
    {
        sliderVidas.maxValue = vidas;
        sliderVidas.value = sliderVidas.maxValue;
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (isDead) return; // Si el jefe ya está muerto, no hace nada

        if (other.gameObject.CompareTag("Bullet"))
        {
            vidas -= 5; // Reduce 10 puntos de vida al jefe
            sliderVidas.value = vidas;

            if (vidas <= 0) // Si la vida llega a cero, ajusta el slider a cero y desactiva el fill area
            {
                sliderVidas.value = 0;
                sliderVidas.fillRect.gameObject.SetActive(false);

                // Ejecuta la animación de muerte correspondiente
                isDead = true;
                if (transform.position.x < 0)
                {
                    animatorMuertoN.Play("Muerte");
                }
                else
                {
                    animatorMuerto.Play("Muerte");
                }

                AudioSource audioSource = GetComponent<AudioSource>();
                audioSource.clip = sonidoMuerte;
                audioSource.Play(); // Reproduce el sonido de muerte
                Debug.Log("Boss defeated!"); // Lanza un mensaje de "Boss defeated!"
            }
        }
        else if (other.gameObject.CompareTag("BulletEscopeta"))
        {
            vidas -= 10; // Reduce 25 puntos de vida al jefe
            sliderVidas.value = vidas;

            if (vidas <= 0) // Si la vida llega a cero, ajusta el slider a cero y desactiva el fill area
            {
                sliderVidas.value = 0;
                sliderVidas.fillRect.gameObject.SetActive(false);

                // Ejecuta la animación de muerte correspondiente
                isDead = true;
                if (transform.position.x < 0)
                {
                    animatorMuertoN.Play("Muerte");
                }
                else
                {
                    animatorMuerto.Play("Muerte");
                }

                AudioSource audioSource = GetComponent<AudioSource>();
                audioSource.clip = sonidoMuerte;
                audioSource.Play(); // Reproduce el sonido de muerte
                Debug.Log("Boss defeated!"); // Lanza un mensaje de "Boss defeated!"
            }
        }
    }
}