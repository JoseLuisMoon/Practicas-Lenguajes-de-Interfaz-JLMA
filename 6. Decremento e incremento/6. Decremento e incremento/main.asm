; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 6. Decremento e incremento
; Descripción: Simula un sistema de seguridad por PIN que otorga tres intentos mediante decrementos continuos, concediendo o denegando el ingreso según la clave proporcionada.

INCLUDE Irvine32.inc
.data
	; Mensajes informativos y de respuesta para la consola
	msgPIN BYTE "Ingrese el PIN: ", 0
	msgIntentos BYTE "Intentos restantes: ", 0
	msgError BYTE "PIN incorrecto.", 0
	msgAcceso BYTE "Acceso permitido", 0
	msgBloqueado BYTE "Autodestruccion comenzada...", 0

	pinCorrecto = 1234 ; PIN definido como correcto para la autenticación

.code
	main PROC
	mov ebx, 3 ; Configura el contador de intentos permitidos en 3 (EBX)

intentar: ; Etiqueta de inicio de validación
	; Despliega la petición y captura el PIN numérico
	mov edx, OFFSET msgPIN
	call WriteString
	call ReadInt

	cmp eax, pinCorrecto ; Compara el PIN introducido (EAX) con el valor correcto
	je acceso ; Si coinciden, salta a la sección de acceso concedido

	mov edx, OFFSET msgError ; Prepara el mensaje de contraseña equivocada
	call WriteString
	call Crlf

	dec ebx ; Decrementa en 1 el contador de intentos restantes

	jz bloqueado ; Si el contador llega a cero (ZF=1), pasa a la etiqueta bloqueado

	mov edx, OFFSET msgIntentos ; Muestra el rótulo de intentos disponibles
	call WriteString

	mov eax, ebx
	call WriteDec ; Imprime el total de oportunidades que aún quedan
	call Crlf

	jmp intentar ; Repite la solicitud de PIN

acceso: ; Sección de éxito en la autenticación
	mov edx, OFFSET msgAcceso ; Imprime el aviso de bienvenida o autorización
	call WriteString
	call crlf ; Salto de línea
	jmp fin ; Va directo a la terminación del programa

bloqueado:
	mov edx, OFFSET msgBloqueado ; Imprime la advertencia de sistema bloqueado
	call WriteString
	call Crlf ; Salto de línea
	jmp fin ; Va directo a la terminación del programa

fin: ; Final del programa
	exit
main ENDP

END main
