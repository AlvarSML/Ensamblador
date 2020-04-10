.define 
	mul1 6d ;(No se modifica)
	mul2 5d ;(Se va desplazando)

.data 1200h
	db mul1 	;Multiplicando
	db mul2	;Multiplicador
	db 0		;Resultado

.org 1000h
;---------------------------------;
;	Comprobaciones iniciales    ;
;---------------------------------;
		MVI A, mul1
		ANI FFh		;OR 0?
		JZ final
		MVI A, mul2
		ANI FFh
		JZ final
;---------------------------------;
;	Inicio de la multiplicacion ;
;---------------------------------;
		MVI B, mul2
		MVI E, mul1
		MVI C, 0
inicio:	INR C			;Aumento del contado

		MOV A, B		;Se mueve a A el contenido de B (mul2)
		ANI 1B		;Se comprueba el LSB
		MOV A, D		;Se mueve el resultado anterior a A

		JZ cero		;Si el LSB es 0 no se suma		
		ADD E		;Se suma el resultado anterior

cero:		MOV D, A		;Se mueve el resultadoa D

		MOV A, E 		;Se mueve el operador (R1) a A
		RLC			;R1 x 2
		MOV E,A		;Se devuelve R1 al accumulador
	
		MOV A, B		;Se mueve R2 al acumulador
		RAR			;Se rota R2
		MOV B, A		;Se devuleve R2 a B
		MOV A, C		;El contador a A
		ANI 100B		;Si el contador esta a 4 (o mas)
		JZ inicio
final:	
		LXI H, 1202h
		MOV M, D		;Se muleve el resultado a la memoria
		HLT
