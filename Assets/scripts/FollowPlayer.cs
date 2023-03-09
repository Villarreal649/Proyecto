using UnityEngine;

public class FollowPlayer : MonoBehaviour
{
    // Variable pública que representa la transformación del jugador a seguir.
    public Transform playerTransform;

    // Variable pública que representa la luz del personaje.
    public UnityEngine.Rendering.Universal.Light2D LuzPersonaje;

    // Variable pública que representa la velocidad a la que el objeto debe seguir al jugador.
    public float speed = 5f;

    // Método Update que se llama en cada frame.
    void Update()
    {
        // Vector3 que representa la posición actual del jugador.
        Vector3 playerPosition = playerTransform.position;

        // Se establece la posición z del objeto a la misma posición z del jugador.
        playerPosition.z = transform.position.z;

        // Se utiliza la función Lerp para hacer que el objeto se mueva suavemente hacia la posición del jugador.
        // Esto se hace para que el objeto no se mueva bruscamente, sino que tenga una transición suave.
        transform.position = Vector3.Lerp(transform.position, playerPosition, speed * Time.deltaTime);

        // Se establece la posición de la luz del personaje a la posición del jugador.
        LuzPersonaje.transform.position = playerPosition;
    }
}
