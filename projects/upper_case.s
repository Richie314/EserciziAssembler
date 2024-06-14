
.DATA
msg:            .FILL 80, 1, 0
start_message:  .ASCII "Inserisci una stringa di max 80 caratteri: "

.TEXT
_main:          NOP
                LEA start_message, %EBX
                MOV $43, %CX
                CALL outmess
                
                MOV $80, %CX
                LEA msg, %EBX
                CALL inline

                CALL newline
                
                CLD
                LEA msg, %ESI
                LEA msg, %EDI
loop:           LODSB
                CMP $0, %AL
                JE fine
                CMP $'\r', %AL
                JE fine

                CMP $'a', %AL
                JB loop_back

                CMP $'z', %AL
                JA loop_back

                # OR $0x20, %AL
                AND $0xDF, %AL
                
loop_back:      STOSB  
                JMP loop               
                
fine:           LEA msg, %EBX
                CALL outline
                CALL newline
                RET

.INCLUDE "./files/utility.s"