; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 5. Condicionales
; Descripción: Ilustra la implementación de estructuras de control repetitivas equivalentes a bucles WHILE y DO-WHILE, generando un listado numérico del 1 al 100 con cada método.

INCLUDE Irvine32.inc
.data
    ; Rótulos para identificar cada una de las estructuras repetitivas
    msgWhile BYTE "Ciclo While", 0 
    msgDoWhile BYTE "Ciclo Do While", 0
.code
main PROC

    mov edx, OFFSET msgWhile ; Imprime el encabezado para el bucle While
    call WriteString
    call Crlf

    mov ebx, 1 ; Establece el contador EBX en 1 para la primera iteración

cicloWhile:
    cmp ebx, 100 ; Evalúa si EBX llegó al límite de 100

    jg finWhile ; Si EBX es mayor a 100, interrumpe el ciclo saltando a finWhile
    
    mov eax, ebx
    call WriteDec ; Muestra el número actual en la pantalla
    call Crlf ; Inserta un salto de línea

    inc ebx ; Suma 1 al contador EBX
    jmp cicloWhile ; Vuelve a evaluar la condición del ciclo While
finWhile:
    call Crlf ; Espacio de separación entre ambas demostraciones

    mov edx, OFFSET msgDoWhile ; Imprime el encabezado para la sección Do-While
    call WriteString
    call Crlf

    mov ebx, 1 ; Reinicia el contador EBX a 1

cicloDoWhile:

    mov eax, ebx
    call WriteDec ; Despliega el valor del contador
    call Crlf

    inc ebx ; Incrementa EBX en 1
    cmp ebx, 100 ; Revisa al final de la iteración si EBX aún no excede de 100

    jle cicloDoWhile ; Continúa el ciclo Do-While si el valor de EBX es menor o igual a 100

    exit
main ENDP

END main
