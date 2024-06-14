.INCLUDE "./files/utility.s"
.DATA
array:      .FILL 10, 1, 0
.TEXT


// EBX: index to start from
print_array:    
                PUSH %ECX
                PUSH %AX
                PUSH %ESI
                
                LEA array(%EBX), %ESI
                MOV $10, %ECX
                SUB %EBX, %ECX
                CLD
print_first_part:
                LODSB
                CALL outchar
                LOOP print_first_part

                CMP $0, %EBX
                JE print_end

                LEA array, %ESI
                MOV %EBX, %ECX
print_second_part:
                LODSB
                CALL outchar
                LOOP print_second_part
print_end:
                POP %ESI
                POP %AX
                POP %ECX
                RET


// EBX: index to start from
print_reverse:    
                PUSH %ECX
                PUSH %AX
                PUSH %ESI
                
                STD
                CMP $0, %EBX
                JE rev_first_part_end

                LEA array(%EBX), %ESI
                MOV %EBX, %ECX
                DEC %ESI
rev_first_part:
                LODSB
                CALL outchar
                LOOP rev_first_part
rev_first_part_end:

                LEA array, %ESI
                ADD $9, %ESI
                MOV $10, %ECX
                SUB %EBX, %ECX
rev_second_part:
                LODSB
                CALL outchar
                LOOP rev_second_part

                POP %ESI
                POP %AX
                POP %ECX
                RET


left_shift:
                INC %EBX
                CMP $10, %EBX
                JNE left_shift_end
                XOR %EBX, %EBX
left_shift_end:
                RET



right_shift:
                CMP $0, %EBX
                JNE right_shift_end
                MOV $10, %EBX
right_shift_end:
                DEC %EBX
                RET



_main:          NOP
step_1:         
                MOV $10, %ECX
                LEA array, %EDI
                CLD
input_loop:
                CALL inchar
                
                CMP $'0', %AL
                JB input_loop
                CMP $'9', %AL
                JA input_loop
                
                CALL outchar
                STOSB
                LOOP input_loop
                CALL newline

                XOR %EBX, %EBX
                XOR %EDX, %EDX
step_2:         
                CALL inchar
step_3:         
                CMP $'q', %AL
                JE end
check_s:
                CMP $'s', %AL
                JNE check_d
                CMP $0, %EDX
                JE call_left
                JNE call_right
check_d:
                CMP $'d', %AL
                JNE check_r
                CALL right_shift
                JMP check_end
                CMP $0, %EDX
                JE call_right
                JNE call_left
check_r:
                CMP $'r', %AL
                JNE step_2
                NOT %EDX
                JMP check_end

call_right:
                CALL right_shift
                JMP check_end
call_left:
                CALL left_shift

check_end:      
                CMP $0, %EDX
                JNE print_reverse_call
                CALL print_array
                JMP printed
print_reverse_call:
                CALL print_reverse
printed:
                CALL newline
                JMP step_2
end:            
                XOR %EAX, %EAX
                RET
