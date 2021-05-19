.model SMALL
.stack 100H

.data
espaco db ' ', '$'
x db 5
y db 1
soma db 0
subtracao db 0

; ax, bx, cx, dx
.code
	;inicializando o registrador DS
	mov ax, @data
	mov ds, ax ;DS inicializado
	
	xor ax, ax
	;x = x + 2
	mov al, x
	add al, 2
	mov x, al
	
	;soma = x + y
	mov bl, y
	add bl, al
	mov soma, bl
	
subtrai:
	;x = x - 3
	sub al, 3
	mov x, al
	
	;sub = x - y
	mov bl, y
	sub	al, bl
	mov subtracao, al

printaSubRes:
	xor dx, dx
	mov dl, subtracao	
    add dx, 48
    mov ah, 2 ;2 = print char
    int 21h	;call

printaEspaco:
	xor ax, ax
	xor dx, dx
	lea dx, espaco
	mov ah, 9 ;9 = print string
	int 21h ;call
	
printaSomaRes:
	xor dx, dx
	mov dl, soma	
    add dx, 48
    mov ah, 2 ;2 = print char
    int 21h	;call
	
fim:
	xor ax, ax

	mov ah, 4ch
	int 21h
	
	int 20h ;exit
	
end