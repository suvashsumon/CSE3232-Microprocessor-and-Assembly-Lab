.model small
.stack 100h
.data
    inpmsg db "Enter N (1 to 3): $"
    otpmsg db "Summetion : $"
    n db ?
    i db 1
    ans db ?
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
    mov n, al
    sub n, 48
    call new_line
    
    
    ; calculate sum
    mov bh, 0
    mov cx, 0
    mov cl, n
    sum:
        add bh, i
        inc i
        loop sum
        
    ; giving output
    mov ans, bh
    add ans, 48
    lea dx, otpmsg
    mov ah, 9
    int 21h
    mov dl, ans
    mov ah, 2
    int 21h
    
    
    ; return zero
    MOV AH,4CH
    INT 21H
    
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