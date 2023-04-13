using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class GameOver : MonoBehaviour
{
    public void VolverAJugar(){
        SceneManager.LoadScene("SampleScene");
    }

    public void No(){
        SceneManager.LoadScene("Menu");
    }
}
