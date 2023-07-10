include "emu8086.inc"
.model small
.stack 100h
.data
    n db ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;taking input
    print "Enter a number (0 to 9) : "
    mov ah, 1
    int 21h
    mov n, al    ; al = 3, n = 3
    sub n, 48
    call newline
    
    ; check for 2
    cmp n, 2         ; is n==2?
    je prime
    ;check for 0 and 1
    cmp n, 2
    jl notprime
    
    ; chcking for others
    ;mov cx, 0       ; 
    mov cl, n	; cl = 8
    dec cl   ; cl = 7
    myloop:
        mov al, n
        mov ah, 0
        div cl
        
        cmp ah, 0 ; remainder 0 means not prime
        je notprime
        
        cmp cl, 2
        je prime
        
        loop myloop
        
    
    
    
    prime:
        printn "This number is prime. "
        jmp exit
    
    notprime:
        printn "This number is not prime. "
        jmp exit
    
    exit:
        ;return 0
        mov ah, 4ch
        int 21h
        main endp

newline proc
    mov dl, 0ah
    mov ah, 2
    int 21h
    mov dl, 0dh
    int 21h
    ret
    newline endp
end main