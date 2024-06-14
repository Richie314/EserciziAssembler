.GLOBAL _main

.DATA
str:                .FILL 32, 1, 0
len:                .BYTE 0
a:                  .BYTE 0
b:                  .BYTE 0

.TEXT

// puntatore in EBX, lunghezza in DL
strlen:             PUSH %ESI
                    PUSH %ECX
                    PUSH %AX
                    MOV %EBX, %ESI
                    CLD
                    MOV $30, %ECX
strlen_loop:                    
                    LODSB
                    CMP $'\r', %AL
                    LOOPNE strlen_loop

                    MOV %CL, %DL
                    NEG %DL
                    ADD $30, %DL
                    CMP $'\r', %AL
                    JNE strlen_end
                    DEC %DL
strlen_end:
                    POP %AX
                    POP %ECX
                    POP %ESI
                    RET
in_str:             PUSH %ECX
                    PUSH %EBX
                    PUSH %EDX

                    MOV $32, %ECX
                    LEA str, %EBX
                    CALL inline

                    CALL strlen
                    MOVB %DL, len

                    POP %EDX
                    POP %EBX
                    POP %ECX
                    RET
print_sub_str:      PUSH %EBX
                    PUSH %ECX
                    
                    //MOV a, %CL
                    LEA str, %EBX
                    ADD a, %EBX
                    
                    XOR %ECX, %ECX
                    MOV b, %CL
                    SUB a, %CL
                    CALL outmess
                    
                    POP %ECX
                    POP %EBX
                    RET
_main:              NOP
                    CALL in_str
                    CMPB $0, len
                    JE main_ret

                    CALL indecimal_byte
                    MOVB %AL, a
                    CALL newline
                    CALL indecimal_byte
                    MOVB %AL, b
                    CALL newline

                    // b <= a
                    CMP a, %AL
                    JBE main_ret

                    // b > 30
                    CMP $30, %AL
                    JA main_ret

                    // a < 0
                    CMPB $0, a
                    JB main_ret

                    // 0 <= a < b <= 30
                    CALL print_sub_str
                    CALL newline
main_ret:
                    RET
.INCLUDE "./files/utility.s"
