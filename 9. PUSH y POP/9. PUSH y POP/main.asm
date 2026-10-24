; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 9. PUSH y POP
; Descripción: Demostración del funcionamiento de la pila en x86 (Stack LIFO) empleando PUSH y POP, respaldo temporal de registros y preservación de variables en subrutinas con CALL y RET.

INCLUDE Irvine32.inc

.code
main PROC

	; BLOQUE 1: FUNCIONES BÁSICAS DE PUSH Y POP
	mov eax, 20 ; Carga el entero 20 en EAX

	push eax ; Inserta EAX en la cima del stack (decrementa ESP en 4 bytes)

	nop ; Pausa para visualizar cambios en el depurador

	mov ebx, 0 ; Limpia a cero el registro EBX

	pop ebx ; Extrae el valor del tope del stack hacia EBX (incrementa ESP en 4 bytes)

	nop

	; BLOQUE 2: ESTRUCTURA LIFO (LAST IN, FIRST OUT)
	mov eax, 10 ; Posición ESP + 8
	push eax ; Apila el valor 10 (primer dato ingresado)

	mov eax, 20 ; Posición ESP + 4
	push eax ; Apila el valor 20 (segundo dato ingresado)

	mov eax, 30 ; Posición en la cima actual de ESP
	push eax ; Apila el valor 30 (último dato ingresado al tope del stack)

	nop

	pop eax ; Desapila el valor más reciente: 30 a EAX
	pop ebx ; Desapila el siguiente elemento: 20 a EBX
	pop ecx ; Desapila el primer dato que ingresó: 10 a ECX

	; BLOQUE 3: SALVAGUARDA Y RESTAURACIÓN DE REGISTROS
	; Carga de datos para prueba
	mov eax, 100 
	mov ebx, 200

	push eax ; Guarda en la pila el valor original de EAX (100)
	push ebx ; Guarda en la pila el valor original de EBX (200)

	mov eax, 999 ; Modifica los registros con nuevos datos temporales
	mov ebx, 666

	pop ebx ; Restaura EBX desapilando su valor original (200)
	pop eax ; Restaura EAX desapilando su valor original (100)

	; BLOQUE 4: LLAMADA Y RETORNO DE SUBRUTINAS (CALL Y RET)
	
	mov eax, 111 ; Asigna datos iniciales antes de llamar a la función
	mov ebx, 222

	call aumentarDiez ; Guarda la dirección de retorno en la pila y transfiere el control a aumentarDiez

	nop

	exit

main ENDP ; Fin de la rutina principal

aumentarDiez PROC ; Procedimiento que incrementa en 10 a EAX preservando el registro EBX
	push ebx ; Guarda el valor de EBX en la pila para no perderlo

	mov ebx, 10 ; Carga el incremento 10 en EBX

	add eax, ebx ; Suma EBX a EAX (111 + 10 = 121)

	pop ebx ; Recupera el estado original de EBX antes de salir

	ret ; Extrae la dirección de retorno y vuelve al punto posterior a CALL
aumentarDiez ENDP
END main
