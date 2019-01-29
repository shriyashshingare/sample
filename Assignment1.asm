;Name:Aniket Bable
;Roll No:203701

section .data
msg1 db "Enter Name" ,10
msg1len equ $-msg1
newline1 db 10

msg2 db "Enter Roll no." ,10
msg2len equ $-msg2
newline2 db 10

msg3 db "Enter Class" ,10
msg3len equ $-msg3
newline3 db 10

section .bss
name resb 20
roll resb 10
class resb 10

section .text
global _start
_start:

mov rax, 1
mov rdi, 1
mov rsi, msg1
mov rdx, msg1len
syscall


mov rax, 0
mov rdi, 0
mov rsi, name
mov rdx, 20
syscall


mov rax, 1
mov rdi, 1
mov rsi, msg2
mov rdx, msg2len
syscall

mov rax, 0
mov rdi, 0
mov rsi, roll
mov rdx, 10
syscall

mov rax, 1
mov rdi, 1
mov rsi, msg3
mov rdx, msg3len
syscall

mov rax, 0
mov rdi, 0
mov rsi, class
mov rdx, 10
syscall

mov rax, 1
mov rdi, 1
mov rsi, name
mov rdx, 20
syscall

mov rax, 1
mov rdi, 1
mov rsi, roll
mov rdx, 10
syscall


mov rax, 1
mov rdi, 1
mov rsi, class
mov rdx, 10
syscall

mov rax, 60
mov rdi, 0
syscall

;OutPut:
;c04l0514@c04l0514:~$ nasm -f elf64 Assignment1.asm
;c04l0514@c04l0514:~$ ld -o Assignment1 Assignment1.o
;c04l0514@c04l0514:~$ ./Assignment1
;Enter Name
;Aniket Bable
;Enter Roll no.
;203701
;Enter Class
;Sy Btech
;Aniket Bable
;203701
;Sy Btech

