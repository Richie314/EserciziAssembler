.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA
x:          .LONG 0
n:          .BYTE 0
error_text: .ASCII "RADICE NON NATURALE\r"
.TEXT
# Takes eax and elevates to the n, puts result in edx
to_the_n:  
            PUSH %ECX
            PUSH %EAX
            PUSH %EBX

            MOV %EAX, %EBX
            XOR %ECX, %ECX
            MOV n, %CL
            DEC %CL
mul_loop:
            MUL %EBX
            LOOP mul_loop

            MOV %EAX, %EDX

            POP %EBX
            POP %EAX
            POP %ECX
            RET

_main:
            NOP
step_1:
            CALL indecimal_long
            MOV %EAX, x
            CALL newline

            CALL indecimal_byte
            MOV %AL, n
            CALL newline
step_2:
            CMPB $0, n
            JE step_1

            CMPL $0, x
            JE step_1

step_3:     
            MOV $2, %EAX
test_number:
            CALL to_the_n

            CMP x, %EDX
            JE success
            
            INC %EAX
            CMP x, %EAX
            JNE test_number 

            MOV $error_text, %EBX
            CALL outline   
            JMP end 
success:
            CALL outdecimal_long
end:
            XOR %EAX, %EAX
            RET
