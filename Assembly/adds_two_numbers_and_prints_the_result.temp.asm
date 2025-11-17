.MODEL SMALL
.STACK 100H
.DATA
num1 DW 4 ; First number
num2 DW 5 ; Second number
result DW ? ; Variable for storing result

msg DB 'Result: $' ; Message for display
.CODE
MAIN PROC
MOV AX, @DATA
MOV DS, AX
MOV AX, num1 ; Load num1 into AX
ADD AX, num2 ; Add num2 to AX
MOV result, AX ; Store result

; Print message
MOV DX, OFFSET msg
MOV AH, 9
INT 21H
; Convert result to ASCII and print
MOV AX, result
CALL PRINT_NUMBER
MOV AH, 4CH ; DOS function to exit
INT 21H ; Exit program
MAIN ENDP
PRINT_NUMBER PROC
; Convert and print AX value as decimal
MOV CX, 0
MOV DX, 0
MOV BX, 10
NEXT_DIGIT:
DIV BX
PUSH DX
INC CX

CMP AX, 0
JNE NEXT_DIGIT
PRINT_LOOP:
POP DX
ADD DL, '0'
MOV AH, 2
INT 21H
LOOP PRINT_LOOP
RET
PRINT_NUMBER ENDP
END MAIN