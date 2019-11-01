;Menu same as other similar string manipulation programs

data segment

msg1 db 10,13, "Enter The string: $"
msg2 db 10,13, "The concatenated string is: $"

len1 db ?
len2 db ?

data ends



code segment

assume cs:code, ds:data
start:

    mov ax, data
    mov ds, ax

    mov dx, offset msg1
    mov ah, 09h
    int 21h
    
    mov si, 1000h
    mov cx, 0000h
    
    A:
        mov ah, 01h
        int 21h
        
        cmp al, 0Dh
        jz B
        
        mov [si],al
        inc si
        inc cx
        jmp A
    B:
        mov len1,cl
        
    
    mov dx, offset msg1
    mov ah, 09h
    int 21h
        
    mov cx, 0000h
    
    C:
        mov ah, 01h
        int 21h
        
        cmp al, 0Dh
        jz D
        
        mov [si],al
        inc si
        inc cx
        jmp C
    D:
        mov len2,cl

    
    mov al,len1
    mov cl,len2
    add cl, al
    
    mov si, 1000h
    
    E:
            mov dx, [si]
            mov ah, 02h
            int 21h
            inc si
    loop E
    
       

    mov ah, 4ch
    int 21h
    
code ends
end start