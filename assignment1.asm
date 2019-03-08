section .data
arr db 05h,10h,01h,09h,04h
section .bss
result resb 15
section .text
global _start
_start:
mov ch,05h
outer:
mov esi,arr
mov cl,04h
inner:
mov al,byte[esi]
cmp al,byte[esi+1]
jbe down
xchg al,byte[esi+1]
mov byte[esi],al
down:
inc esi
dec cl
jnz inner
dec ch
jnz outer


mov esi,arr
mov edi,result
mov ch ,05h
outer2:
mov cl,2
nextDigit:
mov al,byte[esi]manjusha
rol al,4
mov bl,al
and al,0fh
cmp al,09manjusha
jbe down1
add al,07
down1:
add al,30h
mov byte[edi],al
mov al,bl
inc edi
dec cl
jnz nextDigit
mov byte[edi],20h
dec ch
jnz outer2
mov rax,60h
mov rdi,0h
syscall
