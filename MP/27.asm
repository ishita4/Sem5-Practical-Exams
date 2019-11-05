data segment

msg1 db 10,13, "Enter size of array: $"
msg2 db 10,13, "Enter number: $"
msg3 db 10,13, "Enter number to be searched: $"
msg4 db 10,13, "Number of occurences: $"

count db ?
result db ?
data ends

code segment

    assume cs:code, ds:data
    start:
    mov ax, data
    mov ds, ax
 
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    
    call input
    mov count, bl
    mov cl, bl
    mov si, 1000h
    A:
        mov dx, offset msg2
        mov ah, 09h
        int 21h
        call input
        mov [si], bl
        inc si
        loop A
        
    mov dx, offset msg3
    mov ah, 09h
    int 21h
    
    call input
    mov cl,count
    mov al, 00h     ;count variable
    mov si, 1000h
    
    B:
        cmp bl, [si]
        jnz C
        inc al
        C:
        inc si
        loop B
        
    mov dx, offset msg4
    mov ah, 09h
    int 21h
    mov bl,al
    call output
        
    exit:   
        mov ah, 4ch
        int 21h
            
    
input proc
    call getdigits
    rol al, 04h
    mov bl,al
    call getdigits
    add bl,al
    
ret 
endp


getdigits proc

    mov ah, 01h
    int 21h
    cmp al, 41h
    jc X
    sub al, 07h
    X:  sub al, 30h

ret
endp

output proc                    ;Outputs a 8 bit number stored in bl

    mov result,bl
    and bl,0F0h         ;First digit
    ror bl, 04h 
    call showdigits
    mov bl,result       ;Second digit
    and bl,0Fh          
    call showdigits

ret 
endp
    
showdigits proc
    cmp bl, 0Ah
    jc Y
    add bl, 07h
    Y:  
    add bl, 30h
    mov dl, bl
    mov ah, 02h
    int 21h
ret
endp

code ends
end start