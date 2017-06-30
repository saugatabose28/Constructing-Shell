section .data
	msg:	dd "%d",10,0	
	msg1:	db "cat>",0
	length:	equ $-msg1
	
section .bss
	a	resb 100
	len1	equ $-a
	b 	resd 1
	c 	resb 100
	len2	equ $-c
section .txt
	global main
	extern puts,printf
main:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,length
	int 80h
start:		
	mov eax,3
	mov ebx,0
	mov ecx,a
	mov edx,len1
	int 80h
	mov byte[ecx+eax -1],0

	mov eax,5
	mov ebx,a
	mov ecx,0101q	
	mov edx,1c0h
	int 80h
	
	cmp eax,0
	jge inputAndWrite
	jmp errorSegment

inputAndWrite:
	mov [b],eax	

	mov eax,3
	mov ebx,0
	mov ecx,c
	mov edx,len2
	int 80h

	mov edx,eax
	mov eax,4
	mov ebx,[b]
	mov ecx,c
	int 80h

	pusha
	push eax
	push msg
	call printf
	add esp,8
	popa
	
	jmp done
	
errorSegment:

	jmp done
done:	
	mov eax, 1 
	xor ebx, ebx 
	int 80h 
