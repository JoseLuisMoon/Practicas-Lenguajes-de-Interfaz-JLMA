; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 6.1. Control de Estacionamiento
; Descripción: Administra el flujo de un estacionamiento sumando ingresos y restando egresos de vehículos, deteniendo la operación en el instante en que el cupo llega al límite de 10 autos.

INCLUDE Irvine32.inc

.data
    ; Cadenas de texto para interacción con el usuario
    msgInicial BYTE "Ingrese 1 (entra) o 2 (sale): ", 0
    msgEntrada BYTE "Un vehiculo ha ingresado", 0
    msgSalida BYTE "Un vehiculo ha salido", 0
    msgFull BYTE "El estacionamiento esta lleno", 0
    msgInvalido BYTE "Opcion no valida. Intente de nuevo.", 0

    limiteEstacionamiento = 10 ; Límite fijado para el aforo máximo de autos

.code
main PROC
    mov ebx, 0 ; Registro EBX utilizado para contabilizar los vehículos presentes

FlujoEstacionamiento:
    call Crlf 
    mov edx, OFFSET msgInicial ; Imprime el menú de opciones para entrada o salida
    call WriteString
    call ReadInt ; Lee el número introducido y lo asigna a EAX

    ; Evaluación de las acciones posibles: salida (2) o entrada (1)
    cmp eax, 2
    je vehiculoSale

    cmp eax, 1
    je vehiculoEntra

    ; Manejo de entradas no reconocidas distintas de 1 o 2
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf
    jmp FlujoEstacionamiento ; Regresa al inicio del bucle del estacionamiento

vehiculoEntra:    
    inc ebx ; Incrementa en una unidad el total de autos presentes
    mov edx, OFFSET msgEntrada ; Informa el ingreso de un coche
    call WriteString
    call Crlf
    
    cmp ebx, limiteEstacionamiento ; Revisa si se completó la capacidad del estacionamiento
    je estLleno ; Si el límite de 10 fue alcanzado, salta a estLleno

    jmp FlujoEstacionamiento ; Si aún queda aforo libre, solicita la siguiente acción

vehiculoSale:
    ; Valida que el estacionamiento contenga autos antes de restar
    cmp ebx, 0
    jle noHayAutos ; Si no hay vehículos dentro (EBX <= 0), omite la resta

    dec ebx ; Decrementa el total de autos en una unidad
    mov edx, OFFSET msgSalida ; Notifica que un automóvil ha salido
    call WriteString
    call Crlf

noHayAutos:
    jmp FlujoEstacionamiento ; Vuelve al menú para capturar otra acción

estLleno:
    call Crlf
    mov edx, OFFSET msgFull ; Muestra el aviso de cupo completo y sale
    call WriteString
    call Crlf

    exit
main ENDP

END main
