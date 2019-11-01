data segment

msg1 db 10,13, "Enter your choice: $"
msg2 db 10,13, "1. Accept String $"
msg3 db 10,13, "2. Display String $"
msg4 db 10,13, "3. Check palindrome $"
msg5 db 10,13, "4. Exit $"
msg6 db 10,13, "$"
msg7 db 10,13, "Please enter the string: $"
msg8 db 10,13, "The string entered is: $"
msg9 db 10,13, "Given string is a palindrome $"
msg10 db 10,13, "Given string is NOT a palindrome $"

len db ?
choice db ?

data ends



code segment

assume cs:code, ds:data
start:

mov ax, data
mov ds, ax

menu:
mov dx, offset msg1
mov ah, 09h
int 21h

mov dx, offset msg2
mov ah, 09h
int 21h

mov dx, offset msg3
mov ah, 09h
int 21h

mov dx, offset msg4
mov ah, 09h
int 21h

mov dx, offset msg5
mov ah, 09h
int 21h

mov dx, offset msg6
mov ah, 09h
int 21h


call input
mov choice, al

cmp al,04h

jnz accept

exit:
    mov ah, 4ch
    int 21h

accept: 
    mov al, choice
    cmp al, 01h
    jnz disp

    mov dx, offset msg7
    mov ah, 09h
    int 21h
    mov si, 1000h
    mov cx, 0000
    
    A:
        mov ah, 01h
        int 21h
        
        cmp al, 0Dh         ;Comparing entered value with carriage return to exit the loop
        jz label1
        
        mov [si], al
        inc cx
        inc si
        
        jmp A
    
    label1:
    mov len, cl
    jmp menu
    
disp:
    mov al, choice
    cmp al, 02h
    jnz palindrome
    
    mov dx, offset msg8
    mov ah, 09h
    int 21h
    
    mov si, 1000h
    mov cl,len
    
    B:
        mov dx, [si]
        mov ah, 02h
        int 21h
        inc si
        loop B
    
    mov dx, offset msg6     ;blank line
    mov ah, 09h
    int 21h
    jmp menu
        
palindrome:

    mov al, choice
    cmp al, 03h
    jnz exit
    
    mov si, 1000h
    mov di, 1000h
    mov cl, len
    mov ch, 00h
    add di, cx
    dec di              ; At this stage si points to start of string and di points to end
    
    C:
        mov al, [si]    ;   IMP ~ Doesn't work if you write ax instead of al. 
        cmp [di], al
        
        jnz D
        inc si
        dec di

        loop C
        
    mov dx, offset msg9     ;IS a palindrome
    mov ah, 09h
    int 21h  
    
    mov dx, offset msg6     ;blank line
    mov ah, 09h
    int 21h
    jmp menu
    
    D:
    mov dx, offset msg10     ;NOT a palindrome
    mov ah, 09h
    int 21h
    
    mov dx, offset msg6     ;blank line
    mov ah, 09h
    int 21h
    jmp menu
    
    

input proc
    mov ah,01h
    int 21h
    cmp al, 41h
    jc X
    sub al, 07h
    X:
    sub al, 30h
ret
endp

output proc 
    cmp al, 0Ah
    jc Y
    add al, 07h
    Y:
    add al, 30h
    
    mov dl, al
    mov ah,02h
    int 21h
ret
endp


code ends
end start