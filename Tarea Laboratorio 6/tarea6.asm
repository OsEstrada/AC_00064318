; MAIN
	org 	100h

	section	.text

        mov DI, 0       ;Contador

	; input password
	mov 	BP, pass
	call  	LeerCadena
	call	EsperarTecla

	int 	20h

	section	.data

msgc	db	"BIENVENIDO", "$"
msgi 	db 	"INCORRECTO", "$"
pass 	times 	6  	db	" "
key     db      "rooot"
len     equ     $-key

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
        je      validar            ; si AL == EnterKey, saltar a exit
        mov     [BP+SI], AL   	; guardar caracter en memoria
        cmp     AL, [key + SI]
        je      CaracteresIguales
        inc     SI              ; SI++
        jmp     while           ; saltar a while
validar:
        cmp     DI, len
        je      EsCorrecta
        mov     DX, msgi
        jmp     EscribirCadena    

EsCorrecta:
        mov     DX, msgc
        jmp     EscribirCadena

; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

CaracteresIguales:
        inc     DI
        inc     SI
        jmp     while