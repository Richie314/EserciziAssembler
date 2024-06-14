.DATA
start_message:  .ASCII "Inserisci un numero tra 0 e 9: "
end_message:    .ASCII "Il coefficiente binomiale e': "
error_bi:       .ASCIZ "Errore nel binomiale :/"
error_fact:     .ASCIZ "Errore nel fattoriale :/"
a_fatt:         .LONG 0
b_fatt:         .LONG 0
ab_fatt:        .LONG 0
.TEXT
factorial:      # CALL outdecimal_short
                # CALL newline
                
                CMP $9, %AX
                JA error_factorial
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
error_factorial: 
                LEA error_fact, %EBX
                CALL outline
                HLT

                
binomial:       # input: ax: a, bx: b
                CMP %AX, %BX
                JA error_binomial # b > a

                PUSH %AX
                               # ax = a
                CALL factorial # edx = a!
                MOV %EDX, a_fatt
                
                MOV %BX, %AX   # ax = b
                CALL factorial # edx = b!
                MOV %EDX, b_fatt
                POP %AX # ax = a, bx = b
                
                SUB %BX, %AX   # ax = a-b
                
                CALL factorial # edx = (a-b)!
                MOV %EDX, ab_fatt

                XOR %EDX, %EDX
                MOV a_fatt, %EAX
                DIV b_fatt # eax = a!/b!
                DIV ab_fatt # eax = a!/(b! (a-b)!)

                
                MOV %EAX, %EDX
                RET

error_binomial: 
                LEA error_bi, %EBX
                CALL outline
                HLT
                
_main:          NOP
                
                MOV $31, %ECX
                LEA start_message, %EBX
                CALL outmess

                CALL indecimal_short
                CALL newline
                # ax = a
                PUSH %AX
                
                MOV $31, %ECX
                LEA start_message, %EBX
                CALL outmess

                CALL indecimal_short
                CALL newline
                # ax = b
                XOR %EBX, %EBX
                MOV %AX, %BX
                POP %AX

                CALL binomial
                
                MOV $30, %ECX
                LEA end_message, %EBX
                CALL outmess
                MOV %EDX, %EAX
                CALL outdecimal_long
                call newline
                
                RET

.include "./files/utility.s"
