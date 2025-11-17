.MODEL SMALL
.STACK 100H
.DATA
    msg1 DB 'Enter a decimal number (0-255): $'
    msg2 DB 0DH,0AH,'Binary: $'
    msg3 DB 0DH,0AH,'Octal : $'
    msg4 DB 0DH,0AH,'Hexadecimal: $'
    num  DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display message 1
    LEA DX, msg1
    MOV AH, 9
    INT 21H

    ; Read number from user (ASCII)
    MOV AH, 1
    INT 21H
    SUB AL, 30H     ; Convert ASCII to decimal
    MOV num, AL

    ;------------------------
    ; Display Binary
    ;------------------------
    LEA DX, msg2
    MOV AH, 9
    INT 21H

    MOV AL, num
    MOV CX, 8        ; 8 bits
BIN_LOOP:
    ROL AL, 1        ; Rotate left through carry
    JC PRINT_ONE
    MOV DL, '0'
    JMP PRINT_BIN
PRINT_ONE:
    MOV DL, '1'
PRINT_BIN:
    MOV AH, 2
    INT 21H
    LOOP BIN_LOOP

    ;------------------------
    ; Display Octal
    ;------------------------
    LEA DX, msg3
    MOV AH, 9
    INT 21H

    MOV AL, num
    MOV BL, 8
    XOR CX, CX

OCT_LOOP:
    XOR AH, AH
    DIV BL
    PUSH AX
    INC CX
    CMP AL, 0
    JNE OCT_LOOP

PRINT_OCT:
    POP AX
    ADD AH, 30H
    MOV DL, AH
    MOV AH, 2
    INT 21H
    LOOP PRINT_OCT

    ;------------------------
    ; Display Hexadecimal
    ;------------------------
    LEA DX, msg4
    MOV AH, 9
    INT 21H

    MOV AL, num
    MOV AH, 0
    MOV BL, 16
    XOR CX, CX

HEX_LOOP:
    DIV BL
    PUSH AX
    INC CX
    CMP AL, 0
    JNE HEX_LOOP

PRINT_HEX:
    POP AX
    CMP AH, 9
    JG HEX_LETTER
    ADD AH, 30H
    JMP PRINT_HEX_CHAR
HEX_LETTER:
    ADD AH, 37H   ; Convert to A-F
PRINT_HEX_CHAR:
    MOV DL, AH
    MOV AH, 2
    INT 21H
    LOOP PRINT_HEX

    ;------------------------
    ; End Program
    ;------------------------
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
