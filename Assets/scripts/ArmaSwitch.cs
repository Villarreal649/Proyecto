using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArmaSwitch : MonoBehaviour
{
    public GameObject pistola;
    public GameObject escopeta;

    bool armaActualEsPistola = true;

    void Awake()
    {
        // Al inicio del juego, se activa la pistola y se desactiva la escopeta
        pistola.SetActive(true);
        escopeta.SetActive(false);
    }

    void CambiarArma(GameObject arma1, GameObject arma2)
    {
        arma1.SetActive(true);
        arma2.SetActive(false);
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(1))
        {
            // Si se hace clic derecho, se cambia de arma
            if (armaActualEsPistola)
            {
                CambiarArma(escopeta, pistola);
                armaActualEsPistola = false;
            }
            else
            {
                CambiarArma(pistola, escopeta);
                armaActualEsPistola = true;
            }
        }
    }
}
