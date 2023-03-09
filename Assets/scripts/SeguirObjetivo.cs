using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class SeguirObjetivo : MonoBehaviour
{
    // Clase que controla el movimiento de un objeto hacia un objetivo usando el NavMeshAgent de Unity
    [SerializeField] private Transform objetivo;
    // Objeto a seguir
    private NavMeshAgent navMeshAgent;

    private void Start()
    {
        // Se obtiene el componente NavMeshAgent
    navMeshAgent = GetComponent<NavMeshAgent>();

    // Se desactiva la rotación y eje vertical del NavMeshAgent
    navMeshAgent.updateRotation = false;
    navMeshAgent.updateUpAxis = false;
    }

    private void Update() {
        navMeshAgent.SetDestination(objetivo.position);
    }
}
