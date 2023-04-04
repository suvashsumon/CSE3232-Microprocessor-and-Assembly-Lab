.MODEL SMALL
.STACK 100H

.DATA 
    mainmsg DB "Enter the main string : $"
    submsg DB "Enter the sub string : $"
    found DB "Substring found.$"
    notfound DB "Substring not found.$"
      
    mainst DB 100 DUP ("$")
    subst DB 100 DUP ("$")

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,mainmsg
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    
    MAIN_ST:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_MAIN_ST
        
        MOV mainst[SI],AL
        INC SI
        JMP MAIN_ST
        
    END_MAIN_ST:
    
    CALL NEW_LINE 
    
    LEA DX,submsg
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    
    SUB_ST:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_SUB_ST
        
        MOV subst[SI],AL
        INC SI
        JMP SUB_ST
        
    END_SUB_ST:
    
    CALL NEW_LINE
    MOV SI,0
    
    CHECK:
        MOV DI,0
        PUSH SI
        
        FOR_LOOP:
            MOV AH,mainst[SI]
            MOV AL,subst[DI]
            INC SI
            INC DI
            CMP AL,'$'
            JE FOUND_MSG
            CMP AH,AL
            JE FOR_LOOP
            JMP UPDATE_SI
            
    UPDATE_SI:
        POP SI
        INC SI
        MOV AH,mainst[SI]
        CMP AH,'$'
        JE NOT_FOUND_MSG
        JMP CHECK
     
    FOUND_MSG:
        LEA DX,found
        MOV AH,09H
        INT 21H
        JMP EXIT   
        
    NOT_FOUND_MSG:
        LEA DX,notfound
        MOV AH,09H
        INT 21H
        JMP EXIT
    
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