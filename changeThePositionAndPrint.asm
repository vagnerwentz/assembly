.model SMALL
.stack 100H

.data
CR equ 0DH
LF equ 0AH
scanfMsgA db CR, LF, 'Entre com a coordenada x: ', '$'
scanfMsgB db CR, LF, 'Entre com a coordenada y: ', '$'
resultMsg db 'Alo Mundo!', '$'
entradaInvalidaMsg db CR, LF, 'Entrada invalida', '$' 
inputA  db 20 dup ('$')
inputB  db 20 dup ('$')
tmpA dd 0
tmpB dd 0

; ax, bx, cx, dx
.code
	;inicializando o registrador DS
	mov ax, @data
	mov ds, ax ;DS inicializado
	
	xor ax, ax

;tratamento inputA
printaScanfMsgA:
	lea dx, scanfMsgA
	mov ah, 9 ;9 = print string
	int 21h ;call	

scanfA:
	xor ax, ax
	xor dx, dx
	lea dx, inputA
	mov ah, 0Ah ;scanf string
	int 21h
	
prepareConvertInputAtoInt:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx

	add bl, 2 ;offset word
	jmp convertInputAToInt
	
preparaConsertaNumeroA:
	mov cl, inputA+1
	dec cl
	sub cl, ch
	mov al, 1
	
consertaNumeroA:
	cmp cl, 0
	jle posConsertoNumeroA
	
	mov ah, 10
	mul ah
	dec cl
	jmp consertaNumeroA
	
posConsertoNumeroA:
	inc ch
	mul dl
	xor dx, dx
	mov dx, tmpA
	add dx, ax
	mov tmpA, dx

convertInputAToInt:	
	mov dl, inputA+bx
	
	cmp dl, 0Dh ;checa fim de string
	je resetaTudo
	
	sub dl, 48 ;converte char pra inteiro
	
	cmp dl, 0
	jl printaEntradaInvalida
	
	cmp dl, 9
	jg printaEntradaInvalida
	
	inc bl ;incrementa offset
	
	jmp preparaConsertaNumeroA
	
resetaTudo:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
	
;tratamento inputB
printaScanfMsgB:
	lea dx, scanfMsgB
	mov ah, 9 ;9 = print string
	int 21h ;call	

scanfB:
	xor ax, ax
	xor dx, dx
	lea dx, inputB
	mov ah, 0Ah ;scanf string
	int 21h
	
prepareConvertInputBtoInt:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx

	add bl, 2 ;offset word
	jmp convertInputBToInt
	
preparaConsertaNumeroB:
	mov cl, inputB+1
	dec cl
	sub cl, ch
	mov al, 1
	
consertaNumeroB:
	cmp cl, 0
	jle posConsertoNumeroB
	
	mov ah, 10
	mul ah
	dec cl
	jmp consertaNumeroB
	
posConsertoNumeroB:
	inc ch
	mul dl
	xor dx, dx
	mov dx, tmpB
	add dx, ax
	mov tmpB, dx

convertInputBToInt:	
	mov dl, inputB+bx
	
	cmp dl, 0Dh ;checa fim de string
	je verificaValores
	
	sub dl, 48 ;converte char pra inteiro
	
	cmp dl, 0
	jl printaEntradaInvalida
	
	cmp dl, 9
	jg printaEntradaInvalida
	
	inc bl ;incrementa offset
	
	jmp preparaConsertaNumeroB
	
verificaValores:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
	mov bx, tmpA
	mov cx, tmpB
	
	mov dx, 0DH ;print CR
	mov ah, 02h ;print char
	int 21h
	mov dx, 10 ;print \n
	mov ah, 02h ;print char
	int 21h

printaCoordenadasY:
	cmp cx, 0
	jle printaCoordenadasX	
	mov dx, 0DH ;print CR
	mov ah, 02h ;print char
	int 21h
	mov dx, 10 ;print \n
	mov ah, 02h ;print char
	int 21h
	dec cx
	jmp printaCoordenadasY	

printaCoordenadasX:
	cmp bx, 0
	jle printaResultado
	mov dx, 20h ;space
	mov ah, 02h ;print
	int 21h
	dec bx
	jmp printaCoordenadasX

;resultados	
printaResultado:
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	
	jmp fim

printaEntradaInvalida:
	lea dx, entradaInvalidaMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	
fim:    
	mov ah, 4ch
	int 21h
	
	int 20h ;exit
	
end