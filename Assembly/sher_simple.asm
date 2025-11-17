; Simple Assembly program for Windows console
.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    prompt1 db "Enter student name: ", 0
    prompt2 db "Enter marks (0-100): ", 0
    result_msg db "Student Record:", 13, 10, "Name: ", 0
    marks_msg db 13, 10, "Marks: ", 0
    grade_msg db 13, 10, "Grade: ", 0
    newline db 13, 10, 0
    
    name_buffer db 50 dup(0)
    marks_buffer db 10 dup(0)
    grade_char db 0
    
.code
start:
    ; Display name prompt
    invoke StdOut, addr prompt1
    
    ; Read student name
    invoke StdIn, addr name_buffer, 49
    
    ; Display marks prompt
    invoke StdOut, addr prompt2
    
    ; Read marks
    invoke StdIn, addr marks_buffer, 9
    
    ; Convert marks string to number
    invoke atol, addr marks_buffer
    mov ebx, eax  ; Store marks in ebx
    
    ; Determine grade
    cmp ebx, 90
    jae grade_a
    cmp ebx, 80
    jae grade_b
    cmp ebx, 70
    jae grade_c
    cmp ebx, 60
    jae grade_d
    mov grade_char, 'F'
    jmp display_result
    
grade_a:
    mov grade_char, 'A'
    jmp display_result
    
grade_b:
    mov grade_char, 'B'
    jmp display_result
    
grade_c:
    mov grade_char, 'C'
    jmp display_result
    
grade_d:
    mov grade_char, 'D'
    
display_result:
    ; Display result header
    invoke StdOut, addr result_msg
    
    ; Display name
    invoke StdOut, addr name_buffer
    
    ; Display marks
    invoke StdOut, addr marks_msg
    invoke dwtoa, ebx, addr marks_buffer
    invoke StdOut, addr marks_buffer
    
    ; Display grade
    invoke StdOut, addr grade_msg
    invoke StdOut, addr grade_char
    
    ; Display newline
    invoke StdOut, addr newline
    
    ; Exit program
    invoke ExitProcess, 0

end start