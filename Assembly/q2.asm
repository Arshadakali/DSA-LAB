.MODEL SMALL
.STACK 100h
.DATA
    prompt     db 'Enter marks (up to 2 chars, e.g., 7A): $'
    msgInput   db 0Dh,0Ah,'You entered: ', '$'
    msgValid   db 0Dh,0Ah,'Valid numeric input. Marks = ', '$'
    msgInvalid db 0Dh,0Ah,'Invalid digit detected. Marks defaulted to ', '$'
    newline    db 0Dh,0Ah,'$'

    ; Buffered input: max=2, len=0, buffer=3 bytes
    MARKSBUF   db 2, 0, 3 dup(0)

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Prompt and read
    mov dx, OFFSET prompt
    mov ah, 09h
    int 21h

    mov dx, OFFSET MARKSBUF
    mov ah, 0Ah
    int 21h

    ; Terminate input with '$' to show raw string
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

    ; Validate and convert
    mov si, OFFSET MARKSBUF
    add si, 2
    mov cl, [MARKSBUF+1]
    xor ch, ch
    mov di, 0              ; accumulator for numeric value

VAL_LOOP:
    cmp cl, 0
    je VAL_DONE
    mov al, [si]
    cmp al, '0'
    jb SET_DEFAULT
    cmp al, '9'
    ja SET_DEFAULT
    ; digit: di = di*10 + (al-'0')
    sub al, '0'
    xor ah, ah            ; AX = digit
    mov dx, ax            ; DX = digit
    mov ax, di            ; AX = accumulator
    mov bx, 10
    mul bx                ; DX:AX = di * 10
    add ax, dx            ; AX += digit
    mov di, ax
    inc si
    dec cl
    jmp VAL_LOOP

VAL_DONE:
    ; Valid path: print numeric value
    mov dx, OFFSET msgValid
    mov ah, 09h
    int 21h
    mov ax, di
    call PrintDecimalAX
    jmp EXIT

SET_DEFAULT:
    mov dx, OFFSET msgInvalid
    mov ah, 09h
    int 21h
    xor ax, ax
    call PrintDecimalAX
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