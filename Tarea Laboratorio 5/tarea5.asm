org 100h

section .text
        xor AX, AX
        xor SI, SI
        xor BX, BX
        xor CX, CX
        xor DX, DX

        MOV SI, 0
        MOV DI, 00h
        MOV byte [200h], 05h;

        MOV DH, 0 

        call modotexto
        call iteracion
        call exit


iteracion:
        CMP SI, length
        JE return
        jmp movercursor

return:
        ret

modotexto: 
        MOV AH, 0h
        MOV AL, 03h 
        INT 10h
        ret

movercursor:
        MOV AH, 02h 
        MOV DH, [200h] 
        MOV DL, 20 
        MOV BH, 0h 
        INT 10h
        ADD byte [200h], 02h
        jmp escribircaracter

pasarpalabra:
        INC SI
        INC DI
        jmp iteracion

escribircaracter: 
        CMP byte [string1 + DI], 20h
        JE pasarpalabra
        MOV AH, 0Ah ;
        MOV AL, [string1 + DI] 
        MOV CX, 01h
        INT 10h
        INC DI
        MOV AH, 02
        INC DL
        INT 10h
        jmp escribircaracter

exit:
        int 20h

section .data
        ;Strings de mi nombre
        string1 DB "Oscar Alejandro Estrada Corena $"

        length  equ     04h