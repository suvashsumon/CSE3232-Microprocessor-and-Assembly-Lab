include "emu8086.inc"
.model small
.stack 100h
.data
    str db 500 dup('$')
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov si, 0
    input:
        mov ah, 1
        int 21h
        
        cmp al, 0dh ; input is enter button
        je output
                   
        cmp al, 'A' ; if al<A ?
        jl spacialchar
        cmp al, 'Z' ; if al>Z ?
        jl capital
        cmp al, 'a' ; if al<a ?
        jl spacialchar
        cmp al, 'z' ; if al>z ?
        jl lower
        jmp spacialchar
        
        spacialchar:
            mov str[si], al ; input tai string e save korbo
            inc si
            jmp input
        
        capital:
            add al, 32 ; 32 add kore upppercase kora holo
            mov str[si], al
            inc si
            jmp input
        
        lower:
            sub al, 32 ; 32 biyog kore lowercase kora holo
            mov str[si], al
            inc si
            jmp input
            
    
    output:
        call newline
        lea dx, str
        mov ah, 9
        int 21h
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