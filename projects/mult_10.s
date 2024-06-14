.GLOBAL _main
.TEXT
_main:      NOP
            CALL indecimal_byte
            CALL newline

            MOV %AL, %DL
            CALL indecimal_byte
            CALL newline

            CMP $100, %DL
            JAE end
            CMP $100, %AL
            JAE end

            CMP $50, %AL
            JB over_a
            SUB $100, %AL
over_a:     CMP $50, %DL
            JB over_b
            SUB $100, %DL
over_b:     IMUL %DL
            TEST %AX, %AX
            JNS print_p
            ADD $10000, %AX
print_p:    CALL outdecimal_word
            CALL newline
end:
            RET

.INCLUDE "./files/utility.s"
