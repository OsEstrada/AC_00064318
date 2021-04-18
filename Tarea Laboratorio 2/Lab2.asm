        org     100h
        section .text


        mov     byte [200h], "O"
        mov     byte [201h], "A"
        mov     byte [202h], "E"
        mov     byte [203h], "C"

        ;Direccionamiento absoluto
        mov     AX, [200h]

        ;Direccionamiento indirecto por registro
        mov     BX, 201h
        mov     CX, [BX]

        ;Direccionamiento indirecto base mas indice
        mov     BX, 202h
        mov     DX, [BX+SI]

        ;Direccionamiento relativo por registro
        mov     DI, [SI+203h] 

        int 20h