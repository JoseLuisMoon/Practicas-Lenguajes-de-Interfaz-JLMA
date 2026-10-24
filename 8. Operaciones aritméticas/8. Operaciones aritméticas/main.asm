; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 8. Operaciones aritméticas
; Descripción: Implementación y análisis de instrucciones aritméticas en ensamblador (ADD, SUB, MUL, IMUL, DIV, IDIV), evaluando el efecto en las banderas CF y OF, y la extensión de signo con CDQ.

INCLUDE Irvine32.inc
.data
.code
main proc 
	; 1. SUMA Y RESTA BÁSICAS (INSTRUCCIONES ADD Y SUB)
	; Asignación de valores numéricos de inicio
	mov eax, 50 
	mov ebx, 20 

	add eax, ebx ; Suma el valor de EBX a EAX (50 + 20 = 70)
	sub eax, 15 ; Sustrae 15 de EAX (70 - 15 = 55)

	nop ; Instrucción sin efecto (NOP) para facilitar la inspección con depurador

	; 2. ACTIVACIÓN DEL ACARREO (CF) EN NÚMEROS SIN SIGNO

	mov eax, 0 ; Reinicia el registro EAX a cero
	mov al, 255 ; Carga el límite de un byte sin signo (255 / FFh) en AL

	mov al, 1 ; Asigna el valor 1 en AL

	nop


	; 3. DESBORDAMIENTO (BANDERA OF) EN NÚMEROS CON SIGNO
	mov eax, 0 ; Restablece EAX a cero
	mov al, 127 ; Asigna 127 a AL (límite máximo representable en 8 bits con signo)

	add al, 1 ; Incrementa AL sumándole 1 (127 + 1)
			  ; Al exceder la capacidad con signo de 8 bits (-128 a 127), la bandera OF pasa a 1

	nop

	; 4. MULTIPLICACIÓN NO FIRMADA (MUL) EN 32 BITS
	; Carga de valores para la multiplicación en EAX y EBX
	mov eax, 25
	mov ebx, 3

	mul ebx ; Efectúa la multiplicación sin signo EAX * EBX (25 * 3)
			; El resultado queda depositado en el registro EAX

	nop

	; 5. MULTIPLICACIÓN CON SIGNO (IMUL) DE 32 BITS 

	mov eax, -5 ; Introduce un valor negativo en el acumulador EAX

	imul eax, eax, 3 ; Realiza el producto con signo EAX = EAX * 3 (-5 * 3 = -15)
					 ; El resultado con signo permanece en EAX

	; 6. MULTIPLICACIÓN (MUL) CON SALIDA EN 64 BITS (PAR DE REGISTROS EDX:EAX)

	mov eax, 65537
	mov ebx, 655537

	mul ebx ; Al multiplicar cifras grandes, los 32 bits superiores van a EDX y los 32 inferiores a EAX
	
	nop

	; 7. DIVISIÓN NO SIGNADA (DIV) DE 32 BITS
	mov eax, 125 ; Asigna el valor del dividendo a EAX
	mov edx, 0 ; Pone en cero EDX para formar el dividendo completo en EDX:EAX
	mov ebx, 12 ; Asigna 12 como divisor en el registro EBX

	div ebx ; Ejecuta la división: cociente almacenado en EAX y resto en EDX

	nop
	

	; 8. DIVISIÓN CON SIGNO (IDIV) UTILIZANDO NÚMEROS NEGATIVOS

	mov eax, -125 ; Coloca el dividendo negativo en EAX
	cdq ; Extiende el bit de signo de EAX hacia EDX mediante la directiva CDQ

	mov ebx, 12 ; Coloca el divisor 12 en el registro EBX

	idiv ebx ; Ejecuta la división con signo; cociente en EAX y residuo en EDX

	nop
	exit
main ENDP

END main
