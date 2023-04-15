using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Aldeano : MonoBehaviour
{
    [SerializeField] private float velocidadMovimiento;
    [SerializeField] private Transform[] puntosMovimiento;
    [SerializeField] private float distanciaMinima;
    [SerializeField] private AudioClip gritoAldeano;
    private int numAleatorio;
    private SpriteRenderer spriteRenderer;
    private float tiempoDeSonido;

    // Start is called before the first frame update
    void Start()
    {
        numAleatorio = Random.Range(0, puntosMovimiento.Length);
        spriteRenderer = GetComponent<SpriteRenderer>();
        Girar();
        tiempoDeSonido = 0f;
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = Vector2.MoveTowards(transform.position, puntosMovimiento[numAleatorio].position, velocidadMovimiento * Time.deltaTime);
        if (Vector2.Distance(transform.position, puntosMovimiento[numAleatorio].position) < distanciaMinima)
        {
            numAleatorio = Random.Range(0, puntosMovimiento.Length);
            //girar
            Girar();
        }

        // Contador de tiempo para reproducir sonido cada 10 segundos
        tiempoDeSonido += Time.deltaTime;
        if (tiempoDeSonido >= 10f)
        {
            tiempoDeSonido = 0f;
            AudioSource.PlayClipAtPoint(gritoAldeano, transform.position);
        }
    }

    private void Girar()
    {
        if (transform.position.x < puntosMovimiento[numAleatorio].position.x)
        {
            spriteRenderer.flipX = true;
        }
        else
        {
            spriteRenderer.flipX = false;
        }
    }
}
