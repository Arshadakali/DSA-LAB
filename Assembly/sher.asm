.MODEL SMALL
.STACK 100h

.DATA
msg1      DB 'Enter Student Name (Max 20 chars): $'
msg2      DB 0Dh,0Ah,'Enter Student Marks (0-100): $'
msg3      DB 0Dh,0Ah,'--- Student Record Summary ---$'
msg4      DB 0Dh,0Ah,'Name: $'
msg5      DB 0Dh,0Ah,'Marks: $'
msg6      DB 0Dh,0Ah,'Final Grade: $'

; Input buffer for DOS function 0Ah
; [0] = maximum chars
; [1] = actual chars entered (filled by DOS)
; [2...] = characters
NAMEBUF   DB 20, 0, 21 DUP(0)  ; Name input buffer (max 20 chars)
MARKSBUF  DB 3, 0, 4 DUP(0)    ; Marks input buffer (max 3 digits)
MARKS     DB 0                 ; Final numeric marks (0-100)
GRADE     DB 0                 ; Single character grade (A, B, C, D, F)

newline   DB 0Dh,0Ah,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; ----- Input Name -----
    MOV DX, OFFSET msg1
    MOV AH, 09h
    INT 21h

    MOV DX, OFFSET NAMEBUF   ; Load address of buffer
    MOV AH, 0Ah              ; Read buffered input
    INT 21h

    ; Append '$' terminator to the NAME for printing (AH=09h)
    MOV CL, [NAMEBUF+1]      ; CL = actual length entered
    XOR CH, CH               ; Clear CH
    
    ; SI points to the first character after the NAME length
    MOV SI, OFFSET NAMEBUF
    ADD SI, 2                ; SI points to the first character
    ADD SI, CX               ; SI now points to the first position after the entered name
    MOV BYTE PTR [SI], '$'   ; put '$' terminator

; ----- Input Marks -----
    MOV DX, OFFSET msg2
    MOV AH, 09h
    INT 21h

    MOV DX, OFFSET MARKSBUF  ; Load address of buffer
    MOV AH, 0Ah              ; Read buffered input
    INT 21h

; ----- Validate Marks Input -----
    MOV CL, [MARKSBUF+1]     ; CL = length of marks entered
    CMP CL, 0
    JE SET_DEFAULT_MARKS     ; If no input, set to 0
    MOV SI, OFFSET MARKSBUF
    ADD SI, 2                ; SI points to first digit
    MOV CH, 0                ; CH = counter for validation loop

VALIDATE_LOOP:
    MOV AL, [SI]
    CMP AL, '0'
    JB SET_DEFAULT_MARKS     ; Not a digit
    CMP AL, '9'
    JA SET_DEFAULT_MARKS     ; Not a digit
    INC SI
    INC CH
    CMP CH, CL
    JB VALIDATE_LOOP         ; Continue validating

; ----- Convert MARKS ASCII -> numeric -----
    MOV CL, [MARKSBUF+1]     ; CL = length of marks entered (loop count)
    XOR AL, AL               ; AL = final numeric marks (reset)
    MOV BL, 10               ; Base for multiplication
    MOV SI, OFFSET MARKSBUF
    ADD SI, 2                ; SI points to first digit

CONVERT_MARKS:
    CMP CL, 0                ; Check if we have processed all digits
    JE DONE_CONVERT          ; If no more digits, exit loop
    MOV DL, [SI]
    SUB DL, '0'              ; Convert ASCII digit to number
    INC SI
    MOV AH, 0
    MUL BL                   ; AX = AL * 10 (AH is zeroed by MOV AH, 0)
    ADD AL, DL               ; AL = AL + new digit
    DEC CL                   ; Decrement counter manually
    JMP CONVERT_MARKS        ; Jump back to loop
    
DONE_CONVERT:
    CMP AL, 100
    JA SET_DEFAULT_MARKS     ; If >100, invalid
    MOV MARKS, AL            ; Store final numeric marks
    JMP GRADE_PART

SET_DEFAULT_MARKS:
    MOV MARKS, 0             ; Set to 0 if invalid

GRADE_PART:
; ----- Determine GRADE -----
    MOV AL, MARKS
    
    CMP AL, 90
    JAE GRADE_A
    CMP AL, 80
    JAE GRADE_B
    CMP AL, 70
    JAE GRADE_C
    CMP AL, 60
    JAE GRADE_D
    
GRADE_F:
    MOV GRADE, 'F'
    JMP SHOW_RECORD

GRADE_A:
    MOV GRADE, 'A'
    JMP SHOW_RECORD
GRADE_B:
    MOV GRADE, 'B'
    JMP SHOW_RECORD
GRADE_C:
    MOV GRADE, 'C'
    JMP SHOW_RECORD
GRADE_D:
    MOV GRADE, 'D'

SHOW_RECORD:

; ----- Show record -----
    MOV DX, OFFSET msg3
    MOV AH, 09h
    INT 21h

    ; Print Name
    MOV DX, OFFSET msg4
    MOV AH, 09h
    INT 21h
    
    MOV DX, OFFSET NAMEBUF
    ADD DX, 2                ; DX points to the start of the NAME string
    MOV AH, 09h
    INT 21h

    ; Print MARKS
    MOV DX, OFFSET msg5
    MOV AH, 09h
    INT 21h
    MOV AL, MARKS
    CALL PRINT_NUM

    ; Print GRADE (Single character)
    MOV DX, OFFSET msg6
    MOV AH, 09h
    INT 21h
    
    MOV DL, GRADE            ; Load single character grade
    MOV AH, 02h              ; Use Display Character (02h)
    INT 21h                  

    ; newline
    MOV DX, OFFSET newline
    MOV AH, 09h
    INT 21h

; ----- Exit -----
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; ----- Procedure to Print an 8-bit Number (0..255) in AL -----
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX               ; CX is the digit counter
    MOV BL, 10               ; Divisor

PN_CONV:
    XOR AH, AH               
    DIV BL                   
    PUSH DX                  
    INC CX
    CMP AL, 0                
    JNE PN_CONV              

PN_PRINT:
    POP DX                   
    ADD DL, '0'              
    MOV AH, 02h              
    INT 21h
    LOOP PN_PRINT            

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN