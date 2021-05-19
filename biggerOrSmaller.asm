.model SMALL
.stack 100H

.data
CR equ 0DH
LF equ 0AH
scanfMsgA db CR, LF, 'Entre com o primeiro digito: ', '$'
scanfMsgB db CR, LF, 'Entre com o segundo digito: ', '$'
entradaInvalidaMsg db CR, LF, 'Entrada invalida', '$' 
resultMsg db CR, LF, 'Maior numero: ', '$'
resultIgualMsg db CR, LF, 'Os numeros sao iguais', '$'

; ax, bx, cx, dx
.code
	;inicializando o registrador DS
	mov ax, @data
	mov ds, ax ;DS inicializado
	
	xor ax, ax

printaScanfMsg:
	lea dx, scanfMsgA
	mov ah, 9 ;9 = print string
	int 21h ;call	

scanfA:
	mov ah, 1 ;1 = scanf character
	int 21h ;call
	mov cl, al
	sub cl, 48
	
verificaInteiroA:
	cmp cl, 0
	jl printaEntradaInvalida
	
	cmp cl, 9
	jg printaEntradaInvalida

printaScanfMsgB:
	lea dx, scanfMsgB
	mov ah, 9 ;9 = print string
	int 21h ;call	

scanfB:
	mov ah, 1 ;1 = scanf character
	int 21h ;call
	sub al, 48
	
verificaInteiroB:
	cmp al, 0
	jl printaEntradaInvalida
	
	cmp al, 9
	jg printaEntradaInvalida
	
compara:
	cmp cl, al
	je printaSaoIguais
	jg printaDigitoAMaior	
	jl printaDigitoBMaior
	
printaSaoIguais:
	lea dx, resultIgualMsg
	mov ah, 9 ;9 = print string
	int 21h ;call
	jmp fim

printaDigitoAMaior:
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	xor dx, dx
	
	mov dl, cl
	add dl, 48
	
	mov ah, 2 ;2 = print char
	int 21h ;call
	jmp fim
	
printaDigitoBMaior:
	mov cl, al
	
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	xor dx, dx
	
	mov dl, cl
	add dl, 48
	
	mov ah, 2 ;2 = print char
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