; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 4.1. Mayor, menor o igual con entrada del usuario
; Descripción: Lee dos números introducidos por el usuario, los evalúa con CMP y utiliza saltos condicionales (JE, JL) para indicar si el primero es mayor, menor o igual al segundo.

INCLUDE Irvine32.inc

.data
; Textos para solicitar los datos numéricos
msgIngresar1 BYTE "Ingresa el primer valor: ", 0
msgIngresar2 BYTE "Ingresa el segundo valor: ", 0
; Textos que muestran la relación entre los valores leídos
msgMayor   BYTE "El primer numero es mayor.", 0
msgMenor   BYTE "El primer numero es menor.", 0
msgIguales BYTE "Los numeros son iguales.", 0

.code
main PROC

    mov edx, OFFSET msgIngresar1 ; Muestra la petición para ingresar el primer número
    call WriteString 
    call ReadInt ; Lee el número del usuario y lo guarda en EAX
    mov ecx, eax ; Guarda el valor del primer número en ECX temporalmente

    mov edx, OFFSET msgIngresar2 ; Muestra la petición para ingresar el segundo número
    call WriteString 
    call ReadInt ; Lee el segundo valor ingresado
    mov ebx, eax ; Mueve el segundo dato al registro EBX
    
    mov eax, ecx ; Restaura el primer dato en EAX para poder compararlo

    cmp eax, ebx ; Realiza la comparación entre el primer valor (EAX) y el segundo (EBX)

    je iguales ; Se bifurca a 'iguales' si ambos números tienen el mismo valor
    jl menor ; Salta a 'menor' si el primer número es estrictamente menor al segundo

    ; En caso de que no sea menor ni igual, el primero resulta ser mayor
    mov edx, OFFSET msgMayor ; Prepara en EDX el mensaje correspondiente a primer número mayor
    call WriteString
    jmp fin ; Salto incondicional a la etiqueta de finalización

iguales:
    mov edx, OFFSET msgIguales ; Despliega el texto informando que los datos son iguales
    call WriteString
    jmp fin

menor:
    mov edx, OFFSET msgMenor ; Despliega el texto informando que el primer valor es menor
    call WriteString

fin: 
    call Crlf ; Salto de renglón de cierre
    exit

main ENDP
END main
