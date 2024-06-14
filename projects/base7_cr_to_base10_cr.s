.GLOBAL _main

.DATA

x:              .FILL 3, 1, 0
s:              .BYTE 0
y:              .FILL 2, 1, 0
ow:             .BYTE 0
.TEXT
in_num:         
                PUSH %ECX
                PUSH %EDI
                CLD
                LEA x, %EDI
                MOV $3, %ECX
in_num_loop:    
                CALL inchar
                CMP $'0', %AL
                JB in_num_loop
                CMP $'7', %AL
                JAE in_num_loop
                CALL outhcar

                SUB $'0', %AL
                STOSB
                LOOP in_num_loop

                POP %EDI
                POP %ECX
                RET
b7cr_2_b7ms:    MOV $0, s
                MOV x, %AL
                CMP $3, %AL
                JBE b7cr_ms_end
                LEA x, %EDI
                MOV $3, %ECX

b7cr_ms_end:
                RET
b7_2_b10:       

_main:          NOP

                CALL in_num



                RET

.INCLUDE " ./files/utility.s"
