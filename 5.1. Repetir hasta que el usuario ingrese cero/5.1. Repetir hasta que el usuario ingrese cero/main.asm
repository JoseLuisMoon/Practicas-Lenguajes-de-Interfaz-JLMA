; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 5.1. Repetir hasta que el usuario ingrese cero
; Descripción: Bucle interactivo que solicita enteros y los replica en la salida hasta detectar la entrada de un 0, momento en el cual concluye la ejecución.

INCLUDE Irvine32.inc
.data
    msgIngresar  BYTE "Ingrese un numero (en caso de querer terminar el programa ingresar 0): ", 0
    msgFinal   BYTE "El programa ha finalizado al ingresar 0", 0
.code
main PROC

ciclo:
    mov edx, OFFSET msgIngresar ; Muestra el mensaje solicitando el ingreso de datos
    call WriteString 
    call ReadInt ; Lee un número entero desde el teclado y lo guarda en EAX

    cmp eax, 0 ; Evalúa si el número capturado en EAX es igual a 0
    je terminar ; Si el valor es 0, rompe el ciclo y salta a la rutina de cierre

    call WriteInt ; Despliega en pantalla el entero introducido
    call Crlf ; Agrega un salto de línea
    jmp ciclo ; Salta de vuelta al inicio de la etiqueta 'ciclo' para una nueva lectura

terminar:
    mov edx, OFFSET msgFinal ; Muestra el aviso informativo de fin de programa
    call WriteString
    call Crlf

    exit
main ENDP

END main
