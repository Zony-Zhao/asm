DATASEG  SEGMENT
        MSG       DB        'What is the date(mm/dd/yyyy)',3FH,07H,13,10,'$'
        DISP       DB        13,10,13,10,'The date is $'
        STRING  DB        100 DUP(0)  
DATASEG  ENDS
 
 
STACKSEG  SEGMENT STACK
              DW        128  DUP(0)
STACKSEG  ENDS
 
CODESEG  SEGMENT
ASSUME    CS:CODESEG, DS:DATASEG, SS:STACKSEG
START:
              MOV       AX, DATASEG
              MOV       DS, AX
              MOV       ES, AX
 
              LEA          DX, MSG
              MOV       AH, 9
              INT          21H         
 	
              MOV       AH, 2
              MOV       DL, 7
              INT          21H         ;;输出一个BEL字符，响铃字符\a，即07H
 
              MOV       BX, 0

      GETNUM:                            
              MOV       AH, 1
              INT         21H
              MOV       [STRING + BX], AL
              INC         BX
              CMP       AL, 0DH
              JZ           TOSTRING
              JMP        GETNUM
 
TOSTRING:
              MOV       [STRING + BX], '$'
 
    DISPLAY:
              LEA         DX,DISP	
              MOV       AH, 9
              INT         21H

              LEA          DX, STRING
              MOV       AH, 9
              INT          21H         
 
      PG_END:
              MOV       AX, 4C00H 
              INT          21H
CODESEG  ENDS 
END START
 