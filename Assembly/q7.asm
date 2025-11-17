.MODEL SMALL
.STACK 100h
.DATA
    msgStart   db 'Tracing PRINT_NUM for MARKS = 84', 0Dh,0Ah, '$'
    msgRems    db 'Remainders pushed (order): ', '$'
    msgFirst   db 0Dh,0Ah, 'First character printed: ', '$'
    newline    db 0Dh,0Ah,'$'

    rems       db 10 dup(0)
    remCount   dw 0

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Announce
    mov dx, OFFSET msgStart
    mov ah, 09h
    int 21h

    ; Compute remainders by dividing by 10, pushing order
    mov ax, 84         ; MARKS = 84
    mov bx, 10
    mov si, OFFSET rems
    xor cx, cx

REM_LOOP:
    cmp ax, 0
    je REM_DONE
    xor dx, dx
    div bx            ; AX = AX/10, DX = remainder
    mov [si], dl      ; store remainder (push order)
    inc si
    inc cx
    jmp REM_LOOP

REM_DONE:
    mov remCount, cx

    ; Print remainders in stored order (should be 4, then 8)
    mov dx, OFFSET msgRems
    mov ah, 09h
    int 21h
    mov si, OFFSET rems
    mov cx, remCount
PRINT_REMS:
    cmp cx, 0
    je SHOW_FIRST
    mov al, [si]
    xor ah, ah
    call PrintDecimalAX
    ; space
    mov dl, ' '
    mov ah, 02h
    int 21h
    inc si
    dec cx
    jmp PRINT_REMS

SHOW_FIRST:
    ; First character printed by PN_PRINT is the last remainder (8)
    mov dx, OFFSET msgFirst
    mov ah, 09h
    int 21h
    ; load last stored remainder
    mov cx, remCount
    mov si, OFFSET rems
    add si, cx
    dec si
    mov al, [si]
    xor ah, ah
    ; Convert to ASCII digit char
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

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