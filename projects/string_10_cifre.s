.GLOBAL _main
.INCLUDE "./files/utility.s" 
.DATA 
s:          .FILL 10, 1, 0
index:      .BYTE 0
.TEXT 


in_digit:   CALL inchar
            CMP $'0', %AL
            JB in_digit
            CMP $'9', %AL
            JA in_digit
            CALL outchar
            RET

out_line:   
            PUSH %EBX
            PUSH %CX

            LEA s, %EBX
            ADD index, %EBX
            MOV $10, %CX
            SUB index, %CX
            CALL outmess

            XOR %CX, %CX
            MOV index, %CL
            LEA s, %EBX
            CALL outmess

            CALL newline
            POP %CX
            POP %EBX
            RET

handle_q:   
            PUSH %AX
            MOV index, %AL
            INC %AL
            CMP $10, %AL
            JB handle_q_end
            SUB $9, %AL
handle_q_end:
            MOV %AL, index
            POP %AX
            RET

handle_w:   
            PUSH %AX
            MOV index, %AL
            TEST %AL, %AL
            JNZ handle_w_dec
            MOV $10, %AL
handle_w_dec:
            DEC %AL
handle_w_end:
            MOV %AL, index
            POP %AX
            RET

handle_e:   PUSH %ECX
            MOV $5, %ECX
handle_e_loop:
            CALL handle_w
            LOOP handle_e_loop
            POP %ECX
            RET

_main:      NOP
punto_1:    
            MOV $10, %ECX
            LEA s, %EDI
            CLD
in_loop:    CALL in_digit
            STOSB
            LOOP in_loop
            CALL newline
punto_2:    
            CALL inchar
            
            CMP $'z', %AL
            JE main_end

            CMP $'q', %AL
            JE do_q

            CMP $'w', %AL
            JE do_w

            CMP $'e', %AL
            JE do_e

            JMP punto_2

do_q:       CALL handle_q

            JMP print_n_jump
do_w:       CALL handle_w
            JMP print_n_jump
do_e:       CALL handle_e
print_n_jump:
            CALL out_line
            JMP punto_2
main_end:   RET
