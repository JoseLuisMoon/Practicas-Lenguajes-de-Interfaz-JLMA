; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 7. Validación de formato de cadena
; Descripción: Comprueba que una cadena ingresada coincida con el patrón de 3 mayúsculas iniciales, un guion intermedio y 3 números finales, revisando tamaño y caracteres paso a paso.

INCLUDE Irvine32.inc

.data
    msgInicio BYTE "Ingrese una cadena: ", 0
    msgLongitud BYTE "La longitud de la cadena no es de 7 caracteres.", 0
    msgLetras BYTE "La cadena no cumple con la cantidad de 3 letras mayusculas al inicio.", 0
    msgSeparador BYTE "La cadena no cumple con el formato de un separador en la posicion 4.", 0
    msgDigitos BYTE "La cadena no cumple con la cantidad de 3 digitos al final.", 0
    msgCadenaValida BYTE "La cadena cumple con el formato deseado.", 0

    buffer BYTE 20 DUP(0) ; Espacio en memoria para recibir el texto del teclado

.code
main PROC

solicitarCadena:
    call Crlf ; Espaciado de línea en la consola
    
    mov edx, OFFSET msgInicio ; Pide el texto al usuario
    call WriteString

    mov edx, OFFSET buffer ; Puntero al buffer asignado
    mov ecx, SIZEOF buffer ; Tamaño máximo aceptado para prevenir sobreescrituras
    call ReadString ; Lee los caracteres; EAX recibe el total introducido

    ; Etapa 1: Comprobar que contenga exactamente 7 caracteres
    cmp eax, 7
    jne longitudInvalida ; Salta al error de longitud si el tamaño no es 7

    ; Etapa 2: Examinar que el cuarto elemento sea el delimitador '-'
    mov al, buffer[3]
    cmp al, '-' ; Evalúa si la posición 3 corresponde a un guion
    jne separadorInvalido ; Si no contiene un guion, se desvía a separadorInvalido

    ; Etapa 3: Asegurar que los primeros 3 elementos sean letras mayúsculas ('A'-'Z')
    mov esi, 0 ; Inicializa el índice ESI en 0
    mov ecx, 3 ; Contador en 3 para recorrer los primeros tres caracteres

corroborarLetras:
    mov al, buffer[esi] ; Carga el carácter correspondiente en AL
    cmp al, 'A' ; Compara con el extremo inferior 'A'
    jb letrasInvalidas ; Si está por debajo de 'A', es incorrecto
    cmp al, 'Z' ; Compara con el extremo superior 'Z'
    ja letrasInvalidas ; Si supera a 'Z', es incorrecto

    inc esi ; Incrementa el índice del arreglo
    loop corroborarLetras ; Itera el ciclo decreciendo ECX hasta llegar a cero

    ; Etapa 4: Asegurar que las últimas 3 posiciones sean dígitos ('0'-'9')
    mov esi, 4 ; Posiciona el índice en el carácter 4 (iniciando los dígitos)
    mov ecx, 3 ; Contador en 3 repeticiones

cicloDigitos:
    mov al, buffer[esi] ; Carga el carácter en AL para su análisis
    cmp al, '0' ; Comprueba contra el límite inferior '0'
    jb digitosInvalidos ; Si el valor ASCII es menor a '0', es inválido
    cmp al, '9' ; Comprueba contra el límite superior '9'
    ja digitosInvalidos ; Si el valor ASCII es mayor a '9', es inválido

    inc esi ; Desplaza el puntero al siguiente byte
    loop cicloDigitos ; Decrementa ECX y continúa con la verificación

    ; Notificación desplegada tras superar todas las comprobaciones con éxito
    mov edx, OFFSET msgCadenaValida
    call WriteString
    call Crlf
    jmp fin ; Salta a la conclusión del flujo

; RUTINAS PARA EL DESPLIEGUE DE ERRORES
longitudInvalida:
    mov edx, OFFSET msgLongitud
    call WriteString
    call Crlf
    jmp solicitarCadena ; Regresa a solicitar un nuevo texto

separadorInvalido:
    mov edx, OFFSET msgSeparador
    call WriteString
    call Crlf
    jmp solicitarCadena

letrasInvalidas:
    mov edx, OFFSET msgLetras
    call WriteString
    call Crlf
    jmp solicitarCadena

digitosInvalidos:
    mov edx, OFFSET msgDigitos
    call WriteString
    call Crlf
    jmp solicitarCadena

fin:
    exit
main ENDP
END main
