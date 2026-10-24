; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 10. Obtención de una cadena decimal
; Descripción: Monitorea el progreso de descarga de un archivo de 100,000 bytes procesando 125 bloques de 512 bytes; determina bytes recibidos, restantes, bloques de 1024 con sobrante y porcentaje, convirtiendo cada valor a cadena ASCII con una rutina personalizada.

INCLUDE Irvine32.inc

.data
	; Mensajes descriptivos para la salida de datos en la consola
	msgInicio BYTE "Avance de la descarga:", 0 
	msgBytesDescargados BYTE "Bytes descargados: ", 0 
	msgBytesPendientes BYTE "Bytes pendientes: ", 0
	msgGruposCompletos BYTE "Grupos completos de 1024 bytes: ", 0 
	msgResiduo BYTE "Residuo de los agrupamientos: ", 0 
	msgPorcentaje BYTE "Porcentaje de avance de la descarga: ", 0

	; Variables numéricas para almacenar los cálculos de descarga
	bytesDescargados DWORD ? 
	bytesPendientes DWORD ?
	gruposCompletos DWORD ? 
	residuo DWORD ? 
	porcentajeDescarga DWORD ? 

	bufferConversion BYTE 11 DUP(0) ; Arreglo de 11 posiciones para construir la representación en texto de los números

.code
main PROC

	; Paso 1: Determinación de bytes descargados (125 bloques de 512 bytes cada uno)
	mov eax, 125 ; Total de paquetes recibidos
	mov ebx, 512 ; Bytes por cada paquete
	mul ebx ; Multiplica cantidad de bloques por bytes por bloque
	mov bytesDescargados, eax ; Guarda el total de bytes transferidos

	; Paso 2: Determinación de bytes faltantes (100,000 menos los descargados)
	mov eax, 100000 ; Tamaño completo del archivo en bytes
	sub eax, bytesDescargados ; Resta la cantidad que ya fue descargada
	mov bytesPendientes, eax ; Almacena los bytes pendientes por bajar

	; Paso 3: Agrupación en bloques de 1024 bytes y residuo
	mov eax, bytesDescargados ; Carga el volumen de bytes descargados
	mov edx, 0 ; Pone en cero EDX para la división de 64 bits
	mov ebx, 1024 ; Divisor fijado en 1024
	div ebx ; Divide EDX:EAX entre 1024
	mov gruposCompletos, eax ; Cociente: total de grupos íntegros de 1024 bytes
	mov residuo, edx ; Residuo: sobrante de bytes fuera de los grupos

	; Paso 4: Cálculo del porcentaje completado (descargados * 100 / 100000)
	mov eax, bytesDescargados ; Carga el acumulado de bytes descargados
	mov ebx, 100 ; Factor para calcular porcentaje
	mul ebx ; Multiplicación por 100
	mov ebx, 100000 ; Tamaño base para dividir
	div ebx ; División para hallar el porcentaje entero resultante
	mov porcentajeDescarga, eax ; Almacena el valor porcentual

	; IMPRESIÓN DE LA INFORMACIÓN EN PANTALLA
	mov edx, OFFSET msgInicio
	call WriteString
	call Crlf
	call Crlf

	; Muestra el total de bytes descargados
	mov edx, OFFSET msgBytesDescargados
	call WriteString 
	mov eax, bytesDescargados
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf

	; Muestra el conteo de bytes faltantes
	mov edx, OFFSET msgBytesPendientes
	call WriteString 
	mov eax, bytesPendientes
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf 

	; Muestra los paquetes enteros de 1024 bytes
	mov edx, OFFSET msgGruposCompletos
	call WriteString
	mov eax, gruposCompletos
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion 
	call WriteString 
	call Crlf

	; Muestra los bytes que quedaron como residuo
	mov edx, OFFSET msgResiduo
	call WriteString
	mov eax, residuo
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf 

	; Muestra el porcentaje calculado
	mov edx, OFFSET msgPorcentaje
	call WriteString
	mov eax, porcentajeDescarga
	mov esi, OFFSET bufferConversion
	call convertirDecimal
	mov edx, OFFSET bufferConversion
	call WriteString
	call Crlf

	exit
main ENDP

convertirDecimal PROC ; Procedimiento que transforma el número en EAX a una cadena ASCII guardada en ESI

	; Respalda los registros utilizados en la pila
	push eax
	push ebx 
	push ecx 
	push edx
	push esi 

	mov ecx, 0 ; Inicializa el registro contador de dígitos en 0

extraer_digitos:
	mov edx, 0 ; Pone a cero la parte alta para la división
	mov ebx, 10 ; Factor 10 para extraer el dígito menos significativo
	div ebx ; Divide entre 10 (EAX cociente, EDX residuo/dígito)
	push edx ; Apila el dígito obtenido para invertir el orden posteriormente
	inc ecx ; Aumenta la cuenta de caracteres a procesar
	cmp eax, 0 ; Evalúa si aún queda parte entera por descomponer
	jne extraer_digitos ; Si EAX no es cero, extrae el siguiente dígito

construir_cadena:
	pop edx ; Desapila cada dígito en orden correcto
	mov bl, dl ; Mueve el residuo a BL
	add bl, '0' ; Suma el código base '0' para obtener el carácter ASCII
	mov [esi], bl ; Deposita el carácter en el buffer de salida
	inc esi ; Avanza el apuntador en el arreglo
	loop construir_cadena ; Repite hasta agotar los dígitos en la pila

	mov byte ptr [esi], 0 ; Agrega el carácter nulo final a la cadena

	; Restaura los registros desde la pila
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret ; Retorna al código que invocó la función
convertirDecimal ENDP

END main
