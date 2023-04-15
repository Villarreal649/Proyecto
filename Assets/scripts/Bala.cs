using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bala : MonoBehaviour
{
    [SerializeField] float speed;
    [SerializeField] UnityEngine.Rendering.Universal.Light2D lightPrefab; // Prefab de la luz a asociar con la bala
    private UnityEngine.Rendering.Universal.Light2D lightInstance; // Instancia de la luz asociada a esta bala
    public float lifeTime;
    public GameObject explosion;


    // Start is called before the first frame update
    void Start()
    {
        // Crear la luz y posicionarla en la misma posición que la bala
        lightInstance = Instantiate(lightPrefab, transform.position, Quaternion.identity);
        lightInstance.transform.parent = transform;
        Invoke("DestroyProjectile",lifeTime);
    }

    // Update is called once per frame
    void Update()
    {
        // Mover la bala
        transform.Translate(Vector3.right * Time.deltaTime * speed);

        // Actualizar la posición de la luz para que siga a la bala
        lightInstance.transform.position = transform.position;
    }

    private void OnTriggerEnter2D(Collider2D collision){
        Destroy(gameObject);
    }

    void DestroyProjectile(){
        Instantiate(explosion,transform.position,Quaternion.identity);
        Destroy(gameObject);
    }
}
