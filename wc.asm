section .data
	msg:	dd "%d ",10,0
	msg1:	db "wc ",0
	length1:equ $-msg1
	msg2:	db " %s",0,10	
	
section .bss
	a:	resb 100
	len1:	equ $-a
	b:	resb 100
	len2:	equ $-b
	c resd 1
	d resb 100
	len3: 	equ $-d	
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
findLine:
	xor eax,eax
	mov eax,b
	xor edx,edx
	xor ecx,ecx
line:
	mov dl,byte[eax]
	cmp dl,0
	jne checkEOF1
	je findLength 
checkEOF1:
	inc eax
	cmp dl,10
	je lineInc
	jmp line
lineInc:
	inc ecx
	jmp line
findLength:
	
	push ecx
	push msg
	call printf
	add esp,8
	
	xor eax,eax
	mov eax,b
	xor edx,edx
	xor ecx,ecx
char:
	mov dl,byte[eax]
	inc ecx
	cmp dl,0
	je findWord	
	inc eax
	jmp char	
findWord:
	dec ecx
	push ecx
	push msg
	call printf
	add esp,8
	
	xor eax,eax
	mov eax,b
	xor edx,edx
	xor ecx,ecx
word1:
	mov dl,byte[eax]
	cmp dl,0
	jne checkEOF2
	je print 
checkEOF2:
	inc eax
	cmp dl,' '
	je wrdInc
	cmp dl,10
	je wrdInc
	jmp word1
wrdInc:
	inc ecx
	jmp word1
print:	
	push ecx
	push msg
	call printf
	add esp,8
	push a
	push msg2
	call printf
	add esp,8

	jmp exit
exit:
	mov ebp,esp
	pop ebp
	ret