section .data
    prompt1 db 'Enter student name: $'
    prompt2 db 'Enter marks (0-100): $'
    result_msg db 'Student Record:', 0Dh, 0Ah
               db 'Name: $'
    marks_msg db 0Dh, 0Ah, 'Marks: $'
    grade_msg db 0Dh, 0Ah, 'Grade: $'
    newline db 0Dh, 0Ah, '$'
    
    name resb 21
    marksbuf resb 4
    marks db 0
    grade db 0

section .text
    global _start

_start:
    ; Display name prompt
    mov ah, 09h
    mov dx, prompt1
    int 21h
    
    ; Read student name
    mov ah, 0Ah
    mov dx, name
    mov byte [name], 20
    int 21h
    
    ; Display marks prompt
    mov ah, 09h
    mov dx, prompt2
    int 21h
    
    ; Read marks
    mov ah, 0Ah
    mov dx, marksbuf
    mov byte [marksbuf], 3
    int 21h
    
    ; Convert ASCII marks to numeric
    mov si, marksbuf + 2
    mov cl, [marksbuf + 1]
    mov al, 0
    mov bl, 10
    
convert_marks:
    cmp cl, 0
    je done_convert
    mov dl, [si]
    sub dl, '0'
    inc si
    mov ah, 0
    mul bl
    add al, dl
    dec cl
    jmp convert_marks
    
done_convert:
    mov [marks], al
    
    ; Determine grade
    cmp al, 90
    jae grade_a
    cmp al, 80
    jae grade_b
    cmp al, 70
    jae grade_c
    cmp al, 60
    jae grade_d
    mov byte [grade], 'F'
    jmp display_result
    
grade_a:
    mov byte [grade], 'A'
    jmp display_result
    
grade_b:
    mov byte [grade], 'B'
    jmp display_result
    
grade_c:
    mov byte [grade], 'C'
    jmp display_result
    
grade_d:
    mov byte [grade], 'D'
    
display_result:
    ; Display result header
    mov ah, 09h
    mov dx, result_msg
    int 21h
    
    ; Display name
    mov ah, 09h
    mov dx, name + 2
    int 21h
    
    ; Display marks
    mov ah, 09h
    mov dx, marks_msg
    int 21h
    
    ; Convert and display numeric marks
    mov al, [marks]
    call display_number
    
    ; Display grade
    mov ah, 09h
    mov dx, grade_msg
    int 21h
    
    mov ah, 02h
    mov dl, [grade]
    int 21h
    
    ; Display newline
    mov ah, 09h
    mov dx, newline
    int 21h
    
    ; Exit program
    mov ah, 4Ch
    int 21h

display_number:
    ; Convert number in AL to ASCII and display
    mov ah, 0
    mov bl, 10
    div bl
    
    ; Display tens digit if not zero
    cmp al, 0
    je display_ones
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
display_ones:
    ; Display ones digit
    add ah, '0'
    mov dl, ah
    mov ah, 02h
    int 21h
    ret