; Alumno: Jose Luis Montoya Albarez
; Docente: Dr. José Luis Medina Jiménez
; Materia: Lenguajes de Interfaz
; Horario: 10:00 - 11:00
; Práctica: Práctica 12. Desplazamiento y rotación
; Descripción: Estudio de instrucciones de corrimiento lógico y aritmético (SHL, SHR, SAR) y rotaciones con y sin acarreo (ROL, ROR, RCL, RCR), tanto con valores inmediatos como utilizando el registro CL.

INCLUDE Irvine32.inc

.code 
main PROC 
	mov eax, 0        ; Limpia a cero el registro EAX

	; 1 - INSTRUCCIÓN SHL: CORRIMIENTO LÓGICO HACIA LA IZQUIERDA
	; Desplaza bits a la izquierda introduciendo ceros por la derecha; el bit saliente entra a CF
	mov al, 00000110b ; Asigna en AL el número binario 00000110b (6 en decimal)
	shl al, 1         ; Desplaza 1 posición hacia la izquierda (multiplica el valor por 2)
	
	call DumpRegs     ; Imprime los registros y banderas en consola
	call WriteBin     ; Escribe el patrón binario de AL
	call Crlf         ; Salto de renglón

	; 2 - INSTRUCCIÓN SHR: CORRIMIENTO LÓGICO HACIA LA DERECHA
	; Mueve bits hacia la derecha rellenando con ceros por la izquierda (datos sin signo)
	mov al, 00001100b ; Asigna en AL el número binario 00001100b (12 en decimal)
	shr al, 1         ; Desplaza 1 posición a la derecha (equivale a dividir entre 2 sin signo)
	
	call DumpRegs     ; Muestra el estado actual de los registros
	call WriteBin     ; Imprime el valor resultante en binario
	call Crlf

	; 3 - INSTRUCCIÓN SAR: CORRIMIENTO ARITMÉTICO A LA DERECHA (CONSERVANDO SIGNO)
	; Desplaza bits a la derecha manteniendo el bit de signo (MSB) para preservar números negativos
	mov al, -8        ; Asigna el valor signado -8 en AL
	sar al, 1         ; Desplaza 1 bit a la derecha preservando el signo (división entera de -8 / 2)
	
	call DumpRegs     ; Despliega registros y banderas
	call WriteBin     ; Imprime la secuencia binaria
	call Crlf

	; 4 - DESPLAZAMIENTOS MEDIANTE UN VALOR INMEDIATO CONSTANTE
	; Se indica directamente la cantidad fija de bits a desplazar
	mov al, 00001100b ; Carga 00001100b en AL (12 en decimal)
	shl al, 2         ; Desplaza 2 posiciones a la izquierda (multiplica por 4)

	call DumpRegs     ; Vuelca registros y banderas
	call WriteBin     ; Imprime el resultado en base binaria
	call Crlf

	; 5 - DESPLAZAMIENTO MEDIANTE EL REGISTRO CONTADOR CL
	; Emplea el registro CL para indicar de forma dinámica el número de corrimientos
	mov al, 00010100b ; Carga 00010100b (20 decimal) en AL
	mov cl, 2         ; Especifica en CL la cantidad de desplazamientos deseada (2)
	shr al, cl        ; Aplica el corrimiento a la derecha según el valor en CL

	call DumpRegs     ; Despliega el estado de registros y banderas
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 6 - INSTRUCCIÓN ROL: ROTACIÓN HACIA LA IZQUIERDA SIN BANDERA DE ACARREO
	; Los bits que desbordan por la izquierda ingresan nuevamente por el extremo derecho
	mov al, 00000011b ; Asigna el patrón 00000011b (3 decimal) en AL
	rol al, 1         ; Rota 1 bit a la izquierda; el bit 7 pasa a la posición 0 y a la bandera CF
	
	call DumpRegs     ; Muestra el estado de la CPU (AL = 00000110b, CF = 0)
	call WriteBin     ; Muestra el contenido binario
	call Crlf

	; 7 - INSTRUCCIÓN ROR: ROTACIÓN HACIA LA DERECHA SIN ACARREO
	; Los bits que desbordan por la derecha recirculan e ingresan por el extremo izquierdo
	mov al, 11000000b ; Carga el valor 11000000b (C0h) en AL
	ror al, 1         ; Rota 1 bit hacia la derecha; el bit 0 pasa a la posición 7 y a CF
	
	call DumpRegs     ; Muestra el estado de la CPU (AL = 01100000b, CF = 0)
	call WriteBin     ; Muestra el contenido en binario
	call Crlf

	; 8 - INSTRUCCIÓN RCL: ROTACIÓN A LA IZQUIERDA INCLUYENDO ACARREO
	; El bit 7 ingresa a la bandera CF, y el acarreo anterior entra por el bit 0
	mov al, 10100000b ; Asigna un valor con el bit más significativo encendido
	rcl al, 1         ; Rota a la izquierda incorporando el estado previo de CF por la derecha
	
	call DumpRegs     ; Vuelca registros y flags (CF = 1)
	call WriteBin     ; Despliega la cadena de bits resultante
	call Crlf

	; 9 - INSTRUCCIÓN RCR: ROTACIÓN A LA DERECHA INCLUYENDO ACARREO
	; El bit 0 pasa a la bandera CF, y el valor que tenía CF ingresa por el bit 7
	mov al, 00000101b ; Carga un valor con el bit 0 en 1
	rcr al, 1         ; Rota hacia la derecha pasando el bit 0 a CF e introduciendo el acarreo previo en el bit 7
	
	call DumpRegs     ; Vuelca registros y flags (CF = 1)
	call WriteBin     ; Despliega la cadena de bits resultante
	call Crlf

	exit

main ENDP

END main
