include "emu8086.inc"
.model small
.stack 100h
.data
    maximum db 0
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;taking input
    input:
        mov ah, 1
        int 21h
        
        ; if press enter then exit
        cmp al, 0dh
        je output
        
        ; if inputed value is largest than the maximum
        sub al, 48
        cmp al, maximum
        jg update
        jmp input
    
    update:
        mov maximum, al
        jmp input
    
    
    output:
        call newline
        print "Largest number is : "
        mov ah, 2
        mov dl, maximum
        add dl, 48
        int 21h
        ; return 0
        mov ax, 4ch
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