; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 4. Saltos
; Descripción: Compara dos números enteros utilizando la instrucción CMP y desvía el flujo con saltos condicionales e incondicionales (JE y JMP) según si son iguales o distintos.

INCLUDE Irvine32.inc
.data
; Mensajes para indicar el resultado de la comparación
msgIguales Byte "Los numeros son iguales", 0 
msgDiferentes Byte "Los numeros son diferentes", 0

.code
main PROC

	; Asigna valores de prueba en los registros EAX y EBX
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx ; Compara el contenido de EAX contra EBX restándolos internamente
	
	je iguales ; Salta a la etiqueta 'iguales' si la bandera ZF quedó en 1

	mov edx, OFFSET msgDiferentes ; Carga la dirección del mensaje de números diferentes
	call WriteString

	jmp fin ; Salto incondicional al final para no ejecutar el bloque de iguales

	iguales: ; Etiqueta a la que se salta cuando ambos valores coinciden
		mov edx, OFFSET msgIguales ; Coloca en EDX el mensaje correspondiente a valores iguales
		call WriteString
	
	fin:
		call Crlf ; Salto de línea final
 exit
main ENDP
END main
