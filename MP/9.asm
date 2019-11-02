data segment

msg1 db 10,13, "Enter your choice: $"
msg2 db 10,13, "1.Multiplication $"
msg3 db 10,13, "2.Division $"
msg4 db 10,13, "3.Exit $"
msg5 db 10,13, "Enter the number: $"
msg6 db 10,13, "The result is: $"
msg7 db 10,13, "$"
msg8 db 10,13, "Enter the dividend: $"
msg9 db 10,13, "Enter the divisor: $"
msg10 db 10,13, "The quotient is: $"
msg11 db 10,13, "The remainder is: $"

result dw ?
quotient db ?
remainder db ?

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
cmp al,03h
jnz mult

exit:   
        mov ah, 4ch
        int 21h

mult:    
        cmp al,01h      
        jnz temp                                            ; 8086 throws a stupid ass error "Relative jump out of range" if you enter a 
                                                            ; jnz division statement directly. To avoid this, do a sequence of 
                                                            ; jnz and jmp instructions (unconditional jumps have larger offsets)
       
        
        jmp over
        temp:
        jmp division
        
        over:
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
        
        mov al,cl
        mul bl              ; ax = al*bl
        mov result, ax
        
        
        

        mov dx, offset msg6 ;Outputing result
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
        
        jmp menu
  
division:    
        cmp al,02h      
        jnz temp2
        
        jmp over2
        temp2:
        jmp exit
        over2:
        
        mov dx, offset msg8 ;Number One
        mov ah, 09h
        int 21h             
        call input          ;First digit
        mov bl,al           
        rol bl, 04h
        call input          ;Second digit
        add bl,al           ;Whole number stored in bl
        
        
        mov dx, offset msg9 ;Number Two
        mov ah, 09h
        int 21h   
        call input          ;First digit
        mov cl,al           
        rol cl, 04h
        call input          ;Second digit
        add cl,al           ;Whole number stored in cl
        
        mov ax, 0000h
        mov al,bl
        div cl              ;  ax= ax / cl     ( quotient in al, remainder in ah )
        mov quotient, al
        mov remainder, ah
        
    
        
        mov dx, offset msg10 ;Outputing quotient
        mov ah, 09h
        int 21h 
        
        mov bl, quotient
        and bl,0F0h         ;First digit
        ror bx, 04h 
        call output
        
        mov bl, quotient
        and bl,0Fh         ;Second digit 
        call output
        
        
        mov dx, offset msg11 ;Outputing remainder
        mov ah, 09h
        int 21h 
        
        mov bl, remainder
        and bl,0F0h         ;First digit
        ror bx, 04h 
        call output
        
        mov bl, remainder
        and bl,0Fh         ;Second digit 
        call output
        
       
        jmp menu
     
        
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