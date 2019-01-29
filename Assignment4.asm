;Name:Aniket Bable
;Roll No:203701

section .data
menumsg db"*****string operation*****"
        db"1:Enter string",10
        db"2:Display the string",10
        db"3:Length of the string",10
        db"4:To check if the string is a palindrome",10
        db"5:exit",10
        db"6:Exit the program",10
menumsglen equ $-menumsg

msg1 db "enter the string",10
msglen1 equ $-msg1

msg2 db "the entered string is:",10
msglen2 equ $-msg2

msg3 db "the length of the string is:",10
msglen3 equ $-msg3

msg4 db "the string is a palindrome",10
msglen4 equ $-msg4

msg5 db "the given string is not a palindrome",10
msglen5 equ $-msg5

msg6 db "exit the program",10
msglen6 equ $-msg6

nwln db 10


section .bss
strlen1 resb 2
str1 resb 30
str2 resb 30
choice resb 3
cnt resb 3

%macro rw 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
syscall
%endmacro

section .text
global _start
_start:

rw 1,1, menumsg,menumsglen
rw 0,0, choice,2
cmp byte[choice],'1'
je l1
cmp byte[choice],'2'
je l2
cmp byte[choice],'3'
je l3
cmp byte[choice],'4'
je exit

l1:
  rw 1,1,msg1,msglen1
  rw 0,0,str1,10
  dec rax
  mov byte[strlen1],al
  mov byte[cnt],al
  rw 1,1,msg2,msglen2
  rw 1,1,str1,[cnt]
  rw 1,1,nwln,1
  jmp _start
  
l2:
  rw 1,1,msg3,msglen3
  add byte[strlen1] ,30h
  rw 1,1,strlen1,1
  rw 1,1, nwln,1
  jmp _start
l3:
    mov rsi,str1
    mov rdi,str1
    mov cx,[cnt]
    
l31:
    inc rdi
    dec cx
    jnz l31
    dec rdi
    
l32: 
    mov al,[rsi]
    cmp al,[rdi]
    je l33
    rw 1,1,msg5,msglen5
    jmp _start
    
l33:
    inc rsi
    dec rdi
    dec byte[cnt]
    jnz l32
    rw 1,1,msg4,msglen4
    jmp _start
    
exit:     
     rw 1,1,msg6,msglen6
     
	mov rax,60
	mov rdi,0
	syscall
	
	
	
	output
	c04l0509@c04l0509:~$ nasm -f elf64 Assignment4.asm
c04l0509@c04l0509:~$ ld -o assignment4  Assignment4.o
c04l0509@c04l0509:~$ ./Assignment4
*****string operation*****1:Enter string
2:Display the string
3:Length of the string
4:To check if the string is a palindrome
5:exit
6:Exit the program
1
enter the string
Aniket
the entered string is:
Aniket
*****string operation*****1:Enter string
2:Display the string
3:Length of the string
4:To check if the string is a palindrome
5:exit
6:Exit the program
3
the given string is not a palindrome
*****string operation*****1:Enter string
2:Display the string
3:Length of the string
4:To check if the string is a palindrome
5:exit
6:Exit the program
2
the length of the string is:
6
*****string operation*****1:Enter string
2:Display the string
3:Length of the string
4:To check if the string is a palindrome
5:exit
6:Exit the program
4
exit the program

