; GUARDAR UNA CADENA EN UN VARIABLE Y ESCRIBIRLA EN LA CONSOLA DE MS-DOS
; MAIN
	org 	100h

	section	.text

	; input frase
	mov 	BP, pass
	call  	LeerCadena

        call    CompararCadenas;
        call    EscribirCadena;

	int 	20h


	section	.data

        msgc	db	"BIENVENIDO", "$"
        msgi 	db 	"INCORRECTO", "$"
        pass 	times 	6  	db	" " 
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
        xor     SI,SI
        xor     DI,DI
        ret


; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

CompararCadenas:
        cmp     SI, 5
        JE      EsCorrecta
        mov     AL, [key + SI]
        cmp     [BP + SI], AL
        JNE     EsIncorrecta
        INC SI
        jmp CompararCadenas

EsIncorrecta:
        mov DX, msgi
        ret

EsCorrecta:
        mov DX, msgc
        ret
