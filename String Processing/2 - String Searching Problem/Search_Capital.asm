.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the input string : $"
    firstcapmsg DB "First capital = $"
    lastcapmsg DB "Last capital = $"
    nocapmsg DB "No Capitals. $"
    
    FIRST DB "["
    LAST DB "@"
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
              
    LEA DX,inpmsg          
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    MOV DI,0
    
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_INPUT
        
        CMP AL,'A'
        JGE LESS_Z
        
        JMP INPUT
        
        LESS_Z:
            CMP AL,'Z'
            JLE CHECK_F
            JMP INPUT
            
            CHECK_F:
                CMP AL,FIRST
                JL F_UPDATE
                JMP CHECK_L
            CHECK_L:
                CMP AL,LAST
                JG L_UPDATE
                JMP INPUT
                
            F_UPDATE:
                MOV FIRST,AL
                JMP CHECK_L
            L_UPDATE:
                MOV LAST,AL
                JMP INPUT 
            
        
    END_INPUT:
    
    CALL NEW_LINE
    
    CMP FIRST,'['
    JE NO_CAP
    
    ;printing first capital   
    LEA DX,firstcapmsg
    MOV AH,09H
    INT 21H
            
    MOV DL,FIRST
    MOV AH,2
    INT 21H
            
    CALL NEW_LINE 
    
    ;printing last capital
    LEA DX,lastcapmsg
    MOV AH,09H
    INT 21H
            
    MOV DL,LAST
    MOV AH,2
    INT 21H
            
    JMP EXIT 
    
    NO_CAP:
    
        LEA DX,nocapmsg
        MOV AH,09H
        INT 21H
    
    EXIT:
        MOV AH,4CH
        INT 21H

MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN
        