.MODEL SMALL
.STACK 100H
.DATA
    msg DB 'Hello, World!$'  ; Define message with $ as terminator
.CODE
MAIN PROC
    MOV AX, @DATA           ; Load data segment address
    MOV DS, AX              ; Initialize DS register
    MOV DX, OFFSET msg      ; Load message address into DX
    MOV AH, 09H             ; DOS function to print string
    INT 21H                 ; Call DOS interrupt to display message
    MOV AH, 4CH             ; DOS function to exit program
    INT 21H                 ; Call DOS interrupt to exit
MAIN ENDP
END MAIN