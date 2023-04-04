.model small
.stack 100h
.data
    inpmsg db "Enter N : $"
    oddmsg db "The number is odd $"
    evenmsg db "The number is even $"
    n db ?
    d db 2
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; taking input
    lea dx, inpmsg
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    sub al, 48
    
    ; checking odd even
     
    check:
          div d       ; al = result, ah = remainder
          cmp ah, 0
          jne odd
          jmp even
    
    odd:
        call newline
        lea dx, oddmsg
        mov ah, 9
        int 21h
        jmp exit
               
    even: 
        call newline
        lea dx, evenmsg
        mov ah, 9
        int 21h
        jmp exit
    
    exit:    
        ; return 0
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