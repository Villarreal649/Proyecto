using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float moveSpeed = 15f;

    private Rigidbody2D rb;

    private Vector2 moveDirection;
    public Animator animator;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        ProcessInputs();
    }

    void FixedUpdate()
    {
        Move();
    }

    void ProcessInputs()
    {
        float moveX = Input.GetAxisRaw("Horizontal");
        float moveY = Input.GetAxisRaw("Vertical");

        moveDirection = new Vector2(moveX, moveY).normalized;

        animator.SetFloat("moveX", moveX);
        animator.SetFloat("moveY", moveY);

        if(moveX !=0 || moveY != 0)
        {
            animator.SetFloat("UltimoX", moveX);
            animator.SetFloat("UltimoY",moveY);
        }

    }

    void Move()
    {
        rb.velocity = new Vector2(moveDirection.x * moveSpeed, moveDirection.y * moveSpeed);
    }

    void OnCollisionEnter2D(Collision2D other)
    {
        // Restringir el movimiento del personaje en la dirección del objeto del escenario
        if (other.gameObject.CompareTag("Wall"))
        {
            if (Mathf.Abs(other.contacts[0].normal.x) > 0.5f)
            {
                moveDirection.x = 0f;
            }
            if (Mathf.Abs(other.contacts[0].normal.y) > 0.5f)
            {
                moveDirection.y = 0f;
            }
        }
    }
}
