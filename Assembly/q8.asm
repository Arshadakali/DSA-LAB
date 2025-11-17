.MODEL SMALL
.STACK 100h
.DATA
    msgWhy     db 'Using AH=02h prints a single character in DL.', 0Dh,0Ah, '$'
    msgDemo    db 'Grade printed with AH=02h: ', '$'
    newline    db 0Dh,0Ah,'$'
    gradeChar  db 'A'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    mov dx, OFFSET msgWhy
    mov ah, 09h
    int 21h

    mov dx, OFFSET msgDemo
    mov ah, 09h
    int 21h

    ; AH=02h needs DL = character
    mov dl, gradeChar
    mov ah, 02h
    int 21h

    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    mov ah, 4Ch
    int 21h
MAIN ENDP

END MAIN