; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 3. Comparación y prueba
; Descripción: Análisis práctico del funcionamiento de las instrucciones CMP y TEST, observando la alteración de las banderas de estado ZF, SF, CF y OF en los registros.

INCLUDE Irvine32.inc


.code
main PROC
	
	; CASO 1: VERIFICACIÓN DE LA BANDERA CERO (ZF)
	; La bandera ZF se activa (1) cuando el resultado de la resta aritmética es exactamente cero.
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx ; Realiza EAX - EBX internamente; como son idénticos da 0 y activa ZF
	call DumpRegs ; Muestra el estado de la CPU, registros y banderas

	mov eax, 10h ; Asigna el valor 10h (16 decimal) en ambos registros
	mov ebx, 10h
	cmp eax, 10h ; Compara EAX con 10h; al ser iguales la bandera ZF se enciende

	call DumpRegs
	
	mov eax, 0 ; Limpia el registro EAX
	mov al, 000000101b ; Asigna el valor binario 00000101b (5 decimal) en AL
	cmp al, 5 ; Compara AL contra 5; genera 0 en la resta interna y activa ZF

	call DumpRegs

	; CASO 2: VERIFICACIÓN DE LA BANDERA DE SIGNO (SF)
	; El flag SF se coloca en 1 si el valor obtenido tiene encendido el bit de signo (número negativo).
	mov eax, 3
	mov ebx, 4
	cmp eax, ebx ; La resta 3 - 4 da como resultado un valor negativo, provocando que SF sea 1

	call DumpRegs

	mov eax, 0
	mov ebx, 0 ; Limpieza de los registros EAX y EBX

	mov al, -5 ; Coloca -5 en el registro AL
	mov bl, 1 ; Asigna 1 al registro BL
	cmp al, bl ; Resta -5 - 1 dando resultado negativo, activando la bandera SF

	call DumpRegs

	; CASO 3: VERIFICACIÓN DE LA BANDERA DE ACARREO (CF)
	; El indicador CF se pone en 1 cuando una operación sin signo requiere acarreo o préstamo.
	mov eax, 0
	mov ebx, 0

	mov al, 5 ; Carga 5 en el subregistro AL
	mov bl, 10 ; Carga 10 en el subregistro BL
	cmp al, bl ; Al restar 5 - 10 se produce un préstamo (acarreo sin signo), activando CF

	call DumpRegs

	; CASO 4: VERIFICACIÓN DE LA BANDERA DE DESBORDAMIENTO (OF)
	; El flag OF se dispara cuando una operación con signo supera los límites que el registro puede representar.
	mov eax, 0
	mov ebx, 0

	mov al, -128 ; Asigna -128 a AL (límite inferior para enteros con signo de 8 bits)
	mov bl, 1 ; Coloca 1 en BL
	cmp al, bl ; Restar 1 a -128 produce -129, excediendo el rango [-128 a 127] y activando OF

	call DumpRegs

	; CASO 5: FUNCIONAMIENTO DE LA INSTRUCCIÓN TEST
	; Realiza un AND lógico bit a bit sin modificar los operandos, afectando únicamente las banderas.
	mov eax, 0

	mov al, 5 ; Carga 5 (00000101b) en AL
	test  al, 1 ; Evalúa el bit menos significativo mediante una máscara 1

	call DumpRegs

	 
	mov al, 10000000b ; Asigna 10000000b a AL, con el bit 7 (bit de signo) activo
	test al, 10000000b ; Aplica TEST sobre el bit más significativo; al dar 1 se interpreta como signo negativo y enciende SF
	; Justificación: El bit más alto (bit 7) es 1, lo cual en números con signo indica negativo y activa la bandera SF.

	call DumpRegs 

	exit
main ENDP
END main
