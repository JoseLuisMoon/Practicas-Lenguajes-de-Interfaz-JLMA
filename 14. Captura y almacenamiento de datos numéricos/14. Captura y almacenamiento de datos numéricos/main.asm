; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 14. Captura y almacenamiento de datos numéricos
; Descripción: Captura unidades recibidas como cadena de caracteres (de 1 a 99), comprueba su validez numérica, efectúa la conversión a entero para actualizar las existencias de almacén y despliega el total resultante en formato texto.

INCLUDE Irvine32.inc

.data

; Rótulos para interacción con el usuario en terminal
msgIngresoDatos BYTE "Ingrese las unidades recibidas: ", 0
msgCadenaInvalida BYTE "El programa solo acepta cadenas entre 1 y 99.", 0dh, 0ah, 0
msgResultado BYTE "Unidades Actuales: ", 0

; Buffer de entrada para la lectura con ReadString
bufferInput BYTE 10 DUP(0)

; Variables para almacenamiento numérico y control de inventario
cantidadRecibida DWORD ?
existenciaInicial DWORD 25
existenciaActual DWORD ?

; Buffer para armar la cadena decimal que se mostrará al usuario
bufferOutput BYTE 12 DUP(0)

.code
main PROC

IngresarDatos:
	mov edx, OFFSET msgIngresoDatos ; Imprime la solicitud de unidades
	call WriteString

	mov edx, OFFSET bufferInput ; Carga en EDX el puntero al buffer receptor
	mov ecx, 9 ; Límite de caracteres a capturar
	call ReadString ; Realiza la lectura del texto; almacena longitud en EAX

	; Comprobación del tamaño de la cadena leída
	cmp eax, 2 ; Verifica que no se hayan ingresado más de 2 caracteres
	ja MostrarError ; Si la longitud sobrepasa 2, salta a la sección de error

	cmp eax, 0 ; Verifica que no se haya presionado enter vacío
	je MostrarError ; Si no hay caracteres leídos, salta a error

	mov ecx, eax ; Asigna la longitud de la cadena al contador ECX
	mov esi, 0 ; Inicializa el puntero de lectura en 0
	mov edx, 0 ; Limpia EDX para usarlo como acumulador del valor numérico

ConvertirCadena:
	mov al, bufferInput[esi] ; Obtiene el carácter de la posición actual
	cmp al, '0' ; Asegura que no sea inferior al código de '0'
	jb MostrarError
	cmp al, '9' ; Asegura que no sea superior al código de '9'
	ja MostrarError

	sub al, '0' ; Resta '0' para obtener el valor numérico del dígito

	imul edx, edx, 10 ; Multiplica el acumulador EDX por 10 para desplazar las decenas
	add dl, al ; Agrega las nuevas unidades al acumulador

	inc esi ; Pasa al siguiente byte de la cadena
	loop ConvertirCadena ; Continúa el bucle mientras queden caracteres pendientes

	; Valida que la cantidad calculada se encuentre en el rango de 1 a 99
	cmp edx, 1
	jb MostrarError
	cmp edx, 99
	ja MostrarError

	mov cantidadRecibida, edx ; Guarda el valor entero capturado en memoria

	; Suma el valor capturado a la existencia previa (25)
	mov eax, existenciaInicial
	add eax, cantidadRecibida
	mov existenciaActual, eax ; Almacena el inventario total actualizado

	mov edx, OFFSET msgResultado ; Muestra el texto del resultado
	call WriteString

	mov eax, existenciaActual ; Prepara el total de existencias en EAX para convertirlo a texto
	mov edi, OFFSET bufferOutput ; Puntero al buffer de salida donde se guardará la cadena
	call ConvertirDecimalToString ; Llama a la subrutina para traducir el número a caracteres ASCII

	mov edx, OFFSET bufferOutput ; Apunta EDX al texto recién formateado
	call WriteString ; Imprime en consola las unidades actualizadas
	call Crlf

	exit

MostrarError:
	mov edx, OFFSET msgCadenaInvalida ; Notifica al usuario que el dato es inválido
	call WriteString
	jmp IngresarDatos ; Regresa a pedir nuevamente la cantidad

main ENDP

ConvertirDecimalToString PROC ; Procedimiento para transformar el entero en EAX a cadena ASCII en [EDI]
	; Guarda registros en la pila para preservar su contenido
	push eax
	push ebx
	push ecx
	push edx

	mov ecx, 0 ; Inicializa el conteo de dígitos en 0
	mov ebx, 10 ; Base 10 utilizada para la extracción de dígitos

ExtraerDigitos:
	mov edx, 0 ; Limpia EDX antes de ejecutar la división
	div ebx ; Divide entre 10: EAX cociente, EDX residuo
	add dl, '0' ; Traduce el residuo numérico a su carácter ASCII correspondiente
	push dx ; Guarda el carácter en la pila para invertir el orden al extraer
	inc ecx ; Incrementa el total de dígitos encontrados
	cmp eax, 0 ; Verifica si el cociente quedó en cero
	jne ExtraerDigitos ; Mientras EAX sea mayor a cero, sigue extrayendo dígitos

GuardarEnBuffer:
	pop dx ; Recupera cada carácter de la pila en orden directo
	mov [edi], dl ; Escribe el dígito en la posición actual del buffer
	inc edi ; Avanza el apuntador destino EDI
	loop GuardarEnBuffer ; Itera para cada dígito desapilado

	mov byte ptr [edi], 0 ; Coloca el carácter nulo terminador al final

	; Restaura los registros preservados
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret ; Retorna al procedimiento principal
ConvertirDecimalToString ENDP

END main
