
;.Calculate the physical address for CS = 4000H, IP = 0500H.
.MODEL SMALL
.STACK 100h
.DATA
    csVal   dw  4000h
    ipVal   dw  0500h
    prefix  db  "Physical Address (CS=4000h, IP=0500h) = 0x", '$'
    newline db  13,10, '$'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Print prefix
    mov ah, 09h
    mov dx, OFFSET prefix
    int 21h

    ; Compute physical address: DX:AX = (CS << 4) + IP
    xor dx, dx
    mov ax, csVal
    mov cl, 4
shift_left:
    shl ax, 1
    rcl dx, 1
    dec cl
    jnz shift_left

    add ax, ipVal
    adc dx, 0

    ; Convert DX:AX (20-bit) to 5 hex digits by repeated division by 16
    mov bx, 16
    mov cx, 5
push_digits:
    div bx            ; 32-bit DX:AX divided by 16 -> AX=quotient, DX=remainder (0..15)
    push dx           ; store remainder on stack
    xor dx, dx        ; clear DX for next iteration
    dec cx
    jnz push_digits

    ; Pop and print digits (most significant first)
    mov cx, 5
print_digits:
    pop dx
    mov al, dl        ; remainder in DL
    call PrintHexNibble
    loop print_digits

    ; New line
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
MAIN ENDP

; Print a single hex nibble in AL (0..15)
PrintHexNibble PROC
    cmp al, 9
    jbe short digit
    add al, 7         ; 10..15 -> 'A'..'F' after adding '0'
digit:
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    ret
PrintHexNibble ENDP

END MAIN

