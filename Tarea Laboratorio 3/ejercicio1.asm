        org     100h
        section .text

        XOR AX, AX      ;Limpia AX
        XOR SI, SI      ;Limpia SI
        MOV byte BL, 8d ;Numero de digitos que posee el carnet
        MOV word CX, 8d ;Contador del loop
        ;Se guardan los digitos del carnet en las casillas 200
        MOV byte [200h], 0d
        MOV byte [201h], 0d
        MOV byte [202h], 0d
        MOV byte [203h], 6d
        MOV byte [204h], 4d
        MOV byte [205h], 3d
        MOV byte [206h], 1d
        MOV byte [207h], 8d
        jmp iterar


iterar:
        ADD AL, [200h + SI]     ;Se realiza la suma del digito y el valor almacenado en AL, y el resultado se guarda en AL
        INC SI  ;Se incrementa el contador del indice
        LOOP iterar

division:
        DIV BL  ;Realiza la division y la guarda el cociente en AL
        MOV[20Ah], AL


exit:
        int 20h