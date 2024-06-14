# Conta bit a 1 in un long preso in input

.DATA
mess:       .ASCII "Scrivi un numero naturale in base 10:\r\n"
num:        .LONG 0

.TEXT
new_line:
            MOV $'\r', %AL
            CALL outchar
            MOV $'\n', %AL
            CALL outchar
            RET
_main:      NOP
            MOV $mess, %EBX
            CALL outline
            CALL indecimal_long
            MOV %EAX, num
            CALL new_line
            MOV $32, %ECX
loop:
            SAL num
            JC print1
            JNC print0
print1:
            MOV $'1', %AL
            CALL outchar
            JMP end_loop
print0:
            MOV $'0', %AL
            CALL outchar
            JMP end_loop
end_loop:
            LOOP loop
            CALL new_line
            RET

.INCLUDE "./files/utility.s" 
