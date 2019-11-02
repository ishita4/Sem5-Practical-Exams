;Program works for 16-bit numbers.

data segment

msg1 db 10,13, "Enter number: $"
msg2 db 10,13, "Two's complement of the number is: $"

num dw ?
copy db ?

data ends

code segment

    assume cs:code, ds:data
    start:
    mov ax, data
    mov ds, ax
    
    mov dx, offset msg1         
    mov ah, 09h
    int 21h
   
    call input                  ; Upper nibble
    mov cl, 0Fh
    sub cl, al
    mov al,cl
    rol al, 04h
    mov copy, al
    mov bl,al
    
    call input
    mov cl, 0Fh
    sub cl, al
    mov al,cl
    mov bl, copy
    add bl,al
    mov bh, bl
    
    call input                  ; Lower nibble
    mov cl, 0Fh
    sub cl, al
    mov al,cl
    rol al, 04h
    mov copy, al
    mov bl,al
  
    call input
    mov cl, 0Fh
    sub cl, al
    mov al,cl
    mov bl, copy
    add bl,al                   
    
    add bx, 01h
    mov num, bx
    
    mov dx, offset msg2         ; Displaying the ouput 
    mov ah, 09h
    int 21h
            
    mov bx,num                
    and bx, 0F000h              
    ror bx, 0Ch
    call output

    mov bx, num
    and bx, 0F00h
    ror bx, 08h
    call output

    mov bx, num
    and bx, 00F0h
    ror bx, 04h
    call output

    mov bx, num
    and bx, 000Fh
    call output    

    
 mov ah, 4ch
 int 21h
    
input proc
    mov ah, 01h
    int 21h
    cmp al, 41h
    jc A
    sub al, 07h
    A:  sub al, 30h
ret
endp

output proc
    cmp bl, 0Ah
    jc B
    add bl, 07h
    B:  
    add bl, 30h
    mov dl, bl
    mov ah, 02h
    int 21h
ret
endp

code ends
end start