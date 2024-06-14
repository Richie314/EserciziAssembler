.DATA
start_message:  .ASCII "Inserisci un numero tra 0 e 9: "
end_message:    .ASCII "Il fattoriale e': "
.TEXT
factorial:      # CALL outdecimal_short
                # CALL newline
                
                CMP $9, %AX
                JA error
                CMP $1, %AX
                JB return_1
                
                PUSH %AX
                DEC %AX
                CALL factorial # edx = fact(n-1)
                POP %AX # n

                MUL %DX # n * fact(n-1)

                # put dx_ax into edx
                SAL $16, %EDX # shift dx to the left
                OR %AX, %DX # put ax into dx
                
                RET
return_1:       MOV $1, %EDX
                RET
error:          HLT

_main:          NOP
                MOV $31, %ECX
                LEA start_message, %EBX
                CALL outmess
                CALL indecimal_short
                CALL newline
                
                CALL factorial
                
                MOV $18, %ECX
                LEA end_message, %EBX
                CALL outmess
                MOV %EDX, %EAX
                CALL outdecimal_long
                call newline
                
                RET

.include "./files/utility.s"
