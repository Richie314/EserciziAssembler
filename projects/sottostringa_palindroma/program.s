.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA
str:                    .FILL 30, 1, 0
rev_str:                .FILL 30, 1, 0
palindroma_str:         .ASCII "PALINDROMA\r"
non_palindroma_str:     .ASCII "NON PALINDROMA\r"
length:                 .LONG 0
.TEXT

_main:
                    NOP
step_1:             
                    MOV $30, %ECX
                    MOVL $0, length
                    LEA str, %EDI
                    CLD
input_loop:
                    CALL inchar
                    CMP $'\r', %AL
                    JE step_2
                    CALL outchar
                    STOSB

                    MOV length, %EAX
                    INC %EAX
                    MOV %EAX, length
                    
                    LOOP input_loop
step_2:
                    CALL newline
                    CALL indecimal_long
                    CALL newline
                    MOV %EAX, %EBX

                    CALL indecimal_long
                    CALL newline
                    XCHG %EAX, %EBX

step_3:
                    CMP length, %EAX
                    JAE program_end
                    CMP length, %EBX
                    JA program_end

                    SUB %EAX, %EBX
                    JZ program_end
                    # JS program_end
step_4:
                    # eax -> start
                    # ebx -> length
                    MOV %EBX, %ECX

                    LEA str, %ESI
                    ADD %EAX, %ESI

                    LEA rev_str, %EDI
                    ADD %EBX, %EDI
                    DEC %EDI
                    
                    PUSH %EAX
print_str_loop:
                    CLD
                    LODSB
                    STD
                    STOSB

                    CALL outchar
                    LOOP print_str_loop
                    CALL newline
                    POP %EAX
                    
                    LEA rev_str, %ESI

                    MOV %EBX, %ECX
                    MOV $1, %EDX
                    CLD
print_rev_loop:
                    LODSB
                    CALL outchar
                    DEC %ECX
                    MOV rev_str(%ECX), %AH
                    INC %ECX
                    CMP %AL, %AH
                    JE print_rev_continue
                    XOR %EDX, %EDX
print_rev_continue:
                    LOOP print_rev_loop
                    CALL newline
                    
                    CMP $0, %EDX
                    JE print_non_palindroma
                    LEA palindroma_str, %EBX 
                    JMP print_mess
print_non_palindroma:
                    LEA non_palindroma_str, %EBX
print_mess:
                    CALL outline
                    JMP step_2
program_end:
                    XOR %EAX, %EAX
                    RET
