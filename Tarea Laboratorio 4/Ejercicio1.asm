;Main
        org     100h
        section .text
        MOV BP, arr             ;Se ubica el puntero base al inicio del array.
        XOR BX, BX              ;Se limpian los registros
        XOR CX, CX
        XOR DX, DX
        XOR SI, SI
        XOR DI, DI
        MOV byte BH, 2d         ;Guardo en el registro BH el valor de 2, el cual sera posteriormente utilizado para verificar la paridad.
        CALL Iteration          ;Llamado a la subrutina Iteration
        int 20h


        section .data
        
        arr     db     1d,2d,3d,4d,5d,6d,7d,8d,9d,10d   ;Declaracion de los arreglos de numeros
        length  equ     $-arr                           ;Tamaño del arreglo, se almacena como constante porque nunca variara.


Iteration:
        CMP SI, length          ;Se verifica que el valor de SI no sea igual al tamaño del arreglo. Si es igual regresa a la rutina principal(MAIN)
        JE Exit
        XOR AX, AX              ;Se limpian todos los elementos en AX, puesto que quedan los resultados de las divisiones
        MOV AL, [BP + SI]       ;Se almacena en el AX el dividendo (en este caso los valores de nuestro arreglo cuya posicion es definida por SI). Utilizo AL porque ya se sabe que cada numero ocupa un byte
        MOV BL, AL              ;Se almacena en BL el valor del dividendo. Esto debido a que AL y AH se sobreescribiran con el cociente y residuo
        DIV BH
        INC SI                  ;Se incrementa en 1 la posicion de SI. Es decir se mueve una casilla en el arreglo
        CMP AH, 0d
        JZ  Even
        JA  Odd

Odd:
        MOV DI, CX                      ;CL guarda la ultima posicion de DI en Odd
        MOV byte [320h + DI], BL        ;Se guarda el numero en la direccion 320h, el DI indica cuantas casillas se mueve
        INC DI                          ;Se incrementa el valor de DI 1, que posteriormente se guardara en CX
        MOV CX, DI
        JMP Iteration                   ;Salto a Iteration

Even:
        MOV DI, DX                      ;CL guarda la ultima posicion de DI en Even
        MOV byte [300h + DI], BL        ;Se guarda el numero en la direccion 300h, el DI indica cuantas casillas se mueve
        INC DI                          ;Se incrementa el valor de DI 1, que posteriormente se guardara en DX
        MOV DX, DI
        JMP Iteration                   ;Salto a Iteration

Exit:
        ret