.GLOBAL _main
.DATA
X:              .FILL 4, 1, 0
Y:              .FILL 4, 1, 0
x:              .BYTE 0
y:              .BYTE 0
s:              .BYTE 0
cout:           .BYTE 0
table:          .ASCII "X Y | s c_out\r"
.TEXT
in_digit:       CALL inchar
                CMP $'0', %AL
                JB in_digit
                CMP $'9', %AL
                JA in_digit
                CALL outchar
                RET
sum_digit:      
                PUSH %AX
                MOV x, %AL
                MOV y, %AH

                //AL = x + y
                ADD %AH, %AL
                MOV cout, %AH
                //AL = x + y + c_in
                ADD %AH, %AL
                //Clear c for next iteration
                MOVB $0, cout
                // if AL < 10 goto sum_end;
                CMP $10, %AL
                JB sum_end
                
                //c_out = 1
                MOVB $1, cout
                SUB $10, %AL
sum_end:        MOV %AL, s
                POP %AX
                RET


in_num:         PUSH %AX
                PUSH %EDI
                PUSH %ECX
                MOV $4, %ECX
                CLD
in_loop:
                CALL in_digit
                STOSB
                LOOP in_loop

                POP %ECX
                POP %EDI
                POP %AX
                RET

load_digits:    DEC %ECX
                MOV Y(%ECX, 1), %AL
                SUB $'0', %AL
                MOV %AL, y
                MOV %AL, %AH

                MOV X(%ECX, 1), %AL
                SUB $'0', %AL
                MOV %AL, x

                INC %ECX
                RET
print_dash:     PUSH %ECX
                PUSH %AX
                MOV $15, %ECX
                MOV $'-', %AL
print_dash_loop:
                CALL outchar
                LOOP print_dash_loop
                POP %AX
                POP %ECX
                RET
_main:          NOP

                LEA X, %EDI
                CALL in_num
                CALL newline

                LEA Y, %EDI
                CALL in_num
                CALL newline

                LEA table, %EBX
                CALL outline
                CALL print_dash
                CALL newline

                MOV $4, %ECX
                XOR %EDX, %EDX
sum_loop:
                CALL load_digits
                //x
                ADD $'0', %AL
                CALL outchar

                MOV $' ', %AL
                CALL outchar
                //y
                MOV %AH, %AL
                ADD $'0', %AL
                CALL outchar

                MOV $' ', %AL
                CALL outchar
                MOV $'|', %AL
                CALL outchar
                MOV $' ', %AL
                CALL outchar

                CALL sum_digit
                MOV s, %AL
                ADD $'0', %AL
                CALL outchar

                MOV $' ', %AL
                CALL outchar

                MOV cout, %AL
                ADD $'0', %AL
                CALL outchar

                CALL newline

                LOOP sum_loop
                RET

.INCLUDE "./files/utility.s"
