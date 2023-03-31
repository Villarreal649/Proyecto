using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeCursor : MonoBehaviour
{
    [SerializeField] private CursorType cursor, defaultCursor;

    private bool hasExit;
    private void OnMouseEnter() {
        SetCursor();
        hasExit = false;
    }
    private void OnMouseExit() {
        SetDefaultCursor();
        hasExit = true;
    }
    
    private void OnDestroy() {
        if(!hasExit)
            SetDefaultCursor();
    }
    
    private void SetDefaultCursor()
    {
        Cursor.SetCursor(defaultCursor.cursorTexture,defaultCursor.cursorHotspot,CursorMode.Auto); 
    }

    private void SetCursor(){
        Cursor.SetCursor(cursor.cursorTexture,cursor.cursorHotspot,CursorMode.Auto); 
    }
}
