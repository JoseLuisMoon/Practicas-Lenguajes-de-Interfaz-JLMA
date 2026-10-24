; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 11. Operaciones lógicas
; Descripción: Práctica sobre manipulación de bits mediante AND, OR, XOR y TEST para enmascarar, habilitar, alternar y consultar banderas simulando el estado de una máquina y su alarma.

INCLUDE Irvine32.inc 

.data 
    ; Avisos para mostrar el estado actual de la alarma
    msgEncendida BYTE "alarma encendida", 0
    msgApagada   BYTE "alarma apagada", 0 

.code 
main PROC

    ; Convención de bits para el estado del equipo:
    ; Bit 0: Encendido/apagado del computador (1 = Encendido, 0 = Apagado)
    ; Bit 1: Estado de la alarma
    ; Bit 2: Estado de la conexión de red

    ; 1 - USO DE AND: Aislar y comprobar un bit determinado
    mov eax, 0 ; Limpia el acumulador EAX
    mov al, 00000111b ; Carga un valor de prueba en AL con varios bits encendidos
    and al, 00000010b ; Enmascara con AND binario para aislar únicamente el bit 1
    
    call WriteBin ; Muestra la representación binaria en consola
    call Crlf ; Salto de renglón
    nop ; Pausa nula para seguimiento con depurador

    ; 2 - USO DE OR: Encendido individual de bits sin afectar los demás
    mov eax, 0 ; Pone en cero el registro EAX
    mov al, 00000101b ; Estado inicial con equipo y red encendidos, alarma apagada
    or al, 00000010b ; Enciende el bit 1 aplicando una operación OR con 00000010b
    
    call WriteBin ; Imprime el valor resultante en formato binario
    call Crlf 
    nop 

    ; 3 - USO DE XOR: Inversión o alternancia de bits (efecto toggle)
    ; XOR invierte el valor de los bits donde la máscara tenga un 1
    mov eax, 0 ; Restablece el contenido de EAX
    mov al, 00000101b ; Configuración con bit 0 en estado 1
    
    xor al, 00000001b ; Invierte el bit 0 a 0 (simula apagar la máquina)
    call WriteBin ; Imprime el estado modificado
    call Crlf
    
    xor al, 00000001b ; Vuelve a invertir el bit 0 devolviéndolo a 1 (enciende de nuevo la máquina)
    call WriteBin ; Imprime el estado restaurado
    call Crlf
    nop 

    ; 4 - USO DE TEST: Verificación de bits sin alterar el contenido del operando
    ; La instrucción TEST realiza un AND sin modificar el registro, solo actualizando banderas
    mov al, 00000101b ; Establece el patrón de prueba en AL
    test al, 00000010b ; Inspecciona si el bit 1 se encuentra en 1
    
    jnz alarma_encendida ; Si la prueba no dio cero (ZF=0), salta a alarma_encendida
    
    ; Flujo a seguir cuando la alarma se encuentra desactivada
    mov edx, OFFSET msgApagada ; Carga el puntero del texto de alarma desactivada
    call WriteString ; Muestra el aviso en la consola
    call Crlf 
    jmp fin ; Salto incondicional al final

alarma_encendida: ; Flujo a seguir cuando la alarma se encuentra activa
    mov edx, OFFSET msgEncendida ; Carga el puntero del texto de alarma activa
    call WriteString 
    call Crlf 

fin:
    exit 

main ENDP 

END main
