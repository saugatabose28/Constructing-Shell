section .data
	msg:	dd "%d",10,0
	msg1:	db "cat ",0
	length1:equ $-msg1
	msg2:	db "hi",0,10	
	
section .bss
	a	resb 100
	len1:	equ $-a
	b:	resb 100
	len2:	equ $-b
	c resd 1
section .text
	global main
	extern printf
main:
	push ebp
	mov ebp,esp

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,length1
	int 80h
start:
	mov eax,3
	mov ebx,0
	mov ecx,a
	mov edx,len1
	int 80h
	mov byte[ecx+eax -1],0
open:	
	mov eax,5
	mov ebx,a
	mov ecx,0q
	mov edx,01c0h		
	int 80h	

	cmp eax,0
	jge read_write
	jmp exit
	
read_write:
	
	mov ebx,eax
	mov eax,3
	mov ecx,b
	mov edx,len2
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,b
	mov edx,len2
	int 80h
	
	jmp exit
exit:
	mov ebp,esp
	pop ebp
	ret
