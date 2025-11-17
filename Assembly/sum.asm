.MODEL SMALL
.STACK 100H
.DATA
num1 DB 10 ; First number
num2 DB 5 ; Second number
result DB ? ; To store the sum
msg DB 'Sum: $' ; Message before result
.CODE
MAIN PROC
MOV AX, @DATA
MOV DS, AX
MOV AL, num1 ; Load first number
ADD AL, num2 ; Add second number
MOV result, AL ; Store sum
MOV DX, OFFSET msg
MOV AH, 09H
INT 21H ; Display "Sum: "
MOV AL, result
AAM ; Convert binary to ASCII (tens in AH, units in AL)
ADD AX, 3030H ; Convert to ASCII characters
MOV DL, AH ; Tens digit
MOV AH, 02H
INT 21H ; Print first digit
MOV DL, AL ; Units digit

INT 21H ; Print second digit
MOV AH, 4CH ; Exit program
INT 21H
MAIN ENDP
END MAIN