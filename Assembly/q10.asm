.MODEL SMALL
.STACK 100h
.DATA
    msg db 'Using .MODEL SMALL (one code seg, one data seg). Exiting via INT 21h/4Ch.', 0Dh,0Ah, '$'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    mov dx, OFFSET msg
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
MAIN ENDP

END MAIN