;Name:Aniket Bable
;Roll No:203701

section .data
msg db "Enter 2 digit number",10
msglen equ $-msg
msg1 db "Number converted",10
msglen1 equ $-msg1

section .bss
num resb 4

%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .text
	global _start

	_start:
		rw 1,1,msg,msglen
		rw 0,0,num,3
	
	mov rsi,num
	mov rcx,2
	mov rax,0
     up:rol al,4
	mov bl,[rsi]
	cmp bl,39h
	jbe down
	sub bl,07h
   down:sub bl,30h
	add al,bl
	inc rsi
	dec rcx
	jnz up

rw 1,1,msg1,msglen1

mov rax,60
mov rdi,0
syscall

;Output:
;ibm@ibm17:~$ nasm -f elf64 Assignment2.asm
;ibm@ibm17:~$ ld -o Assignment2 Assignment2.o
;ibm@ibm17:~$ ./Assignment2
;Enter 2 digit number
;12
;Number converted

