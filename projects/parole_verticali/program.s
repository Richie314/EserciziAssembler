.INCLUDE "./files/utility.s"
.GLOBAL _main
.DATA
buffer:         .FILL 88, 1, ' '
.TEXT
_main:
                NOP
                XOR %ECX, %ECX # Word count (col index)
                XOR %EBX, %EBX # Word length (row index)
input_text:     
                CMP $8, %ECX
                JE print_words

                CALL inchar
                CMP $'\r', %AL
                JE print_words

                CALL outchar
                CMP $' ', %AL
                JE word_end

                CMP $11, %EBX
                JE word_end

                MOV %AL, buffer(%ECX, %EBX, 8)

                INC %EBX

                # Loop
                JMP input_text
word_end:
                # Word has surely ended: inc column and set row = 0
                INC %ECX
                XOR %EBX, %EBX
                JMP input_text


print_words:    
                CALL newline
                CALL newline
                XOR %EBX, %EBX # Row index

row_print:
                CMP $11, %EBX
                JE end
                XOR %ECX, %ECX # Char index
char_print:
                CMP $8, %ECX
                JE row_print_end

                MOV buffer(%ECX, %EBX, 8), %AL
                CALL outchar
                MOV $' ', %AL
                CALL outchar
                INC %ECX
                JMP char_print
row_print_end:  
                INC %EBX
                CALL newline
                JMP row_print

end:
                XOR %EAX, %EAX
                RET
