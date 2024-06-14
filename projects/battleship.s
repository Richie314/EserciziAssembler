
.DATA

grid:       .WORD 0
mancato_str: .ASCII "mancato!\r"
colpito_str: .ASCII "colpito!\r"
vittoria:    .ASCII "vittoria!\r"

.TEXT
// sets cl-th bit to 0
reset:      
            PUSH %DX
            PUSH %CX
            MOV $1, %DX 

            SHL %CL, %DX
            NOT %DX
            AND %DX, grid

            POP %CX
            POP %DX
            
            RET    
// checks if the cl-th bit is 0  
check:      PUSH %CX
            PUSH %DX

            MOV $1, %DX 
            SHL %CL, %DX
            
            AND grid, %DX
            CMP $0, %DX
            JE mancato
            LEA colpito_str, %EBX
            JMP _print
mancato:    LEA mancato_str, %EBX     
_print:     
            CALL outline
            POP %DX
            POP %CX
            RET  

in_coord:   XOR %CX, %CX
            CALL inchar
            CMP $'a', %AL
            JB in_coord
            CMP $'d', %AL
            JA in_coord
            CALL outchar

            MOV %AL, %CL
            SUB $'a', %CL
            SHL $2, %CL
in_digit:   CALL inchar
            CMP $'1', %AL
            JB in_digit
            CMP $'4', %AL
            JA in_digit  
            CALL outchar          

            SUB $'1', %AL
            ADD %AL, %CL

            RET

_main:      NOP
            CALL inword
            MOV %AX, grid
            CALL newline

loop:       MOV grid, %AX
            CMP $0, %AX
            JE end_loop

            CALL in_coord
            CALL newline
            CALL check
            CALL reset

            JMP loop
end_loop:   LEA vittoria, %EBX
            CALL outline
            RET

.INCLUDE "./files/utility.s"
