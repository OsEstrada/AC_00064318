;Main
        org     100h
        section .text
        MOV BP, arr
        XOR BX, BX      ;Se limpian los registros
        XOR CX, CX
        XOR DX, DX
        XOR SI, SI
        XOR DI, DI
        MOV byte BH, 2d
        CALL Iteration
        int 20h


        section .data
        
        arr     db     1d,2d,3d,4d,5d,6d,7d,8d,9d,10d   ;Declaracion de los arreglos de numeros
        length  equ     $-arr


Iteration:
        CMP SI, length
        JE Exit
        XOR AX, AX              ;Se limpian todos los elementos en AX, puesto que quedan los resultados de las divisiones
        MOV AL, [BP + SI]      ;Se almacena en el AX el dividendo (en este caso los valores de nuestro arreglo). Utilizo AL porque ya se sabe que cada numero ocupa un byte
        MOV BL, AL              ;Se almacena en BL el valor del dividendo. Esto debido a que AL y AH se sobreescribiran con el cociente y residuo
        DIV BH
        INC SI
        CMP AH, 0d                 ;Se incrementa en 1 la posicion del puntero
        JZ  Even
        JA  Odd

Odd:
        MOV DI, CX                      ;CL guarda la ultima posicion de DI en Odd
        MOV byte [320h + DI], BL        ;Se guarda el numero en la direccion 320h, el DI indica cuantas casillas se mueve
        INC DI
        MOV CX, DI
        JMP Iteration

Even:
        MOV DI, DX                      ;CL guarda la ultima posicion de DI en Even
        MOV byte [300h + DI], BL        ;Se guarda el numero en la direccion 300h, el DI indica cuantas casillas se mueve
        INC DI
        MOV DX, DI
        JMP Iteration

Exit:
        ret