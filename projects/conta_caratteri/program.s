.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA

buffer:             .FILL 80, 1, 0

.TEXT

// Stores an array, chars are memorized to lowercase
inmess:             
                    PUSH %ECX
                    PUSH %EDI
                    
                    MOV $80, %ECX
                    LEA buffer, %EDI
                    CLD
inmess_loop:
                    CALL inchar
                    CALL outchar
                    CMP $'A', %AL
                    JB store_char
                    CMP $'Z', %AL
                    JA store_char
                    ADD $32, %AL
store_char:
                    STOSB
                    CMP $'\r', %AL
                    LOOPNE inmess_loop
                    
                    POP %EDI
                    POP %ECX
                    RET
// Counts the occurences of the char in AL, result in edx
count_char:         
                    PUSH %ECX
                    PUSH %ESI
                    PUSH %EAX

                    MOV $80, %ECX
                    LEA buffer, %ESI
                    MOV %AL, %AH
                    XOR %EDX, %EDX
                    CLD
count_loop:
                    LODSB

                    CMP %AL, %AH
                    JNE count_loop_continue
                    INC %EDX
count_loop_continue:
                    CMP $'\r', %AL
                    LOOPNE count_loop

                    POP %EAX
                    POP %ESI
                    POP %ECX
                    RET

_main:
                    NOP
step_1:
                    CALL inmess
                    CALL newline
step_2:             
                    XOR %ECX, %ECX
                    XOR %EBX, %EBX
main_loop:
                    MOV %ECX, %EAX
                    CMP $10, %ECX
                    JB from_digit
                    ADD $'a', %EAX
                    SUB  $10, %EAX
                    JMP count
from_digit:
                    ADD $'0', %EAX
count:              
                    CALL count_char
                    CMP $0, %EDX
                    JE out_count
                    
                    MOV $1, %EBX
                    CALL outchar
                    
                    MOV $' ', %AL
                    CALL outchar

                    MOV %EDX, %EAX
                    CALL outdecimal_long

                    CALL newline
out_count:          
                    INC %ECX
                    CMP $16, %ECX
                    JNE main_loop
step_3:
                    CMP $0, %EBX
                    JE end
                    CALL newline
                    JMP step_1
end:
                    XOR %EAX, %EAX
                    RET
