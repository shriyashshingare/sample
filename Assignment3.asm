section .data
menumsg db 10, "1.ENTER A STRING"
        db 10, "2.LENGTH OF STRING"
        db 10, "3.PALINDROM"
        db 10, "4. EXIT"
        db 10, "ENTER YOUR CHOICE :"
menumsglen equ $-menumsg

msg1 db "enter your string :",10
msg1len equ $-msg1

msg2 db "entered string is :",10
msg2len equ $-msg2

msg3 db "it is palindrome!!! ",10
msg3len equ $-msg3

msg4 db "it is not palindrome!! ",10
msg4len equ $-msg4
 
msg5 db "length of the string is :",10
msg5len equ $-msg5

section .bss
len resb 1
str1 resb 20
choice resb 2
cnt resb 1

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


rw 1,1,menumsg,menumsglen
rw 0,0,choice,2
cmp byte[choice],31h
je l1

cmp byte[choice],32h
je l2

cmp byte[choice],33h
je l3

cmp byte[choice],34h
je exit
jmp exit

l1:rw 1,1,msg1,msg1len
   rw 0,0,str1,20
   dec rax
   mov [len],rax
   mov [cnt],rax
   rw 1,1,msg2,msg2len
   rw 1,1,str1,[len]
   jmp _start
   
l2: 
    add byte[len],30h
    rw 1,1,msg5,msg5len
    rw 1,1,len,1
    jmp _start
 
l3: 
    mov rsi,str1
    mov rdi,str1
    ll1:inc rdi
        dec byte [len]
        jnz ll1
        dec rdi
      
    up1: mov al,[rsi]
         cmp al,[rdi]
         je ll2
         rw 1,1,msg4,msg4len
         jmp _start
         
         
    ll2: inc rsi
         dec rdi
         dec byte[cnt]
         jnz up1
         rw 1,1,msg3,msg3len
         jmp _start
         jmp exit         


exit: mov rax,60
      mov rdi,0
      syscall
      
;OUTPUT

;c04l0514@c04l0514:~$ nasm -f elf64 a3.asm
;c04l0514@c04l0514:~$ ld -o a3 a3.o
;c04l0514@c04l0514:~$ ./a3

;1.ENTER A STRING
;2.LENGTH OF STRING
;3.PALINDROM
;4. EXIT
;ENTER YOUR CHOICE :1
;enter your string :
;abcba
;entered string is :
;abcba

;1.ENTER A STRING
;2.LENGTH OF STRING
;3.PALINDROM
;4. EXIT
;ENTER YOUR CHOICE :2

;length of the string is :
;5
;1.ENTER A STRING
;2.LENGTH OF STRING
;3.PALINDROM
;4. EXIT
;ENTER YOUR CHOICE :3

;it is palindrome!!! 

    
      
