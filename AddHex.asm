; Array Addition of HEX Nos 
; Input: array size, No. of elements in hex. (2 digit nos. is input)
; Output: Addition of the nos in hex form displayed

;data declaration initialised data or constants

section .data
	welmsg db 'Welcome to MIT lab assignment 03',10
	welmsg_len equ $-welmsg	
	msg db 'Enter two digits of Array size:',10
	msglen equ $-msg
	msg1 db 'Enter two digits of elements of Array:',10
	msglen1 equ $-msg1
	msg2 db 'Array is::',10
	msglen2 equ $-msg2
	msg3 db 10,'Array Addition is:'
	msglen3 equ $-msg3
	array times 80 db 0   
	nwln db 10
	
section .bss
	cnt resb 2	          ;used as counters
	cnt1 resb 2
	cnt2 resb 2	
	numascii resb 03
	dispbuff resb 8
	resultl resb 01
	resulth resb 01
        cnt3 resb 2
	

%macro rw 4		     ; to read and write 
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro


section .text

global _start
_start:
	rw 1,1,welmsg,welmsg_len
	rw 1,1,msg,msglen	
	rw 0,0,numascii,3	        ;accept array size
	call packnum		        ;seperating digits and forming the number
	
        mov [cnt],bl		       ; counter used in performing operations
	mov [cnt1],bl
	mov [cnt2],bl
        
        rw 1,1,msg1,msglen1	        ; msg to accept array elements
        mov rdi,array 	        	; making edi point to the base address
arr1:   
        push rdi                        ;push rdi(array address) onto stack as it is used in accepting number
     	rw 0,0,numascii,3		; accepting array elements
        mov rsi,numascii
    	call packnum			;seperating the digits to form the num
        pop rdi                         ;pop rdi(array address) from stack
        mov [rdi],bl 			; saving the number          
        inc rdi 			; getting the next number of array
    	dec byte[cnt] 		        ; till ctr is zero accept (for array size)
    	cmp byte[cnt],0
	jne arr1
	
        rw 1,1,msg2,msglen2
	mov rsi,array	         	; displaying the saved contents
arr2:	
	mov bh,[rsi]			;getting the first num in bh
	mov bl,0			 
	mov rcx,02
        push rsi	           ;push rsi(array address) onto stack as it is used in disp-proc for displaying number		
	call disp16_proc		;call display to display the num formed
        pop rsi                         ;pop rsi(array address) from stack
	inc rsi
	dec byte[cnt1]
	cmp byte[cnt1],0
	jne arr2

	rw 1,1,msg3,msglen3
	mov rsi,array     		;add the array elements and display the result
        mov byte[resultl],0
        mov byte[resulth],0
arr3:	mov bl,[rsi]			;get the first number
	add [resultl],bl			;add to resl 
	adc byte [resulth],0		;add along with the carry and save the result in resh 
	inc rsi				;get next num
	dec byte[cnt2]			; perform addition till counter is zero
	cmp byte[cnt2],0
	jnz arr3

	mov bl,[resultl]			; display the addition
	mov bh,[resulth]
	mov rcx,04
	call disp16_proc

	mov rax,60		;Exit
	mov rdi,0
	syscall

packnum:
        mov rbx,0	
	mov rcx,2		;since the num is saved as 
up1:
	rol bl,04		;say 12 num is saved as 31 and 32, we want 1 and 2 to be added and saved, so
				; bl is used for that purpose (shifting 1 and adding 2 to it)
	mov al,[rsi]		; in 1st iteration 31 is taken and 1 is seperated 
	cmp al,39h		; ascii for 0 to 9 is 31 to 39 and A-F is 41 to 46H
				;comparing with 39 tells no is between 0 to 9 so sub 30 else sub 37
	jbe skip1
	sub al,07h	
skip1:	sub al,30h
	add bl,al		; bl will in 1st iteration have only 1 
	inc rsi			; take next value i.e say 32     
        loop up1
ret	


disp16_proc:
	mov rdi,dispbuff	; lets say we want to display 12 now, so we need to display 31 and 32
dup11:
	rol bx,4		; rotating bx will make 1 come to lsb i.e in bl; 2nd iteration will take digit 2
	mov al,bl		; move 1 to al
	and al,0fh		; anding will seperate 1
	cmp al,09		;comparing with 1 will telll us that it is between 0 and 9
	jbe dskip1
	add al,07h		; if the no was abouve 9 then add 7
dskip1:	add al,30h		; so just add 30 and display
	mov [rdi],al		; save the num to edi
	inc rdi			; increment edi to point to next add
	loop dup11		; carry the same process for 2nd digit
	rw 1,1,dispbuff,8
	rw 1,1,nwln,1
	ret
	
	
