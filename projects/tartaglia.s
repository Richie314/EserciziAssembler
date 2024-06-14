.GLOBAL _main
.DATA
row:        .FILL 17, 2, 0
next_row:   .FILL 17, 2, 0

.TEXT
//Input: AL
tartaglia_next_row: 
            PUSH %ECX
            PUSH %AX
            PUSH %DX
            XOR %ECX, %ECX
next_row_loop:
            MOV row(%ECX), %AX
            TEST %AX, %AX
            JZ next_row_end

            ADD $2, %ECX
            MOV row(%ECX), %DX

            ADD %DX, %AX

            MOV %AX, next_row(%ECX)
            JMP next_row_loop
next_row_end:   
            PUSH %ESI
            PUSH %EDI
            CLD
            LEA next_row, %ESI
            LEA row, %EDI
            MOV $17, %ECX
            REP MOVSW

            POP %EDI
            POP %ESI
            POP %DX
            POP %AX
            POP %ECX
            RET


tartaglia_print_row: 
            PUSH %ESI
            PUSH %AX
            LEA row, %ESI
            CLD
print_row_loop:
            LODSW
            TEST %AX, %AX
            JZ print_row_end
            CALL outdecimal_word
            MOV $' ', %AL
            CALL outchar
            JMP print_row_loop
print_row_end:   
            POP %AX
            POP %ESI
            RET

get_n:      AND $0x0F, %AL
            RET
init_arrays:
            PUSH %EDI
            PUSH %AX
            PUSH %ECX

            XOR %AX, %AX
            CLD

            LEA row, %EDI
            MOV $17, %ECX
            REP STOSW
            MOVW $1, row

            LEA next_row, %EDI
            MOV $17, %ECX
            REP STOSW
            MOVW $1, next_row

            POP %ECX
            POP %AX
            POP %EDI
            RET
_main:      NOP
main_loop:  CALL indecimal_byte
            CALL get_n
            TEST %AL, %AL
            JZ main_end
            CALL init_arrays
print_loop:
            CALL newline
            CALL tartaglia_print_row
            CALL tartaglia_next_row
            DEC %AL
            TEST %AL, %AL
            JNZ print_loop

            CALL newline
            JMP main_loop
main_end:   RET

.INCLUDE "./files/utility.s"
