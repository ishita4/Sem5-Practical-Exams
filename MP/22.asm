data segment

msg1 db 10,13, "Enter the number: $"
msg2 db 10,13, "The factorial is: $"


result dw ?


data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax

menu:
mov dx, offset msg1
mov ah, 09h
int 21h



call input
mov cl,al
mov bl,al
mov ax, 0001h
label1:
    mul bl
    sub bl, 01h
loop label1

mov result,ax


        mov dx, offset msg2 ;Outputing result
        mov ah, 09h
        int 21h 
        
        mov bx, result
        and bx,0F000h         ;First digit
        ror bx, 0Ch 
        call output
        
        mov bx, result
        and bx,0F00h         ;Second digit
        ror bx, 08h 
        call output
        
        mov bx, result
        and bx,00F0h         ;Third digit
        ror bx, 04h 
        call output
        
        mov bx, result
        and bx,000Fh         ;Fourth digit
        call output
        
        mov ah, 4ch
        int 21h

     
        
input proc
    mov ah, 01h
    int 21h
    cmp al, 41h
    jc A
    sub al, 07h
    A:  
    sub al, 30h
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