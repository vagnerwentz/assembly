.model SMALL
.stack 100H

.data
CR equ 0DH
LF equ 0AH
scanfMsg db CR, LF, 'Digite um numero decimal: ', '$'
resultadoNegativoMsg db CR, LF, 'Resultado: numero negativo! ', '$'
resultadoPositivoMsg db CR, LF, 'Resultado: numero positivo! ', '$'
resultadoNeutroMsg db CR, LF, 'Resultado: numero Neutro! ', '$'
entradaInvalidaMsg db CR, LF, 'Entrada invalida', '$' 
input  db 200 dup ('$')

; ax, bx, cx, dx
.code
	;inicializando o registrador DS
	mov ax, @data
	mov ds, ax ;DS inicializado
	
	xor ax, ax

printaScanfMsg:
	lea dx, scanfMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	

scanf:
	xor ax, ax
	xor dx, dx
	lea dx, input
	mov ah, 0Ah
	int 21h
	xor ax, ax
	mov al, input+1 ;inputLen
	
iniciaInputOffset:
	xor dx, dx
	xor bx, bx ; offset
	add bl, 2

verifica:
	mov dl, input+bx
	cmp dl, '0'
	je printaResultadoNeutro
	
	cmp dl, '-'
	je preAvancaNeg
	
	cmp dl, '+'
	je preAvancaPosComSinal
	
	jmp verificaNumero
	
avancaPos:
	inc bl
	dec al
	cmp al, 0
	je printaResultadoPositivo

verificaNumero:
	mov dl, input+bx
	sub dl, 48

	cmp dl, 0
	jl printaEntradaInvalida
	
	cmp dl, 9
	jg printaEntradaInvalida

	jmp avancaPos

preAvancaPosComSinal:
	mov dl, input+3
	cmp dl, '0'
	je printaResultadoNeutro

	dec al
	inc bl
	jmp verificaNumeroPosComSinal

avancaPosComSinal:
	inc bl
	dec al
	cmp al, 0
	je printaResultadoPositivo

verificaNumeroPosComSinal:
	mov dl, input+bx
	sub dl, 48

	cmp dl, 0
	jl printaEntradaInvalida
	
	cmp dl, 9
	jg printaEntradaInvalida

	jmp avancaPosComSinal

preAvancaNeg:
	mov dl, input+3
	cmp dl, '0'
	je printaResultadoNeutro
	
	dec al
	inc bl
	jmp verificanumeronegativo

avancaNeg:
	inc bl
	dec al
	cmp al, 0
	je printaResultadoNegativo

verificaNumeroNegativo:
	mov dl, input+bx
	sub dl, 48

	cmp dl, 0
	jl printaEntradaInvalida
	
	cmp dl, 9
	jg printaEntradaInvalida

	jmp avancaNeg

printaResultadoNegativo:
	lea dx, resultadoNegativoMsg
	mov ah, 9 ;9 = print string
	int 21h ;call
	jmp fim

printaResultadoPositivo:
	lea dx, resultadoPositivoMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	jmp fim

printaResultadoNeutro:
	lea dx, resultadoNeutroMsg
	mov ah, 9 ;9 = print string
	int 21h ;call
	jmp fim
	
printaEntradaInvalida:
	lea dx, entradaInvalidaMsg
	mov ah, 9 ;9 = print string
	int 21h ;call		

fim:
	xor ax, ax

	mov ah, 4ch
	int 21h
	
	int 20h ;exit
	
end