.GLOBAL _main
.DATA 
X:          .FILL 8, 1, 0
Y:          .FILL 8, 1, 0
Z:          .FILL 8, 1, 0
.TEXT

in_digit:   
            CALL inchar
            CMP $'0', %AL
            JB in_digit
            CMP $'6', %AL
            JAE in_digit
            CALL outchar
            SUB $'0', %AL
            RET
//in %EBX: buffer pointer
in_number:  PUSH %AX
            PUSH %ECX
            MOV $0, %ECX
in_loop:    CALL in_digit
            MOV %AL, (%ECX, %EBX, 1)
            INC %ECX
            CMP $8, %ECX
            JNE in_loop
            POP %ECX
            POP %AX
            RET

// out: dl
is_zero:    PUSH %AX
            PUSH %ECX
            MOV $0, %ECX
            MOV $1, %DL
zero_loop:  
            MOVB (%ECX, %EBX, 1), %AL     
            CMP $0, %AL
            JNE non_zero
            INC %ECX
            CMP $8, %ECX
            JNE zero_loop
            JMP check_end
non_zero:   MOV $0, %DL
check_end:  POP %ECX
            POP %AX
            RET

// Input: ah, al
// Ouput: ah, al
sum_b6:     ADD %AH, %AL
            CMP $6, %AL
            JAE carry
            MOV $0, %AH
            JMP sum_end
carry:      
            SUB $6, %AL
            MOV $1, %AH
sum_end:    RET

_main:      NOP
            LEA X, %EBX
            CALL in_number
            CALL newline
            LEA Y, %EBX
            CALL in_number
            CALL newline

            CALL is_zero
            CMP $1, %DL
            JE _end

            LEA X, %EBX
            CALL is_zero
            CMP $1, %DL
            JE _end

            MOV $7, %ECX 
loop1:      MOVB X(%ECX), %AL
            MOVB Y(%ECX), %AH
            CALL sum_b6
            MOV %AL, Z(%ECX)

            CMP $0, %ECX
            JE carry_end 
            DEC %ECX
            ADD %AH, X(%ECX)
            JMP loop1
carry_end:  MOV %AH, %DL


            MOV $0, %ECX 
loop2:      MOVB Z(%ECX), %AL
            ADD $'0', %AL
            CALL outchar

            CMP $7, %ECX
            JE print_end 
            INC %ECX
            JMP loop2
print_end:  MOV $' ', %AL
            CALL outchar
            MOV %DL, %AL
            ADD $'0', %AL
            CALL outchar

_end:       RET

.INCLUDE "./files/utility.s"
