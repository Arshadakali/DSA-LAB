.MODEL SMALL
.STACK 100h
.DATA
    prompt     db 'Enter marks (e.g., 60): $'
    msgInput   db 0Dh,0Ah,'You entered: ', '$'
    msgGrade   db 0Dh,0Ah,'Grade = ', '$'
    newline    db 0Dh,0Ah,'$'

    BUF        db 2, 0, 3 dup(0)

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Prompt and read
    mov dx, OFFSET prompt
    mov ah, 09h
    int 21h

    mov dx, OFFSET BUF
    mov ah, 0Ah
    int 21h

    ; Echo input
    mov cl, [BUF+1]
    xor ch, ch
    mov si, OFFSET BUF
    add si, 2
    add si, cx
    mov BYTE PTR [si], '$'
    mov dx, OFFSET msgInput
    mov ah, 09h
    int 21h
    mov dx, OFFSET BUF
    add dx, 2
    mov ah, 09h
    int 21h

    ; Convert to AX
    mov di, 0
    mov si, OFFSET BUF
    add si, 2
    mov cl, [BUF+1]
    xor ch, ch
CONV_LOOP:
    cmp cl, 0
    je CONV_DONE
    mov al, [si]
    cmp al, '0'
    jb CONV_DONE
    cmp al, '9'
    ja CONV_DONE
    sub al, '0'
    xor ah, ah
    mov bx, 10
    mov ax, di
    mul bx
    add ax, dx
    mov dl, [si]
    sub dl, '0'
    add ax, dx
    mov di, ax
    inc si
    dec cl
    jmp CONV_LOOP
CONV_DONE:
    mov ax, di

    ; Grade determination: A/B/C/D/F
    cmp ax, 90
    jae GA
    cmp ax, 80
    jae GB
    cmp ax, 70
    jae GC
    cmp ax, 60
    jae GD
    jmp GF

GA:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'A'
    mov ah, 02h
    int 21h
    jmp EXIT
GB:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'B'
    mov ah, 02h
    int 21h
    jmp EXIT
GC:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'C'
    mov ah, 02h
    int 21h
    jmp EXIT
GD:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'D'
    mov ah, 02h
    int 21h
    jmp EXIT
GF:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'F'
    mov ah, 02h
    int 21h

EXIT:
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    mov ah, 4Ch
    int 21h
MAIN ENDP

END MAIN