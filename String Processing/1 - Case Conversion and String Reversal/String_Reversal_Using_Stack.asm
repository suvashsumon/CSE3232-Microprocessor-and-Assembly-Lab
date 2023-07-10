.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the input string : $"
    outmsg DB "After conversion : $"

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
    INT 21H
    
    MOV CX,0
    
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_INPUT
        
        PUSH AX ; stack 16-bit howai ax push kora lagbe
        INC CX
        JMP INPUT
    END_INPUT:
    
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,09H
    INT 21H
    
    CALL NEW_LINE
    JCXZ EXIT   ;if cx=0, means input size is 0, then control transfer to EXIT
    
    OUTPUT: 
        POP DX
        ;MOV AH,2
        INT 21H
        LOOP OUTPUT   ;execution of the LOOP instruction causes CX to be decremented autometically 
    
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