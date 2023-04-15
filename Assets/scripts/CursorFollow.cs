using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CursorFollow : MonoBehaviour {

    private void Start()
    {
        Cursor.visible = true;
    }

    private void Update()
    {
        transform.position = Input.mousePosition;
    }
}