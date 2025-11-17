.MODEL SMALL
.STACK 100H
.DATA
    msg1    DB 'Enter a decimal number (0-255): $'
    msg2    DB 0DH,0AH,'Binary     : $'
    msg3    DB 0DH,0AH,'Octal      : $'
    msg4    DB 0DH,0AH,'Hexadecimal: $'
    inbuf   DB 4, 0, 3 DUP(?)
    num     DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;----------------------------------------
    ; Display prompt
    ;----------------------------------------
    LEA DX, msg1
    MOV AH, 9
    INT 21H

    ;----------------------------------------
    ; Read decimal input (max 3 digits)
    ;----------------------------------------
    LEA DX, inbuf
    MOV AH, 0Ah
    INT 21H

    ;----------------------------------------
    ; Convert ASCII digits to numeric (0–255)
    ;----------------------------------------
    MOV CL, inbuf+1        ; number of characters entered
    CMP CL, 0
    JE CONV_ZERO

    XOR AL, AL             ; AL = 0
    MOV BL, 10
    LEA SI, inbuf+2

CONV_LOOP:
    MOV DL, [SI]
    SUB DL, '0'
    INC SI
    MOV AH, 0
    MUL BL                 ; AL = AL * 10
    ADD AL, DL
    DEC CL
    JNZ CONV_LOOP
    JMP CONV_DONE

CONV_ZERO:
    MOV AL, 0
CONV_DONE:
    MOV num, AL

    ;----------------------------------------
    ; Display Binary (robust version)
    ;----------------------------------------
    LEA DX, msg2
    MOV AH, 9
    INT 21H

    MOV AL, num
    XOR AH, AH
    MOV SI, AX             ; copy of value
    MOV CX, 8              ; 8 bits to print

BIN_COPY_LOOP:
    TEST SI, 0080h         ; check MSB (bit 7)
    JZ BIN_PRINT_ZERO4
    MOV DL, '1'
    JMP BIN_PRINT_CHAR4
BIN_PRINT_ZERO4:
    MOV DL, '0'
BIN_PRINT_CHAR4:
    MOV AH, 2
    INT 21h
    SHL SI, 1              ; shift left to next bit
    LOOP BIN_COPY_LOOP

    ;----------------------------------------
    ; Display Octal
    ;----------------------------------------
    LEA DX, msg3
    MOV AH, 9
    INT 21H

    MOV AL, num
    XOR AH, AH
    MOV BL, 8
    CMP AL, 0
    JNE OCT_LOOP_START
    MOV DL, '0'
    MOV AH, 2
    INT 21H
    JMP OCT_DONE

OCT_LOOP_START:
    XOR CX, CX

OCT_LOOP:
    XOR AH, AH
    DIV BL
    XOR DX, DX
    MOV DL, AH
    PUSH DX
    INC CX
    CMP AL, 0
    JNE OCT_LOOP

PRINT_OCT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_OCT_LOOP

OCT_DONE:

    ;----------------------------------------
    ; Display Hexadecimal
    ;----------------------------------------
    LEA DX, msg4
    MOV AH, 9
    INT 21H

    MOV AL, num
    XOR AH, AH
    MOV BL, 16
    CMP AL, 0
    JNE HEX_LOOP_START
    MOV DL, '0'
    MOV AH, 2
    INT 21H
    JMP HEX_DONE

HEX_LOOP_START:
    XOR CX, CX

HEX_LOOP:
    XOR AH, AH
    DIV BL
    XOR DX, DX
    MOV DL, AH
    PUSH DX
    INC CX
    CMP AL, 0
    JNE HEX_LOOP

PRINT_HEX_LOOP:
    POP DX
    CMP DL, 9
    JBE HEX_DIGIT_NUM
    ADD DL, 7              ; convert 10–15 -> A–F
HEX_DIGIT_NUM:
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_HEX_LOOP

HEX_DONE:

    ;----------------------------------------
    ; Exit program
    ;----------------------------------------
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN