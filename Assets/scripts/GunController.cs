using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class GunController : MonoBehaviour
{
    SpriteRenderer sprite;
    public GameObject bala; 
    public Transform spawnBala;
    public Light2D luzDisparo; // Agregamos una referencia a la luz de disparo
    public AudioSource fuenteAudio;
    public AudioClip sonidoDisparo;


    void Start()
    {
        sprite = GetComponent<SpriteRenderer>();
        luzDisparo.enabled = false; // Aseguramos que la luz esté apagada al inicio
        fuenteAudio.clip = sonidoDisparo;

    }

    void Update()
    {
        Aim();

        if (Input.GetButtonDown("Fire1"))
        {
            Shoot();
        }
    }

    void Shoot(){
        Instantiate(bala, spawnBala.position, transform.rotation);
        StartCoroutine(LuzQueTitila()); // Encendemos la luz cada vez que se dispara
        fuenteAudio.Play();
    }

    void Aim(){
    Vector3 mousePos = Input.mousePosition;
    Vector3 screenPoint = Camera.main.WorldToScreenPoint(transform.position);

    Vector2 offset = new Vector2(mousePos.x - screenPoint.x, mousePos.y - screenPoint.y);
    float angle = Mathf.Atan2(offset.y, offset.x) * Mathf.Rad2Deg;

    transform.rotation = Quaternion.Euler(0, 0, angle);

    if (mousePos.x < screenPoint.x) {
        sprite.flipY = true;
        spawnBala.localPosition = new Vector3(spawnBala.localPosition.x, -Mathf.Abs(spawnBala.localPosition.y), spawnBala.localPosition.z);
        luzDisparo.transform.localPosition = new Vector3(luzDisparo.transform.localPosition.x, -Mathf.Abs(luzDisparo.transform.localPosition.y), luzDisparo.transform.localPosition.z);
    }
    else {
        sprite.flipY = false;
        spawnBala.localPosition = new Vector3(spawnBala.localPosition.x, Mathf.Abs(spawnBala.localPosition.y), spawnBala.localPosition.z);
        luzDisparo.transform.localPosition = new Vector3(luzDisparo.transform.localPosition.x, Mathf.Abs(luzDisparo.transform.localPosition.y), luzDisparo.transform.localPosition.z);
    }
 /*    void Aim(){
    Vector3 mousePos = Input.mousePosition;
    Vector3 screenPoint = Camera.main.WorldToScreenPoint(transform.position);

    Vector2 offset = new Vector2(mousePos.x - screenPoint.x, mousePos.y - screenPoint.y);
    float angle = Mathf.Atan2(offset.y, offset.x) * Mathf.Rad2Deg;

    transform.rotation = Quaternion.Euler(0, 0, angle);

    int signo = (mousePos.x < screenPoint.x) ? -1 : 1;
    sprite.flipY = (signo == -1);

    spawnBala.localPosition = new Vector3(spawnBala.localPosition.x, Mathf.Abs(spawnBala.localPosition.y) * signo, spawnBala.localPosition.z);
    luzDisparo.transform.localPosition = new Vector3(luzDisparo.transform.localPosition.x, Mathf.Abs(luzDisparo.transform.localPosition.y) * signo, luzDisparo.transform.localPosition.z);
} */

}


    IEnumerator LuzQueTitila()
    {
        luzDisparo.enabled = true; // Encendemos la luz
        yield return new WaitForSeconds(0.1f); // Esperamos 0.1 segundos
        luzDisparo.enabled = false; // Apagamos la luz
    }
}