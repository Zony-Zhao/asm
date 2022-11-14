assume cs:code
code segment
    date: db 9,8,7,4,2,0
    blank: db '// ::'
    start:      mov ax,cs
                mov ds,ax
                
                mov bx,0B800H
                mov es,bx
                mov bl,02H
                mov di,160*12+40*2
                mov si,offset date
                mov cx,6
    showdate:   push cx
                mov al,[si]
                out 70H,al
                in al,71H
                
                mov ah,al
                mov cl,4
                shr ah,cl
                and al,00001111B
                
                add ah,30H
                add al,30H
                
                mov byte ptr es:[di],ah
                mov byte ptr es:[di+1],bl
                mov byte ptr es:[di+2],al
                mov byte ptr es:[di+3],bl

            
                add di,6
                inc si
                pop cx
                loop showdate
    
                mov di,160*12+40*2
                mov si,offset blank
                mov cx,5
    showblank:  push cx
                
                mov al,[si]
                mov byte ptr es:[di+4],al
                mov byte ptr es:[di+5],bl
                
                add di,6
                inc si
                pop cx
                loop showblank
                
            mov ax,4c00h
            int 21H
            
    code ends
    end start