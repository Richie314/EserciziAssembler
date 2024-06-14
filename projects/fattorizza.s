
.DATA
A:                  .WORD 0

.TEXT
fattorizza:         # in ax
                    # CALL outdecimal_short
                    # CALL newline
                    CMP $1, %AX
                    JBE end_fatt
                    MOV $2, %BX
                    
                    MOV $0, %CL
try_div:            XOR %DX, %DX
                    MOV %AX, A
                    DIV %BX
                    CMP $0, %DX
                    JE increment_cl # resto e' 0
                    MOV A, %AX # resto non e' 0
                    CMP $0, %CL
                    JE next_number
print_number:       PUSH %AX
                    MOV %BX, %AX
                    CALL outdecimal_short
                    MOV $'^', %AL
                    CALL outchar
                    MOV %CL, %AL
                    CALL outdecimal_byte
                    CALL newline
                    POP %AX
                    JMP recursive_call
increment_cl:       INC %CL
                    JMP try_div
next_number:        INC %BX
                    CMP %BX, %AX
                    JB end_fatt
                    MOV $0, %CL
                    JMP try_div
recursive_call:     CALL fattorizza
end_fatt:           RET

_main:              NOP
                    MOV $'?', %AL
                    CALL outchar
                    CALL indecimal_short
                    CALL newline
                    CMP $1, %AX
                    JBE end_main
                    CALL fattorizza
                    CALL newline
                    CALL _main
end_main:           RET

.INCLUDE "./files/utility.s"
