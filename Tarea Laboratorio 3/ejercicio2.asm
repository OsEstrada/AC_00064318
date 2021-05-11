        org 100h
        section .text
        ;Se limpian las variables
        XOR AX, AX
        XOR CX, CX
        MOV AX, 1d      ;Se inicializa AX en 1, esto porque el factorial de 0 es siempre 0
        MOV byte CH, 5d ;Se guarda el numero del que queremos calcular el factorial en CH
        MOV byte CL, 1d ;Se inicializa nuestro contador en 1 y lo se guarda en CL
        jmp factorial

factorial:
        CMP CH, CL      ;Comparo si el valor en CH es menor al contador guardado en CL, si es así, salto a save
        JB save
        MUL CL  ; Se multiplica el contador con lo almacenado en AX
        INC CL  ; Se incrementa el contador en 1
        jmp factorial   ; Salta a la etiqueta factorial

save:
        MOV [20Bh], AX  ;Se guarda el valor del factorial en la casilla 20Bh
        jmp exit        ;Salto a exit

exit:
        int 20h
