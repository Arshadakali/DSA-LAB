;. Question 2: Base conversions
;. Write code that converts:
;.  - binary to decimal
;.  - octal to decimal
;.  - hexadecimal to decimal

.MODEL SMALL
.STACK 100h
.DATA
    menuMsg   db 'Select conversion:',0Dh,0Ah
              db '1) Binary to decimal',0Dh,0Ah
              db '2) Octal to decimal',0Dh,0Ah
              db '3) Hexadecimal to decimal',0Dh,0Ah
              db 'Choice (1-3): $'
    enterMsg  db 0Dh,0Ah,'Enter the number: $'
    resultMsg db 0Dh,0Ah,'Decimal = ', '$'
    invalidMsg db 0Dh,0Ah,'Invalid input for selected base.$'
    overflowMsg db 0Dh,0Ah,'Overflow: value exceeds 65535 (16-bit).',0Dh,0Ah,'$'
    newline   db 0Dh,0Ah,'$'

    ; Buffered input (INT 21h AH=0Ah)
    inputBuf  db 32       ; max length
              db 0        ; actual length after input
              db 32 dup(0)

    convError db 0        ; 0 = ok, 1 = invalid, 2 = overflow

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Show menu
    mov ah, 09h
    mov dx, OFFSET menuMsg
    int 21h

    ; Read choice
    mov ah, 01h
    int 21h          ; AL has keystroke '1'..'3'
    mov bl, 16       ; default base = 16
    cmp al, '1'
    jne check2
    mov bl, 2
    jmp short afterChoice
check2:
    cmp al, '2'
    jne check3
    mov bl, 8
    jmp short afterChoice
check3:
    cmp al, '3'
    jne afterChoice
    mov bl, 16
afterChoice:
    ; newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

    ; Prompt for number
    mov ah, 09h
    mov dx, OFFSET enterMsg
    int 21h

    ; Prepare buffer: DS:DX points to inputBuf for AH=0Ah
    mov dx, OFFSET inputBuf
    mov ah, 0Ah
    int 21h          ; buffered keyboard input

    ; Convert per selected base in BL
    mov convError, 0
    xor ax, ax       ; accumulator (result)
    xor dx, dx
    mov bh, 0
    mov si, 0
    mov cl, [inputBuf+1]   ; actual length
    mov ch, 0
    ; BX already holds base (BL=base, BH=0)

convert_loop:
    cmp si, cx
    jae conversion_done

    mov al, [inputBuf+2+si]
    ; skip spaces and tabs
    cmp al, ' '
    je skip_char
    cmp al, 9
    je skip_char

    ; Determine digit value in AL
    cmp al, '0'
    jb invalid_digit
    cmp al, '9'
    jbe is_digit
    cmp al, 'A'
    jb check_lower
    cmp al, 'F'
    jbe is_hex_upper
check_lower:
    cmp al, 'a'
    jb invalid_digit
    cmp al, 'f'
    jbe is_hex_lower
    jmp invalid_digit

is_digit:
    sub al, '0'
    jmp short validate_base

is_hex_upper:
    sub al, 'A'
    add al, 10
    jmp short validate_base

is_hex_lower:
    sub al, 'a'
    add al, 10

validate_base:
    cmp al, bl        ; value < base ?
    jae invalid_digit

    ; AX = AX * base + value
    mov dx, 0
    mul bx            ; DX:AX = AX * base
    cmp dx, 0
    jne overflow_err
    ; add digit (AL) to AX using 16-bit register to avoid size mismatch
    mov dl, al
    xor dh, dh
    add ax, dx
    jc overflow_err
    jmp short next_char

skip_char:
    ; ignore whitespace
    ; do not alter AX
    jmp short next_char

invalid_digit:
    mov convError, 1
    jmp short next_char

overflow_err:
    mov convError, 2
    jmp short next_char

next_char:
    inc si
    jmp convert_loop

conversion_done:
    ; Check for errors
    mov al, convError
    cmp al, 1
    jne not_invalid
    mov ah, 09h
    mov dx, OFFSET invalidMsg
    int 21h
    jmp short program_exit
not_invalid:
    cmp al, 2
    jne print_result
    mov ah, 09h
    mov dx, OFFSET overflowMsg
    int 21h
    jmp short program_exit

print_result:
    ; Print prefix
    mov ah, 09h
    mov dx, OFFSET resultMsg
    int 21h
    ; Print decimal AX
    push ax
    call PrintDecimal
    ; newline
    mov ah, 09h
    mov dx, OFFSET newline
    int 21h

program_exit:
    mov ah, 4Ch
    int 21h
MAIN ENDP

; Print AX as unsigned decimal
PrintDecimal PROC
    push ax
    push bx
    push cx
    push dx
    mov bx, 10
    xor cx, cx

    ; Handle zero
    cmp ax, 0
    jne pd_loop
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp short pd_done

pd_loop:
    ; Repeatedly divide by 10, push remainders
    xor dx, dx
    div bx            ; AX = AX/10, DX = remainder (0..9)
    push dx
    inc cx
    cmp ax, 0
    jne pd_loop

    ; Print digits by popping
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
PrintDecimal ENDP

END MAIN