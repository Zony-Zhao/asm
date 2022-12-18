; macro-b.asm 		
public make1                   	
extrn x:word                    	
include macro.mac               	

codeseg segment  
	assume cs:codeseg

make1 proc far                	
	inc bx
	cmp bx,4                 	
	jg exit
	input                   	
	cmp al,0dh             
	jz exit
	cmp al,'0'                 
	jl out1                     
	cmp al,'9'
	jle smal1
	cmp al,'A'
	jl out1
	cmp al,'F'
	jle smal2
	cmp al,'a'
	jl out1
	cmp al,'f'
	jg out1
	sub al,20h         	
	smal2:           	
	sub al,7        
	smal1:         	
	sub al,30h
	mov ah,0        
	xchg ax,x           	
	mov cx,16
	mul cx    
	add x,ax            	
	jmp make1
	exit:ret
out1:
	retsys                      

make1 endp
codeseg ends
end                           