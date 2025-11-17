.MODEL SMALL
.STACK 100h
.DATA
    prompt     db 'Enter two-digit marks (e.g., 45): $'
    msgInput   db 0Dh,0Ah,'You entered: ', '$'
    msgAL      db 0Dh,0Ah,'AL before second ADD = ', '$'
    msgCL      db 0Dh,0Ah,'CL before second JMP = ', '$'
    msgFinal   db 0Dh,0Ah,'Final value = ', '$'
    newline    db 0Dh,0Ah,'$'

    BUF        db 2, 0, 3 dup(0)
    AL_before  dw 0
    CL_before  db 0
    iter       dw 0

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

    ; Convert with trace
    mov bl, 10
    xor ax, ax        ; AL = 0 accumulator
    mov si, OFFSET BUF
    add si, 2
    mov cl, [BUF+1]
    xor ch, ch
    mov iter, 0

LOOP_CONV:
    cmp cl, 0
    je DONE_CONV

    ; AL = AL * 10
    mul bl            ; 8-bit: AL*BL -> AX, AL=low product

    ; iter++
    inc WORD PTR iter
    mov dx, iter
    cmp dx, 2
    jne SKIP_AL_STORE
    ; Capture AL before second ADD
    xor ah, ah
    mov WORD PTR AL_before, ax
SKIP_AL_STORE:

    ; ADD AL, (digit)
    mov dl, [si]
    sub dl, '0'
    add al, dl

    inc si
    dec cl

    mov dx, iter
    cmp dx, 2
    jne SKIP_CL_STORE
    ; Capture CL before second JMP (after DEC CL)
    mov CL_before, cl
SKIP_CL_STORE:
    jmp LOOP_CONV

DONE_CONV:
    ; Print AL_before
    mov dx, OFFSET msgAL
    mov ah, 09h
    int 21h
    mov ax, AL_before
    call PrintDecimalAX

    ; Print CL_before
    mov dx, OFFSET msgCL
    mov ah, 09h
    int 21h
    xor ah, ah
    mov al, CL_before
    call PrintDecimalAX

    ; Print final value
    mov dx, OFFSET msgFinal
    mov ah, 09h
    int 21h
    xor ah, ah
    ; AL holds final value
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