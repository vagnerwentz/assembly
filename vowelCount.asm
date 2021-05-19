.model SMALL
.stack 100H

.data
CR equ 0DH
LF equ 0AH
scanfMsg db CR, LF, 'Digite alguma palavra: ', '$'
resultMsg db CR, LF, 'Quantidade de vogais: ', '$'
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
	mov al, input+1
	
iniciaInputOffset:
	xor cx, cx ; vogal Counter	
	xor bx, bx ; offset
	add bl, 2
	jmp contaVogal
	
proximaLetra:
	dec al ;input len
	cmp al, 0
	je printaResultMsg
	
	inc bl
	jmp contaVogal
	
incrementaCounter:
	inc cx
	jmp proximaLetra
	
contaVogal:
	mov dl, input+bx
	
	cmp dl, 'a'
	je incrementaCounter
	
	cmp dl, 'A'
	je incrementaCounter
	
	cmp dl, 'e'
	je incrementaCounter
	
	cmp dl, 'E'
	je incrementaCounter
	
	cmp dl, 'i'
	je incrementaCounter	
	
	cmp dl, 'I'
	je incrementaCounter

	cmp dl, 'o'
	je incrementaCounter
	
	cmp dl, 'O'
	je incrementaCounter		
	
	cmp dl, 'u'
	je incrementaCounter	
	
	cmp dl, 'U'
	je incrementaCounter	
	
	jmp proximaLetra
		
printaResultMsg:
	lea dx, resultMsg
	mov ah, 9 ;9 = print string
	int 21h ;call	
	
printaVogaisLen:
	xor ax, ax
	xor dx, dx
	
	mov dl, cl
	add dx, 48
	
	mov ah, 2 ;2 = print char
	int 21h ;call	
	
fim:
	xor ax, ax

	mov ah, 4ch
	int 21h
	
	int 20h ;exit
	
end