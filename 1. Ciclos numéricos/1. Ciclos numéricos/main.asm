; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 1. Ciclos numéricos
; Descripción: Muestra en pantalla una cuenta regresiva del 5 al 1 haciendo uso de la directiva loop.

INCLUDE Irvine32.inc

.data
.code
main PROC
    mov ecx, 5 ; Establece en 5 el registro contador ECX para controlar la instrucción loop

ciclo:
    mov eax, ecx ; Pasa el valor del contador ECX a EAX para poder imprimirlo
    
    call WriteDec ; Imprime en pantalla el valor decimal almacenado en EAX
    call Crlf ; Realiza un salto de línea en consola
    loop ciclo ; Resta 1 a ECX y salta a la etiqueta 'ciclo' si ECX no ha llegado a cero
    
    exit
main ENDP
END main
