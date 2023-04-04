.model small
.stack 100h
.data
    inpmsg db "Enter N (1 to 3) : $"
    otpmsg db "Factorial : $"
    n db ?
    fact db ?
    i db 1
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
    mov n, al   ; store input to n
    sub n, 48
    call new_line
    
    ; calculate factorial
    mov ax, 1        ; fact = 1
    mov cx, 0        
    mov cl, n        ; loop counter = n
    factorial:
            mul i         ; fact = fact * i
            inc i           ; i++
            loop factorial     
    
    ; giving output
    mov fact, al
    add fact, 48
    lea dx, otpmsg
    mov ah, 9
    int 21h
    mov dl, fact
    mov ah, 2
    int 21h
    
    
    ; return 0
    mov ah, 4ch
    int 21h
    main endp

new_line proc
    mov dl, 0ah
    mov ah, 2
    int 21h
    mov dl, 0dh
    int 21h
    ret
    new_line endp
end main