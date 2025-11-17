.MODEL SMALL
.STACK 100H
.DATA
msg DB 'Hello World!$'

.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Print message
    LEA DX, msg
    MOV AH, 9
    INT 21H

    ; Exit program
    MOV AH, 4Ch
    INT 21H
MAIN ENDP

END AIN