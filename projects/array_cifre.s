.GLOBAL _main
.DATA

array:          .ASCII "00000000"
index:          .BYTE 0

.TEXT
// Prints the array
stampa:         PUSH %ECX
                PUSH %AX
                XOR %ECX, %ECX

stampa_loop:
                CMPB index, %CL
                JNE stampa_curr

                MOV $'(', %AL
                CALL outchar
stampa_curr:
                MOV array(%ECX), %AL
                CALL outchar

                CMPB index, %CL
                JNE new_iter

                MOV $')', %AL
                CALL outchar
new_iter:       
                INC %ECX
                CMP $8, %ECX
                JNE stampa_loop

                POP %AX
                POP %ECX
                RET
    
// Input AL, INC index if AL == a and index != 7
inc_index:      
                CMP $'a', %AL
                JNE end_inc

                CMPB $7, index
                JE end_inc

                INC index
                MOVB $1, %DL
end_inc:        RET

// Input: AL, DEC index if AL == d and index != 0
dec_index:      
                CMP $'d', %AL
                JNE end_dec

                CMPB $0, index
                JE end_dec
                
                DEC index
                MOVB $1, %DL
end_dec:        RET

// Input: AL, sets array(index) to AL if 0 <= AL <= 9. IF SO dl IS SET TO 1
set_index:      PUSH %EBX
                PUSH %ECX
                CMP $'0', %AL
                JB end_set
                CMP $'9', %AL
                JA end_set

                XOR %ECX, %ECX
                MOVB index, %CL
                LEA array, %EBX
                MOVB %AL, (%EBX, %ECX, 1)

                MOVB $1, %DL
end_set:        POP %ECX
                POP %EBX
                RET

// Sums all the digits: output in AL
sum:            PUSH %ECX
                XOR %ECX, %ECX
                XOR %AL, %AL
sum_loop:       SUB $'0', array(%ECX)
                ADD array(%ECX), %AL
                ADD $'0', array(%ECX)
                INC %ECX
                CMP $8, %ECX
                JNE sum_loop

                POP %ECX
                RET

// Entry point
_main:          NOP

main_loop:      CALL stampa
                CALL newline
input:
                CALL inchar

                XOR %DL, %DL
                CALL inc_index
                CALL dec_index
                CALL set_index

                CMP $'s', %AL
                JE end_main

                CMP $1, %DL
                JNE input
                JMP main_loop
end_main:
                CALL sum
                CALL outdecimal_byte
                CALL newline
                RET


.INCLUDE "./files/utility.s"
