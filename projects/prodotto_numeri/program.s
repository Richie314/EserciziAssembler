.INCLUDE "./files/utility.s"
.GLOBAL _main
.TEXT
_main:
            NOP
step_1:     
            CALL indecimal_byte
            CALL newline
            MOV %AL, %DL
            CALL indecimal_byte
            CALL newline
step_2_al:
            CMP $49, %AL
            JBE step_2_dl
            SUB $100, %AL
step_2_dl:
            CMP $49, %DL
            JBE step_3
            SUB $100, %DL
step_3:
            IMUL %DL

            CMP $0, %AX
            JGE step_4
            ADD $10000, %AX
step_4:
            CALL outdecimal_short

end:        
            XOR %EAX, %EAX
            RET