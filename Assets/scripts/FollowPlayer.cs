using UnityEngine;

public class FollowPlayer : MonoBehaviour
{
    public Transform playerTransform;
    public UnityEngine.Rendering.Universal.Light2D LuzPersonaje;
    public float speed = 5f;

    void Update()
    {
        Vector3 playerPosition = playerTransform.position;
        playerPosition.z = transform.position.z;
        transform.position = Vector3.Lerp(transform.position, playerPosition, speed * Time.deltaTime);

        LuzPersonaje.transform.position = playerPosition;
    }
}
