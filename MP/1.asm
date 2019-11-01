data segment

msg1 db 10,13, "Enter your choice: $"
msg2 db 10,13, "1.Addition $"
msg3 db 10,13, "2.Subtraction $"
msg4 db 10,13, "3.Exit $"
msg5 db 10,13, "Enter the number: $"
msg6 db 10,13, "The result is: $"
msg7 db 10,13, "$"

result db ?
choice db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax

;displaying message
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

mov dx, offset msg7 
mov ah, 09h
int 21h

call input
mov choice,al

cmp al,03h
jnz addition

exit:   mov ah, 4ch
        int 21h

addition:    
        cmp al,01h      
        jnz subtraction
        
        mov dx, offset msg5 ;Number One
        mov ah, 09h
        int 21h             
        call input          ;First digit
        mov bl,al           
        rol bl, 04h
        call input          ;Second digit
        add bl,al           ;Whole number stored in bl
        
        
        mov dx, offset msg5 ;Number Two
        mov ah, 09h
        int 21h   
        call input          ;First digit
        mov cl,al           
        rol cl, 04h
        call input          ;Second digit
        add cl,al           ;Whole number stored in cl
        
        add bl,cl
        mov result,bl
        
                            
        mov dx, offset msg6 ;Outputing result
        mov ah, 09h
        int 21h 
        and bl,0F0h         ;First digit
        ror bl, 04h 
        call output
        mov bl,result       ;Second digit
        and bl,0Fh          
        call output
        
        jmp exit
        
        
subtraction:    
        cmp al,02h
        jnz exit
        
        mov dx, offset msg5 ;Number One
        mov ah, 09h
        int 21h             
        call input          ;First digit
        mov bl,al           
        rol bl, 04h
        call input          ;Second digit
        add bl,al           ;Whole number stored in bl
        
        
        mov dx, offset msg5 ;Number Two
        mov ah, 09h
        int 21h   
        call input          ;First digit
        mov cl,al           
        rol cl, 04h
        call input          ;Second digit
        add cl,al           ;Whole number stored in cl
        
        sub bl,cl
        mov result,bl
        
                            
        mov dx, offset msg6 ;Outputing result
        mov ah, 09h
        int 21h 
        and bl,0F0h         ;First digit
        ror bl, 04h 
        call output
        mov bl,result       ;Second digit
        and bl,0Fh          
        call output
        
        jmp exit
        
        
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
