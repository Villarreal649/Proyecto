
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

    // Procesamos las entradas del teclado
/* void ProcessInputs()
{
    // Obtenemos el valor de los ejes horizontal y vertical
    float moveX = Input.GetAxisRaw("Horizontal");
    float moveY = Input.GetAxisRaw("Vertical");

    // Normalizamos la dirección del movimiento
    moveDirection = new Vector2(mSoveX, moveY).normalized;

    // Cambiamos la animación de movimiento del personaje según la posición del cursor
    Vector3 cursorPosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
    float deltaX = cursorPosition.x - transform.position.x;
    float deltaY = cursorPosition.y - transform.position.y;
    if (Mathf.Abs(deltaX) > Mathf.Abs(deltaY))
    {
        moveX = deltaX > 0 ? 1 : -1;
        moveY = 0;
    }
    else
    {
        moveY = deltaY > 0 ? 1 : -1;
        moveX = 0;
    }
    animator.SetFloat("moveX", moveX);
    animator.SetFloat("moveY", moveY);

    // Guardamos la última dirección en la que se movió el personaje
    if(moveX != 0 || moveY != 0)
    {
        animator.SetFloat("UltimoX", moveX);
        animator.SetFloat("UltimoY", moveY);
    }

    // Movemos al jugador
    float movePlayerX = Input.GetAxisRaw("Horizontal");
    float movePlayerY = Input.GetAxisRaw("Vertical");
    transform.position += new Vector3(movePlayerX, movePlayerY, 0) * moveSpeed * Time.deltaTime;
} */
void ProcessInputs()
{
    // Obtenemos el valor de los ejes horizontal y vertical
    float moveX = Input.GetAxisRaw("Horizontal");
    float moveY = Input.GetAxisRaw("Vertical");

    // Normalizamos la dirección del movimiento
    moveDirection = new Vector2(moveX, moveY).normalized;

    // Cambiamos la animación de movimiento del personaje
    animator.SetFloat("moveX", moveX);
    animator.SetFloat("moveY", moveY);

    // Guardamos la última dirección en la que se movió el personaje
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
