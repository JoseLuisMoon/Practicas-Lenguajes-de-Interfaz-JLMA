; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 13. Obtención de una cadena hexadecimal
; Descripción: Transforma un entero de 32 bits a formato de texto hexadecimal aislando cada nibble mediante máscara 0Fh, aplicando conversión condicional a dígitos '0'-'9' o letras 'A'-'F' y llenando el buffer de fin a inicio.

INCLUDE Irvine32.inc
.data

; Textos explicativos para la presentación de los valores
msgHexadecimal BYTE "Numero hexadecimal: 12AB34CD", 0
msgResultado   BYTE "Cadena obtenida: ", 0 

; Espacio en memoria de 9 bytes para guardar los 8 dígitos hexadecimales más el nulo final
bufferHex BYTE 9 DUP(0)

.code 
main PROC 

	mov edx, OFFSET msgHexadecimal ; Imprime en consola el valor original en base 16
	call WriteString
	call Crlf ; Salto de renglón

	mov eax, 12AB34CDh ; Asigna en EAX el valor hexadecimal de 32 bits a convertir
	mov esi, 7 ; Apunta el índice ESI al último carácter del buffer (posición 7)
	mov ecx, 8 ; Configura el contador ECX en 8 para iterar sobre los 8 nibbles

convertir:
	mov dl, al ; Pasa el byte menos significativo a DL
	and dl, 0Fh ; Aplica una máscara AND con 0Fh para conservar únicamente el nibble inferior

	cmp dl, 9 ; Verifica si el valor del nibble excede de 9
	ja esLetra ; Si es mayor que 9 (10-15), salta para convertir a carácter de 'A' a 'F'

	; Conversión para valores numéricos del 0 al 9
	add dl, '0' ; Suma el valor ASCII de '0' para obtener el carácter
	jmp guardarDigito ; Salta directamente a almacenar el dígito procesado

esLetra:
	; Conversión para valores alfabéticos del 10 al 15
	sub dl, 10 ; Resta 10 para obtener el desplazamiento desde 'A'
	add dl, 'A' ; Suma el código base de 'A' para generar el carácter correspondiente

guardarDigito:
	mov bufferHex[esi], dl ; Guarda el carácter ASCII en la posición actual del buffer
	shr eax, 4 ; Rota 4 bits hacia la derecha para colocar el siguiente nibble en la posición baja
	dec esi ; Decrementa el índice ESI para llenar la cadena de derecha a izquierda
	loop convertir ; Decrementa ECX y repite el bucle mientras queden dígitos pendientes

	mov edx, OFFSET msgResultado ; Muestra el encabezado del resultado
	call WriteString
	mov edx, OFFSET bufferHex ; Obtiene el puntero hacia la cadena hexadecimal resultante
	call WriteString ; Despliega la cadena ASCII obtenida
	call Crlf 

	exit

main ENDP

END main
