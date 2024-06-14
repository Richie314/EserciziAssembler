.DATA
curr:               .WORD 1
curr_line:          .BYTE 1
.TEXT
_main:              NOP
                    CALL inchar
                    CMP $'0', %AL
                    JB _main
                    CMP $'9', %AL
                    JA _main
                    CALL outchar
                    CMP $'0', %AL
                    JE _end

                    MOV %AL, %DL
                    CALL newline
get_k:              CALL inchar
                    CMP $'0', %AL
                    JB get_k
                    CMP $'9', %AL
                    JA get_k
                    CALL outchar
                    MOV %AL, %BL
                    SUB $'0', %BL

loop:               CALL newline
                    CMP $'0', %DL
                    JE _restart
                    DEC %DL
print_line:         XOR %ECX, %ECX
                    MOV curr_line, %CL   
                    
print_number:       MOV curr, %AX
                    CALL outdecimal_short
                    MOV $' ', %AL
                    CALL outchar
                    ADD %Bl, curr
                    LOOP print_number
                    
                    INC curr_line
                    JMP loop
_restart:           CALL newline
                    JMP _main
_end:               CALL newline
                    RET


.INCLUDE "./files/utility.s"
