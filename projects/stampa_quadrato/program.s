.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA



.TEXT

_main:
                    NOP
step_1:
                    XOR %EAX, %EAX
                    XOR %EBX, %EBX
                    XOR %ECX, %ECX
                    XOR %EDX, %EDX

                    CALL indecimal_byte
                    CALL newline

                    MOV %AL, %BL

                    CALL indecimal_byte
                    CALL newline
                    XCHG %AL, %BL
step_2:             
                    # Base
                    CMP $2, %AL
                    JB end
                    CMP $20, %AL
                    JA end
                    
                    # Height
                    CMP $2, %BL
                    JB end
                    CMP $20, %BL
                    JA end
step_3:
                    CALL newline
                    CALL newline

                    MOV %AL, %DL
                    CMP %BL, %DL
                    JAE outline_zero

                    MOV $'0', %AL
                    MOV $'1', %AH
                    JMP print_rect
outline_zero:       
                    MOV $'0', %AH
                    MOV $'1', %AL


print_rect:        
                    SUB $2, %EDX
                    SUB $2, %EBX

################## First row #############################
                    CALL outchar
                    MOV %EDX, %ECX
                    CMP $0, %ECX
                    JE first_row_end
print_first_row:
                    CALL outchar
                    LOOP print_first_row
first_row_end:
                    CALL outchar
                    CALL newline


##################     Body   #############################
                    CMP $0, %EBX
                    JE last_row_start
                    MOV %EBX, %ECX
print_rect_row:
                    PUSH %ECX
                    CALL outchar # Opening Border
                    XCHG %AL, %AH
                    MOV %EDX, %ECX
                    CMP $0, %ECX
                    JE print_body_row_end
print_body_char:    
                    CALL outchar
                    LOOP print_body_char
print_body_row_end:      
                    XCHG %AL, %AH
                    CALL outchar # Closing Border
                    CALL newline
                    POP %ECX    
                    LOOP print_rect_row


################## Final row #############################
last_row_start:
                    MOV %EDX, %ECX
                    CALL outchar
                    CMP $0, %ECX
                    JE last_row_end
print_last_row:
                    CALL outchar
                    LOOP print_last_row
last_row_end:
                    CALL outchar
                    CALL newline

step_4:
                    CALL newline
                    JMP step_1
end:                
                    XOR %EAX, %EAX
                    RET
