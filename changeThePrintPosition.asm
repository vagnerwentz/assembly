.model SMALL

.stack 100h ; 100h: Pilha aguenta 256 caracteres.

.data
character DB 41h; character tem a letra A.
x DB 10
y DB 15

.code
mov ax, @data
mov ds, ax

mov dl, x
mov dh, y
mov ah, 02h 
mov bx, 0
int 10h

mov dl, 41h
int 21h
int 20h
end