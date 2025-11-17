g.MODEL SMALL
.STACK 100h
.DATA
    msgEnter  db 'Enter Student Name (Max 20 chars): $'
    msgLen    db 0Dh,0Ah,'Length = ', '$'
    msgStr    db 0Dh,0Ah,'String = ', '$'
    newline   db 0Dh,0Ah,'$'

    ; Buffered input for DOS 0Ah
    NAMEBUF   db 20, 0, 21 dup(0)

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Prompt for name
    mov dx, OFFSET msgEnter
    mov ah, 09h
    int 21h

    ; Read buffered input
    mov dx, OFFSET NAMEBUF
    mov ah, 0Ah
    int 21h

    ; SI = NAMEBUF + 2 + length, then store '$' terminator
    mov cl, [NAMEBUF+1]   ; length
    xor ch, ch
    mov si, OFFSET NAMEBUF
    add si, 2
    add si, cx            ; SI -> first pos after entered name
    mov BYTE PTR [si], '$'

    ; Print length
    mov dx, OFFSET msgLen
    mov ah, 09h
    int 21h
    mov al, [NAMEBUF+1]
    xor ah, ah            ; AX = length
    call PrintDecimalAX   ; prints AX in decimal

    ; Print resulting string (terminated by '$')
    mov dx, OFFSET msgStr
    mov ah, 09h
    int 21h
    mov dx, OFFSET NAMEBUF
    add dx, 2
    mov ah, 09h
    int 21h

    ; newline and exit
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
MAIN ENDP

; Print AX as unsigned decimal using 16-bit division by 10
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
    div bx            ; AX = AX/10, DX = remainder (0..9)
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