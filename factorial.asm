.model SMALL
.stack 100H

.data
CR equ 0DH
LF equ 0AH
scanfMsg db CR, LF, 'Entre com um inteiro entre 0 e 7: ', '$'
entradaInvalidaMsg db CR, LF, 'Entrada invalida', '$' 
resultMsg db CR, LF, 'Fatorial: ', '$'

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

scanfA:
	mov ah, 1 ;1 = scanf character
	int 21h ;call
	mov cl, al
	sub cl, 48
	
verificaInteiro:
	cmp cl, 0
	jl printaEntradaInvalida
	je printaUm
	
	cmp cl, 7
	jg printaEntradaInvalida
	
preparaFatorial:
	xor ax, ax
	xor dx, dx
	xor ch, ch
	add ax, 1 ;var fat
	jmp loopFatorial
	
subLoopFatorial:
	sub cx, 1
	
loopFatorial:
	mul cx
	cmp cx, 1
	jg subLoopFatorial

printaFatorialMsg:
	mov cx, ax
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	

preparaConversao:
	mov ax, cx
	xor cx, cx
    xor dx, dx
	
converte:
    cmp ax, 0
    je printaConversao   
	
    mov bx, 10        
    div bx                  
    push dx                      
    inc cx              
    xor dx,dx
    jmp converte
	
printaConversao:
    cmp cx, 0
    je fim
	
    pop dx
    add dx, 48 ;int to char
    mov ah, 02h ;print char
    int 21h

    dec cx
    jmp printaConversao
	
printaUm:
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	xor dx, dx
    add dx, 49 ;int to char
    mov ah, 02h ;print char
    int 21h
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