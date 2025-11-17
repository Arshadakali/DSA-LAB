.MODEL SMALL
.STACK 100H

.DATA
    ; Array of numbers to sum
    array DB 2, 3, 4, 5, 6          ; Sample array: [2, 3, 4, 5, 6]
    array_size DB 5                  ; Number of elements in array
    sum_result DW 0                  ; Variable to store the sum
    
    ; Messages for output
    msg1 DB 'Array Elements: $'
    msg2 DB 'Sum of Array Elements = $'
    newline DB 0DH, 0AH, '$'        ; Carriage return and line feed
    space DB ' $'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display array elements
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    
    CALL DISPLAY_ARRAY
    
    ; Display newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    ; Calculate sum of array elements
    CALL CALCULATE_SUM
    
    ; Display result message
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    
    ; Display the sum
    MOV AX, sum_result
    CALL DISPLAY_NUMBER
    
    ; Display newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Procedure to calculate sum of array elements
CALCULATE_SUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    
    ; Initialize registers
    MOV SI, OFFSET array        ; SI points to first element of array
    MOV CL, array_size          ; CX holds number of elements
    MOV CH, 0                   ; Clear upper byte of CX
    MOV AX, 0                   ; AX will accumulate the sum
    
SUM_LOOP:
    MOV BL, [SI]                ; Load current array element into BL
    MOV BH, 0                   ; Clear upper byte of BX
    ADD AX, BX                  ; Add current element to sum
    INC SI                      ; Move to next array element
    LOOP SUM_LOOP               ; Decrement CX and loop if not zero
    
    MOV sum_result, AX          ; Store final sum
    
    POP SI
    POP CX
    POP BX
    POP AX
    RET
CALCULATE_SUM ENDP

; Procedure to display array elements (FIXED VERSION)
DISPLAY_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    
    MOV SI, OFFSET array        ; SI points to first element
    MOV CL, array_size          ; CX holds number of elements
    MOV CH, 0
    
DISPLAY_LOOP:
    MOV AL, [SI]                ; Load current element
    MOV AH, 0                   ; Clear upper byte
    CALL DISPLAY_NUMBER         ; Display the number
    
    INC SI                      ; Move to next element
    CMP CX, 1                   ; Check if this is the last element
    JE NO_SPACE                 ; If yes, skip space
    LEA DX, space               ; Otherwise, display space
    MOV AH, 09H
    INT 21H
NO_SPACE:
    LOOP DISPLAY_LOOP           ; Decrement CX and loop if not zero
    
    POP SI
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_ARRAY ENDP

; Procedure to display a number (0-255)
DISPLAY_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX, 10                  ; Divisor for decimal conversion
    MOV CX, 0                   ; Counter for digits
    
    ; Handle special case of zero
    CMP AX, 0
    JNE CONVERT_LOOP
    PUSH 30H                    ; ASCII '0'
    INC CX
    JMP DISPLAY_DIGITS
    
CONVERT_LOOP:
    MOV DX, 0                   ; Clear DX for division
    DIV BX                      ; AX = AX/10, DX = remainder
    ADD DL, 30H                 ; Convert remainder to ASCII
    PUSH DX                     ; Push digit onto stack
    INC CX                      ; Increment digit counter
    CMP AX, 0                   ; Check if quotient is zero
    JNE CONVERT_LOOP            ; Continue if not zero
    
DISPLAY_DIGITS:
    POP DX                      ; Pop digit from stack
    MOV AH, 02H                 ; Display character function
    INT 21H                     ; Display digit
    LOOP DISPLAY_DIGITS         ; Continue for all digits
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_NUMBER ENDP

END MAIN