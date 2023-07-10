include "emu8086.inc"
.model small
.stack 100h
.data
    arr db 100 dup("$")
.code
main proc
    mov ax, @data
    mov ds, ax
    
    print "Enter the input array : "
    
    mov si, 0
    
    input:
        mov ah, 1
        int 21h
        cmp al, 0dh ; check if enter button is pressed
        je sort
        
        mov arr[si], al
        inc si
        jmp input
    
    sort:
        mov si, 0
        loopi:
            mov di, si
            mov al, arr[si]
            cmp al, '$' ; is we reached to end?
            je output
            
            loopj:
                inc di
                mov al, arr[di]  ; arr[j], di->j
                mov ah, arr[si]  ; arr[i], si->i
                cmp al, '$' ; is we reached to end?
                je endloopj
                
                cmp ah, al  ; for acending
                ;cmp al, ah  ; for decending
                jg swap
                jmp loopj
                
                swap:
                    mov arr[di], ah
                    mov arr[si], al
                    jmp loopj
                    
                endloopj:
                    inc si
                    jmp loopi
        
        
        output:
            call newline
            print "Sorted array is : "
            lea dx, arr
            mov ah, 9
            int 21h
    
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