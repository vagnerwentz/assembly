.model SMALL

.stack 100h ; 100h: Pilha aguenta 256 caracteres.

.data
x DB 41h; A variável x é do tipo byte DB(Define Byte 1 byte - 16 bits), código ASC 41h que é a letra A.
y DW 42h; DW (Define word 2 byte - 32 bits) 42h é a letra B.
z DB 43h; 43h é a letra C. 

.code
mov ax, @data; O @data tem o data segment 
mov ds, ax; E aqui estou jogando o registrador ax dentro de ds, 
          ; não posso usar diretamente o ds, @data, o ds só aceita de registrador pra registrador

mov ah,02h
mov dl,30h
mov cx,000Ah
REPEAT:
    int 21h
    add dl, 01h
    loop REPEAT
int 20h
end