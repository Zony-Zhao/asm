;macro-a.asm  	 		
extrn make1:far               		
public x                        		
include macro.mac              		

dataseg segment 
x dw 0
mess1 db 0dh,0ah,'input HEX=$'
mess2 db 0dh,0ah,'out dec=$'
dectab db '0123456789'
dataseg ends

stackseg segment stack   		
	dw 100h dup(0)
	top dw ?                       	
stackseg ends

codeseg segment para'code'           	
assume cs:codeseg,ds:dataseg,ss:stackseg
start:
	mov ax,dataseg
	mov ds,ax
	mov ax,stackseg                 	
	mov ss,ax
	mov sp,offset top                  

make0 proc far
	mov x,0
	display mess1                    	
	mov bx,0
	call make1                    	
	call make2                    	
	jmp make0
make0 endp


make2 proc
	display mess2                    	
	mov ax,x                       	
	mov dx,0
	divis 10000                     	
	divis 1000                    	
	divis 100                        	
	divis 10
	divis 1
	ret
make2 endp

codeseg  ends
end start                       