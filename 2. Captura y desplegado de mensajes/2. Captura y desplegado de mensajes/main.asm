; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 2. Captura y desplegado de mensajes
; Descripción: Pide el nombre del usuario por teclado, lo almacena en un arreglo en memoria y luego imprime tanto el texto introducido como el total de caracteres leídos.

INCLUDE Irvine32.inc
.data
mensaje BYTE "Escribe tu nombre: ", 0 ; Mensaje para pedir la entrada del usuario
nombre BYTE 30 DUP(0) ; Espacio reservado para almacenar el texto ingresado
caracteresEscritos BYTE "Caracteres escritos: ", 0 ; Texto explicativo para mostrar la cantidad de caracteres leídos

.code
main PROC

; Imprime la petición en la terminal
 mov edx, OFFSET mensaje
 call WriteString

 mov edx, OFFSET nombre ; Carga en EDX la dirección del arreglo receptor  
 mov ecx, SIZEOF nombre ; Tamaño máximo que puede recibir el buffer

 call ReadString ; Lee la entrada del teclado; el número de caracteres queda en EAX 

 ; Muestra la información que se guardó en el buffer
 mov edx, OFFSET nombre ; Coloca en EDX la dirección de la cadena almacenada
 call WriteString ; Despliega el nombre ingresado
 call Crlf ; Salto de renglón
 
; Imprime el total de caracteres ingresados
 mov edx, OFFSET caracteresEscritos ; Carga la dirección del mensaje para el conteo
 call WriteString
 call WriteDec ; Escribe el número decimal guardado en EAX

 exit


main ENDP


END main
