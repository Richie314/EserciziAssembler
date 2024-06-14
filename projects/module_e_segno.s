

.DATA
sgn_message:        .ASCII "Inserisci un segno (+/-): "
mod_message:        .ASCII "Inserisci un modulo [0, 255]: "
overflow_msg:       .ASCII "overflow"

sgn:                .BYTE '+'
mod:                .WORD 0
curr_sgn:           .BYTE 0
curr_module:        .BYTE 0

.TEXT

change_sign:        
                    MOV mod, %AX
                    NEG %AX
                    MOV %AX, mod
                    MOV sgn, %AL
                    CMP $'+', %AL
                    JE _set_sign_neg
                    MOV $'+', %AL
                    MOV %AL, sgn
                    RET
_set_sign_neg:      MOV $'-', %AL
                    MOV %AL, sgn
                    RET

_main:              NOP
loop:               LEA sgn_message, %EBX
                    MOV $26, %ECX
                    CALL outmess
in_sgn:             CALL inchar
                    CMP $'+', %AL
                    JE print_sgn
                    CMP $'-', %AL
                    JE print_sgn
                    JMP in_sgn
print_sgn:          CALL outchar
                    MOV %AL, curr_sgn
                    CALL newline

                    LEA mod_message, %EBX
                    MOV $30, %ECX
                    CALL outmess
                    CALL indecimal_byte
                    MOV %AL, curr_module
                    CALL newline

                    MOV curr_sgn, %DL
                    CMP sgn, %DL
                    XOR %AX, %AX
                    MOV curr_module, %AL
                    JE add_number
                    JNE sub_number

add_number:         ADD %AX, mod
                    JMP print_nuber

sub_number:         SUB %AX, mod


print_nuber:        CMP $0, mod
                    JL invert_sign
                    JMP other_checks
invert_sign:        CALL change_sign

other_checks:       CMP $512, mod
                    JBE overflow
                    
                    MOV sgn, %AL
                    CALL outchar
                    MOV mod, %AX
                    CALL outdecimal_short
                    CALL newline

                    JMP loop
overflow:           LEA overflow_msg, %EBX
                    MOV $8, %ECX
                    CALL outmess
                    CALL newline
                    RET

.INCLUDE "./files/utility.s"
