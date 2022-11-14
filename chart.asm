DATAS SEGMENT
    CRLF db 13,10,'$'
    number dw ?,?,?,?     ;存放乘数和被乘数
    buf db ?,?,?,?        ;缓存转换出来的数字
      
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV 　　AX,DATAS
    MOV 　　DS,AX
    
    mov　　 cx,9            　;外层循环9次
  s1:
    mov 　　[number],cx       ;存放乘数
    push　　cx                ;保存外层计数
    push 　cx                 ;乘数进栈
      
   s2:                    　　;内层循环，循环次数由外层循环来决定
   
       ;显示乘数
       mov     dx,[number]        
       add     dx,30h            ;转换到ASCII
       mov     ah,2
       int     21h
       
       ;显示x号
       mov     dl,78h        
       mov     ah,2
       int     21h

       ;显示第二个乘数
       mov     [number+1],cx        
       push     cx            　　;第二个乘数进栈
       mov     dx,cx
       add     dx,30h
       mov     ah,2
       int     21h

       ;显示=号
       mov     dl,3dh                
       mov     ah,2
       int     21h
       
       ;计算两数相乘的结果，并显示
       pop     dx            　　;取出第二个乘数
       pop     ax            　　;取出第一个乘数
       push     ax            　 ;第一个乘数再次进栈，在下次内层循环中推出再次使用

       ;想直接用内存单元里面放的数据来相乘，但是结果不对
       ;所以最后用栈存放乘数再取出解决了问题
       ;调试发现第二个乘数[number+1]中的值是对的，但是[number]中的值不对
       ;很疑惑的是上面打印[number]的值显示结果正确
       ;那为什么在下面的指令中使用值就不对了呢?
       ;mov   dx,[number]
       ;mov   ax,[number+1]
       
       mul     dx        　　;相乘，结果在AX中
           
       mov     bx,10        ;准备除以10
       mov     si,2         ;循环2次，最大到十位 (乘法表最大为81,所以最大到十位)
   
      
  toDec:                　　  ;把各个位转换为数值，如ax中的81，转换为 8,1存在内存中
      mov     dx,0        
      div     bx        　　  ;除10法得到各个位上的数值
      mov     [buf+si],dl    ;余数为该位上的值，第一次循环为个位，第二次为十位...；存到内存中
      dec     si            
      cmp     ax,0        　　;商是否为0，为0算法结束
      ja toDec
  
      
  output:                　　　;输出内存中存放的转换数值数
      inc     si
      mov     dl,[buf+si]
      add     dl,30h          ;转为ascii
      mov     ah,2
      int     21h
      cmp     si,2
      jb     output    
       
      
       mov     dl,20h
       mov     ah,2
       int     21h
  
   loop     s2                ;内层循环结束
           
       lea     dx,crlf        ;输出回车换行
       mov     ah,9
       int     21h

       pop     cx
       pop     cx             ;还原外层计数
       
  loop     s1        
    
    mov     ah,1              ;停留等待结束
    int     21h
    
    MOV     AH,4CH
    INT     21H
CODES ENDS
    END START