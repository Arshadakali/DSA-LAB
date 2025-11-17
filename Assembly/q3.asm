.MODEL SMALL
.STACK 100h
.DATA
    prompt     db 'Enter a single-digit mark (e.g., 7): $'
    msgInput   db 0Dh,0Ah,'You entered: ', '$'
    msgResult  db 0Dh,0Ah,'Converted value = ', '$'
    msgMulCnt  db 0Dh,0Ah,'MUL executions = ', '$'
    msgInvalid db 0Dh,0Ah,'Invalid input. Please enter 0-9.', '$'
    newline    db 0Dh,0Ah,'$'

    MARKSBUF   db 2, 0, 3 dup(0)
    mulCount   dw 0

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Prompt and read one digit
    mov dx, OFFSET prompt
    mov ah, 09h
    int 21h

    mov dx, OFFSET MARKSBUF
    mov ah, 0Ah
    int 21h

    ; Terminate and echo input
    mov cl, [MARKSBUF+1]
    xor ch, ch
    mov si, OFFSET MARKSBUF
    add si, 2
    add si, cx
    mov BYTE PTR [si], '$'
    mov dx, OFFSET msgInput
    mov ah, 09h
    int 21h
    mov dx, OFFSET MARKSBUF
    add dx, 2
    mov ah, 09h
    int 21h

    ; Validate single-digit
    mov si, OFFSET MARKSBUF
    add si, 2
    mov al, [si]
    cmp al, '0'
    jb BAD
    cmp al, '9'
    ja BAD

    ; Convert using 8-bit logic: AL accumulates, BL=10, count MULs
    mov bl, 10
    xor ax, ax        ; AL=0
    mov cl, [MARKSBUF+1]
    xor ch, ch
    mov si, OFFSET MARKSBUF
    add si, 2

CONV_LOOP:
    cmp cl, 0
    je CONV_DONE
    mul bl            ; AL = AL * 10, AX holds product
    inc WORD PTR mulCount
    mov dl, [si]
    sub dl, '0'
    add al, dl
    inc si
    dec cl
    jmp CONV_LOOP

CONV_DONE:
    ; Print result value
    mov dx, OFFSET msgResult
    mov ah, 09h
    int 21h
    xor ah, ah
    call PrintDecimalAX

    ; Print MUL count (should be 1 for single digit)
    mov dx, OFFSET msgMulCnt
    mov ah, 09h
    int 21h
    mov ax, mulCount
    call PrintDecimalAX
    jmp EXIT

BAD:
    mov dx, OFFSET msgInvalid
    mov ah, 09h
    int 21h
    jmp EXIT

EXIT:
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