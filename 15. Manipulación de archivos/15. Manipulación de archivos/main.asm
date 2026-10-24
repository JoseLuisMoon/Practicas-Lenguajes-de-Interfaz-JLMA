; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 15. Manipulación de archivos
; Descripción: Crea en almacenamiento secundario el archivo "Inventario.txt", graba en él el texto "125" y cierra el handle liberando el descriptor con control de errores en cada fase.

INCLUDE Irvine32.inc

.data 

nombreArchivo BYTE "Inventario.txt", 0 ; Nombre del fichero que se creará en el sistema
texto BYTE "125", 0 ; Texto que se va a guardar dentro del fichero
archivoHandle DWORD ? ; Almacena el identificador (handle) asignado por el sistema operativo

; Avisos para reportar el resultado de la operación
mensajeExito BYTE "Archivo guardado correctamente",0
mensajeError BYTE "No se pudo guardar el archivo", 0

.code
main PROC

; Paso 1: Creación del fichero
mov edx, OFFSET nombreArchivo ; Carga en EDX el puntero con el nombre del fichero
call CreateOutputFile ; Solicita crear el archivo; EAX recibe el descriptor resultante

cmp eax, INVALID_HANDLE_VALUE ; Comprueba si el handle devuelto corresponde a un error
je error ; Salta al bloque de error si no se pudo crear el fichero

mov archivoHandle, eax ; Guarda el handle obtenido en la variable archivoHandle

; Paso 2: Escritura del contenido en el fichero
mov eax, archivoHandle ; Coloca el handle del archivo en el registro EAX
mov edx, OFFSET texto ; Asigna en EDX el puntero a la cadena de texto a escribir
mov ecx, SIZEOF texto-1 ; Define la cantidad exacta de bytes sin incluir el terminador nulo
call WriteToFile ; Graba los datos en el fichero; EAX recibe los bytes escritos

jc errorEscritura ; Si la bandera CF se enciende, indica falla durante la escritura

cmp eax, SIZEOF texto-1 ; Verifica que la cantidad de bytes escritos coincida con la solicitada
jne errorEscritura ; Si no se escribieron todos los bytes, salta al manejo de error

; Paso 3: Cierre del fichero y liberación de recursos
mov eax, archivoHandle ; Carga nuevamente el handle del archivo en EAX
call CloseFile ; Invoca el cierre del fichero liberando sus recursos

test eax, eax ; Revisa con TEST si el valor retornado por el SO fue 0 (fallo)

jz error ; Salta a error si la llamada de cierre devolvió 0

mov edx, OFFSET mensajeExito ; Muestra el mensaje confirmando el guardado exitoso
call WriteString
jmp fin ; Salta al final del programa habiendo completado la tarea

errorEscritura: ; Manejo de excepciones en la fase de escritura
	mov eax, archivoHandle ; Recupera el descriptor del archivo
	call CloseFile ; Cierra el archivo abierto para evitar fugas de recursos

error: ; Despliega el mensaje de fallo en las operaciones de archivo
	mov edx, OFFSET mensajeError ; Carga el mensaje de error para el usuario
	call WriteString

fin: ; Fin del procedimiento principal
	exit
main ENDP

END main
