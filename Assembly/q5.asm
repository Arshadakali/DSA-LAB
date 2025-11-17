.MODEL SMALL
.STACK 100h
.DATA
    prompt     db 'Enter marks (e.g., 79): $'
    msgInput   db 0Dh,0Ah,'You entered: ', '$'
    msgGrade   db 0Dh,0Ah,'Grade = ', '$'
    msgLast    db 0Dh,0Ah,'Last CMP threshold = ', '$'
    newline    db 0Dh,0Ah,'$'

    BUF        db 2, 0, 3 dup(0)
    lastCmp    dw 0

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

    ; Grade determination with lastCmp trace
    mov lastCmp, 90
    cmp ax, 90
    jae GRADE_A
    mov lastCmp, 80
    cmp ax, 80
    jae GRADE_B
    mov lastCmp, 70
    cmp ax, 70
    jae GRADE_C
    mov lastCmp, 60
    cmp ax, 60
    jae GRADE_D
    jmp GRADE_F

GRADE_A:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'A'
    mov ah, 02h
    int 21h
    jmp SHOW_LAST

GRADE_B:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'B'
    mov ah, 02h
    int 21h
    jmp SHOW_LAST

GRADE_C:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'C'
    mov ah, 02h
    int 21h
    jmp SHOW_LAST

GRADE_D:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'D'
    mov ah, 02h
    int 21h
    jmp SHOW_LAST

GRADE_F:
    mov dx, OFFSET msgGrade
    mov ah, 09h
    int 21h
    mov dl, 'F'
    mov ah, 02h
    int 21h

SHOW_LAST:
    mov dx, OFFSET msgLast
    mov ah, 09h
    int 21h
    mov ax, lastCmp
    call PrintDecimalAX

    ; newline and exit
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    mov ah, 4Ch
    int 21h
MAIN ENDP

; Print AX as unsigned decimal
PrintDecimalAX PROC
    push ax
    push bx
    push cx
    push dx
    mov bx, 10
    xor cx, cx
    cmp ax, 0
    jne pd_loop
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp short pd_done
pd_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne pd_loop
pd_print:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop pd_print
pd_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintDecimalAX ENDP

END MAIN