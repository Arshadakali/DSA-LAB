.MODEL SMALL
.STACK 100h
.DATA
    msgStart   db 'Calling procedure that preserves registers with PUSH/POP...', 0Dh,0Ah, '$'
    msgDone    db 'Procedure returned; stack balanced and registers preserved.', 0Dh,0Ah, '$'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    mov dx, OFFSET msgStart
    mov ah, 09h
    int 21h

    ; Set some registers and call the procedure
    mov ax, 1111h
    mov bx, 2222h
    mov cx, 3333h
    mov dx, 4444h

    call DemoProc

    mov dx, OFFSET msgDone
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
MAIN ENDP

DemoProc PROC
    ; Save caller state
    push ax
    push bx
    push cx
    push dx

    ; Modify registers (safe due to saved state)
    mov ax, 5555h
    mov bx, 6666h
    mov cx, 7777h
    mov dx, 8888h

    ; Restore caller state
    pop dx
    pop cx
    pop bx
    pop ax
    ret
DemoProc ENDP

END MAIN