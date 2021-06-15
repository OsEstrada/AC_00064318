org 100h

section .text
        ;Se limpian los registros
        xor AX, AX
        xor SI, SI
        xor DI, DI
        xor BX, BX
        xor CX, CX
        xor DX, DX

        MOV byte [200h], 08h    ;Se guarda en 200h la fila inicial

        call modotexto
        call iteracion
        call esperartecla
        call exit

esperartecla:
        MOV AH, 00h 
        INT 16h

iteracion:
        CMP SI, 04h             ;Compara si SI es del mismo tamaño que length (es decir = 4)
        JE return               ;Si se cumple la condicion, salta a return
        jmp movercursor         ;Sino salta a movercursor

return:
        ret

;Activa el modo texto
modotexto: 
        MOV AH, 0h
        MOV AL, 03h 
        INT 10h
        ret

;Mueve el cursor, en este caso desplaza la fila dos posiciones abajo
movercursor:
        MOV AH, 02h             ;Posiciona el cursor en pantalla.
        MOV DH, [200h]          ;Setea el valor almacenado en 200h en DH, es decir se posicion la fila
        MOV DL, 27              ;Columna en la que se mostrará el cursor
        MOV BH, 0h              ;Numero de pagina
        INT 10h                 
        ADD byte [200h], 02h    ;Se incremente en 2, el numero de la fila almacenado en 200h
        jmp escribircaracter

escribircaracter: 
        CMP byte [string1 + DI], 20h    ;Compara si el caracter actual es igual a un espacio (en hexa 20h)    
        JE pasarpalabra                 ;Si se cumple, salta a pasarpalabra, sino, sigue ejecutando el codigo de esta etiqueta
        
        MOV byte [201h], DL             ;Se salva la columna actual
        
        MOV AH, 02h ;                   ;Posiciona el cursor en pantalla.
        MOV DL, [string1 + DI]          ;Imprime el caracter de la posicion DI.
        INT 21h 

        INC DI                          ;Incrementa DI en uno para avanzar al siguiente caracter
        MOV DL, [201h]                  ;Se setea en DL el numero de columna previamente salvado
        call movercursorcol
        jmp escribircaracter

pasarpalabra:
        INC SI                  ;Incrementa el puntero SI en uno, para indicar que termino una iteracion
        INC DI                  ;Incrementa el puntero DI en uno para que se ubique al inicio del siguiente nombre
        jmp iteracion           ;Salta a iteracion

movercursorcol:
        MOV AH, 02              ;Posiciona el cursor en pantalla.
        INC DL                  ;Mueve la columna una posicion
        INT 10h
        ret

exit:
        int 20h

section .data
        string1 DB "Oscar Alejandro Estrada Corena $"   ;Strings de mi nombre