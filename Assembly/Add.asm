.MODEL SMALL
.STACK 100H

.DATA
    num1 DB 5
    num2 DB  3
    msg  DB 'Sum: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, num1     ; Load first number
    ADD AL, num2     ; Add second number

    MOV BL, AL       ; Save sum in BL

    ; Display messageg
    MOV AH, 09H
    MOV DX, OFFSET msg
    INT 21H

    ; Check if sum < 10 (single digit)
    CMP BL, 10
    JL single_digit

    ; For sums >= 10 (two digits), convert and display two digits

    MOV AX, 0
    MOV AL, BL
    MOV BL, 10
    DIV BL          ; AL = tens digit, AH = units digit

    ADD AL, 30H     ; convert tens digit to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ADD AH, 30H     ; convert units digit to ASCII
    MOV DL, AH
    MOV AH, 02H
    INT 21H
    JMP done

single_digit:
    ADD BL, 30H     ; convert single digit to ASCII
    MOV DL, BL
    MOV AH, 02H
    INT 21H

done:
    MOV AH, 4CH     ; exit
    INT 21H

MAIN ENDP
END MAIN