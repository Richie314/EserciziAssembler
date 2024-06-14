.GLOBAL _main
.DATA
a:              .BYTE 0
b:              .BYTE 0
c:              .BYTE 0
d:              .BYTE 0

bd:             .WORD 0
ad:             .WORD 0
bc:             .WORD 0
ac:             .WORD 0
ad_bc:          .LONG 0
.TEXT
_main:          NOP
                CALL indecimal_short
                CALL outdecimal_short
                CALL newline
                MOV %AL, b
                MOV %AH, a
                CALL indecimal_short
                CALL outdecimal_short
                CALL newline
                MOV %AL, d
                MOV %AH, c

                MOV b, %AL
                MUL d
                MOV %AX, bd

                MOV a, %AL
                MUL d
                MOV %AX, ad

                MOV b, %AL
                MUL c
                MOV %AX, bc

                MOV a, %AL
                MUL c
                MOV %AX, ac

                // Numero piu alto
                XOR %EAX, %EAX
                MOV ac, %AX
                SHL $16, %AX

                // Numero in mezzo
                PUSH %EAX
                PUSH %EDX
                XOR %EAX, %EAX
                XOR %EDX, %EDX
                MOV ad, %AX
                MOV bc, %DX
                ADD %EDX, %EAX
                SHL $16, %EAX
                MOV %EAX, ad_bc
                POP %EDX
                POP %EAX

                XOR %EDX, %EDX
                MOV bd, %DX
                ADD %EDX, %EAX
                ADD ad_bc, %EAX

                CALL outdecimal_long
                RET