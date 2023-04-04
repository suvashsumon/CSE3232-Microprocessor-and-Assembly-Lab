include "emu8086.inc"
.model small
.stack 100h
.data
    str db 100 dup('$')
    vowel db 0
    consonant db 0
    digit db 0
    space db 0
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; taking input
    mov si, 0
    input:
        mov ah, 1
        int 21h
        cmp al, 0dh
        je output
        
        cmp al, ' '
        je space_count
        
        cmp al, 'a'
        je vowel_count
        cmp al, 'e'
        je vowel_count
        cmp al, 'i'
        je vowel_count
        cmp al, 'o'
        je vowel_count
        cmp al, 'u'
        je vowel_count
        cmp al, 'A'
        je vowel_count
        cmp al, 'E'
        je vowel_count
        cmp al, 'I'
        je vowel_count
        cmp al, 'O'
        je vowel_count
        cmp al, 'U'
        je vowel_count
        
        cmp al, '0'
        jge check_number
        
        cmp al, 'a'
        jge check_lowercase
        
        cmp al, 'A'
        jge check_capital
        
        jmp input
    
    space_count:
        inc space
        jmp input
        
    vowel_count:
        inc vowel
        jmp input    
    
    check_number:
        cmp al, '9'
        jle number_count
        jmp check_lowercase
        
    number_count:
        inc digit
        jmp input
    
    check_lowercase:
        cmp al, 'z'
        jle count_consonant
        jmp check_capital
    
    check_capital:
        cmp al, 'Z'
        jle count_consonant
        jmp input
            
    count_consonant:
        inc consonant
        jmp input
    
    
    output:
        mov ah, 2
        
        ; print space
        printn
        print "Space : "
        mov dl, space 
        add dl, 48
        int 21h
        
        ; print vowel
        printn
        print "Vowel : "
        mov dl, vowel 
        add dl, 48
        int 21h  
        
        ; print consonant
        printn
        print "Consonant : "
        mov dl, consonant 
        add dl, 48
        int 21h
        
        ; print digit
        printn
        print "Digit : "
        mov dl, digit 
        add dl, 48
        int 21h
        
    ;return 0
    mov ah, 4ch
    int 21h
    main endp
end main