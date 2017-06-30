section .data
	msg1:	db "rm ",0
	len1:	equ $-msg1
section .bss
	a:	resb 100
	len2:	equ $-a
section .text
	global main
main:	
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
inputFile:
	mov eax,3
	mov ebx,0
	mov ecx,a
	mov edx,len2
	int 80h	
	mov byte[ecx+eax -1],0
delete:
	mov eax,10
	mov ebx,a
	int 80h
exit:
	mov eax,1
	xor ebx,ebx
	int 80h
