;Lo que este programa hace es almacenar la contrasña. Luego se ejecuta un segundo bucle que compara caracter por caracter ambas contraseñas. Debido
;a la limitacion a que la password debe tener una longitud de 5 caracteres, se puso de forma quemada el valor de 5. En caso que el bucle llegue de manera exitosa a 5
;significa que todos los caracteres son correctos, y se imprime en pantalla la palabra "BIENVENIDO", sin embargo si algun caracter no es igual, se sale del bucle
;e imprime "INCORRECTO"

;MAIN	
        org 	100h

	section	.text

	; input frase
	mov 	BP, pass
	call  	LeerCadena
        call    Validar;
        call    EscribirCadena;
        call    EsperarTecla;

	int 	20h

	section	.data

        msgc	db	"BIENVENIDO", "$"
        msgi 	db 	"INCORRECTO", "$"
        pass 	times 	6  	db	" "     ;"Guarde 6 espacios por el caracter $"
        key     db      "12345","$"	

; FUNCIONES

; Permite leer un carácter de la entrada estándar con echo
; Parámetros:   AH: 07h         
; Salida:       AL: caracter ASCII leído
EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret


; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena 		BP: direccion de guardado
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      exit            ; si AL == EnterKey, saltar a exit
        mov     [BP+SI], AL   	; guardar caracter en memoria
        inc     SI              ; SI++
        jmp     while           ; saltar a while
exit:
	mov 	byte [BP+SI], "$"	; agregar $ al final de la cadena
        xor     SI,SI                   ;Limpio SI, eso debido  que volvere a recorrer ambas cadenas desde la posicion 0
        ret


; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

Validar:
        cmp     SI, 5                   ;Se revisa si SI llega a 5, la cual es la longitud de la contraseña, si llego hasta exitosamente, se asume que la contraseña es correcta
        JE      EsCorrecta              ;y se sale del bucle
        mov     AL, [key + SI]          ;Sino se ha llegado al final, se procede a mover el caracter de la clave original en la posicion Si al registro AL 
        cmp     [BP + SI], AL           ;Se compara con el caracter de la contraseña ingresada, si es diferente siginifica que es incorrecta
        JNE     EsIncorrecta
        INC SI                          ;En caso de que sean iguales se avanza a comparar el siguiente caracter
        jmp Validar

EsIncorrecta:
        mov DX, msgi                    ;Se mueve el texto "INCORRECTO" a DX para imprimirlo en pantalla
        ret

EsCorrecta:
        mov DX, msgc                    ;Se mueve el texto "BIENVENIDO" a DX para imprimirlo en pantalla
        ret