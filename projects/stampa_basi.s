
.DATA
buffer:         .FILL 32, 1
start_message:  .ASCII "Inserisci un numero: "
.TEXT
stampa_in_base: # n: eax, b: bx
                PUSH %EBX
                PUSH %EDX
                PUSH %EAX

                MOV $0, %ECX
init_buff_loop: 
                MOV $'0', buffer(, %ECX, 1)
                INC %ECX
                CMP $32, %ECX
                JNE init_buff_loop

                MOV $31, %ECX
loop:           CMP $0, %EAX
                JE end

                MOV %EAX, %EDX
                SAR $16, %EDX
                # n is in dx_ax
                DIV %BX
                
                ADD %DL, buffer(, %ECX, 1)
                # quoz e' in ax
                PUSH %AX
                XOR %EAX, %EAX
                POP %AX

                DEC %ECX
                JMP loop

end:            LEA buffer, %EBX
                MOV $32, %ECX
                CALL outmess
                POP %EAX
                POP %EDX
                POP %EBX
                RET

_main:          NOP
                LEA start_message, %EBX
                MOV $21, %ECX
                CALL outmess
                CALL indecimal_long
                CALL newline
                MOV $2, %DL
iter:           CMP $11, %DL
                JE end_main

                PUSH %EAX
                MOV %DL, %AL
                CALL outdecimal_byte
                MOV $':', %AL
                CALL outchar
                MOV $'\t', %AL
                CALL outchar
                POP %EAX

                MOV %DX, %BX
                CALL stampa_in_base
                
                CALL newline
                INC %DL
                JMP iter
end_main:       RET

.INCLUDE "./files/utility.s"
