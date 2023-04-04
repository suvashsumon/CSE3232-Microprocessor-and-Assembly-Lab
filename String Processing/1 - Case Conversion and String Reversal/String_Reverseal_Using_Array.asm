include "emu8086.inc"
.model small
.stack 100h
.data
    str db 100 dup ?
main proc
    mov ax, @data
    mov ds, ax
    
    mov si, 0
    print "Enter input string : "
    input:
        mov ah, 1
        int 21h
        
        cmp al, 0dh
        je reverse
        
        mov str[si], al           
        inc si       
        jmp input
    
    print "Reverse string is : "
    dec si
    reverse:
        ; we use the si for traverse the string. si already hold the size or str
        cmp si, 0
        jl exit
        
        mov dl, str[si]
        mov ah, 2
        int 21h
        dec si
        jmp reverse
        
    
    exit:
        ; return 0
        mov ah, 4ch
        int 21h
        main endp

newline proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
    newline endp
end main