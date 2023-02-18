using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeguimientoCamara : MonoBehaviour
{
    public Vector2 minCamPos, maxCampos;
    public GameObject seguir;
    public float movSuave;

    private Vector2 velocidad;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float posX = Mathf.SmoothDamp(transform.position.x, seguir.transform.position.x, ref velocidad.x,movSuave);
        float posY = Mathf.SmoothDamp(transform.position.y, seguir.transform.position.y, ref velocidad.y,movSuave);

        transform.position = new Vector3(
            Mathf.Clamp(posX, minCamPos.x, maxCampos.x),
            Mathf.Clamp(posY, minCamPos.y, maxCampos.y),
            transform. position.z
        );

    }
}
