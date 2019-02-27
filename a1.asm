%macro rw 4 
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
val db 15h,22h

section .bss
val2 resb 3

section .text
global _start
_start:
mov cl,2
mov esi,val
mov edi,val2
up:mov al,byte[esi]
rol al,4
mov bl,al
and al,0Fh
add al,30h

mov byte[edi],al
inc edi
inc esi
dec cl
jnz up

rw 1,1,val2,2
rw 60,0,0,0

;mov byte[edi],20h

