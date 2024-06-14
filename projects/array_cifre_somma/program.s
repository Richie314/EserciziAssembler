.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA
array:          .FILL 8, 1, 0
.TEXT

# Takes the digit of AL and puts it in the array
set_digit:       
                PUSH %AX
                SUB $'0', %AL
                MOV %AL, array(%ECX)
                POP %AX
                RET
move_sx:
                DEC %ECX
                RET
move_dx:        
                INC %ECX
                RET
sum:            
                PUSH %ECX
                PUSH %AX
                XOR %AX, %AX
                MOV $7, %ECX
sum_loop:
                ADD array(%ECX), %AL
                LOOP sum_loop

                CALL outdecimal_byte

                POP %AX
                POP %ECX
                RET

out_arr:        
                PUSH %AX
                PUSH %EDX
                XOR %EDX, %EDX

print_loop:
                CMP %ECX, %EDX
                JNE print_curr_elem
                MOV $'(', %AL
                CALL outchar
print_curr_elem:
                MOV array(%EDX), %AL
                CALL outdecimal_byte

                CMP %ECX, %EDX
                JNE loop_return
                MOV $')', %AL
                CALL outchar

loop_return:
                INC %EDX
                CMP $8, %EDX
                JNE print_loop

                POP %EDX
                POP %AX
                RET
_main:
                NOP
                XOR %ECX, %ECX
step_1:
                CALL out_arr
                CALL newline
step_2:         
                CALL inchar
move_sx_call:
                CMP $'a', %AL
                JNE move_dx_call
                CMP $0, %ECX
                JE move_dx_call

                CALL move_sx
                JMP step_3
move_dx_call:
                CMP $'d', %AL
                JNE digit_call
                CMP $7, %ECX
                JE digit_call

                CALL move_dx
                JMP step_3
digit_call:     
                CMP $'0', %AL
                JB sum_call
                CMP $'9', %AL
                JA sum_call
                CALL set_digit
                JMP step_3
sum_call:       
                CMP $'s', %AL
                JNE step_2
                CALL sum
                # Exit
                XOR %EAX, %EAX
                RET
step_3:         JMP step_1
