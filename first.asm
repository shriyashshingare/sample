
section .data
arr db 05h,10h,01h,09h,04h

section .text
global _start
_start:
mov rax,1
mov rdi,1
mov rsi,arr
mov rdx,5
syscall

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

mov rax,1
mov rdi,1
mov rsi,arr
mov rdx,5
syscall
mov rax,60h
mov rdi,0h
syscall





