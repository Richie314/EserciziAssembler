.DATA
matrix:         .FILL 16, 1, 0
index:            .BYTE 0
.TEXT

_main:          NOP
                CALL inchar
                CMP $'\r', %AL
                JE punto_4
                CMP $'a', %AL
                JB _main
                CMP $'d', %AL
                JA _main
                CALL outchar

                SUB $'a', %AL
                MOV %AL, index

                CALL inchar
                CMP $'\r', %AL
                JE punto_4
                CMP $'0', %AL
                JB _main
                CMP $'3', %AL
                JA _main
                CALL outchar

                SUB $'0', %AL
                ADD index, %AL
                MOV %AL, index
punto_3:        MOV $matrix, %EBX
                ADD index, %EBX
                INC (%EBX)

                CALL print_matrix
                JMP _main

punto_4:        CALL newline



                RET


print_matrix:   NOP
                PUSH %EAX
                PUSH %ECX
                MOV $15, %ECX
loop:           MOV $matrix, %EBX
                ADD %ECX, %EBX
                MOV (%EBX), %AL
                ADD $'0', %AL
                CALL outchar

                MOV %ECX, %EAX
                AND $0x00000003, %EAX
                JNZ no_new_line
                CALL newline
no_new_line:    LOOP loop
                POP %ECX
                POP %EAX
                CALL newline
                RET

.INCLUDE "./files/utility.s"
