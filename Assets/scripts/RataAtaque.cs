using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RataAtaque : MonoBehaviour
{
    private GameObject player;
    private Animator animator;
    public float attackDistance = 2f;
    public float attackDelay = 1f;
    private float timeSinceLastAttack;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        animator = GetComponent<Animator>();
        timeSinceLastAttack = attackDelay;
    }

    private void Update()
    {
        timeSinceLastAttack += Time.deltaTime;
    }

    private void OnTriggerStay2D(Collider2D other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            if (Vector2.Distance(transform.position, player.transform.position) <= attackDistance)
            {
                if (timeSinceLastAttack >= attackDelay)
                {
                    animator.SetTrigger("ataqueRata");
                    timeSinceLastAttack = 0f;
                }
            }
        }
    }
}
