data segment

msg1 db 10,13, "Enter your choice: $"
msg2 db 10,13, "1.Addition $"
msg3 db 10,13, "2.Subtraction $"
msg4 db 10,13, "3.Exit $"
msg5 db 10,13, "Enter the number: $"
msg6 db 10,13, "The result is: $"
msg7 db 10,13, "$"

resultlower dw ?
resulthigher dw ?
choice db ?
num1lower dw ?
num1higher dw ?
num2lower dw ?
num2higher dw ?
copy db ?

data ends


code segment

assume cs:code, ds:data
start:

    mov ax,data
    mov ds, ax
    
    mov dx, offset msg5 
    mov ah, 09h
    int 21h
    
    
    ;Number One
   
    call input                  ; Upper nibble
    rol al, 04h
    mov copy, al
    mov bl,al
    
    call input
    mov bl, copy
    add bl,al
    mov bh, bl
    
    call input                  ; Lower nibble
    rol al, 04h
    mov copy, al
    mov bl,al
  
    call input
    mov bl, copy
    add bl,al                   
    mov num1higher, bx
    
    call input                  ; Upper nibble
    rol al, 04h
    mov copy, al
    mov bl,al
    
    call input
    mov bl, copy
    add bl,al
    mov bh, bl
    
    call input                  ; Lower nibble
    rol al, 04h
    mov copy, al
    mov bl,al
  
    call input
    mov bl, copy
    add bl,al                 
    mov num1lower, bx
    
    
    
    
    mov dx, offset msg5 
    mov ah, 09h
    int 21h
    
    
    ;Number Two
   
    call input                  ; Upper nibble
    rol al, 04h
    mov copy, al
    mov bl,al
    
    call input
    mov bl, copy
    add bl,al
    mov bh, bl
    
    call input                  ; Lower nibble
    rol al, 04h
    mov copy, al
    mov bl,al
  
    call input
    mov bl, copy
    add bl,al                   ; first 16bit number stored in reg BX
    mov num2higher, bx
    
   
    call input                  ; Upper nibble
    rol al, 04h
    mov copy, al
    mov bl,al
    
    call input
    mov bl, copy
    add bl,al
    mov bh, bl
    
    call input                  ; Lower nibble
    rol al, 04h
    mov copy, al
    mov bl,al
  
    call input
    mov bl, copy
    add bl,al                  
    mov num2lower, bx
        
    
    
    menu:
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
    cmp al, 03h
    jnz addition
    
    exit:  
    
            mov ah, 4ch
            int 21h
    
    addition:
            cmp al, 01h        
            jnz temp                                       
 
            jmp over
            temp:
            jmp subtraction
            
            over:
            mov bx,num1lower
            mov cx,num2lower
            add bx, cx
            mov resultlower,bx
            
            mov bx,num1higher
            mov cx,num2higher
            adc bx, cx
            mov resulthigher,bx
            
            mov dx, offset msg6         ; Displaying the ouput 
            mov ah, 09h
            int 21h
            
            mov bx,resulthigher                
            and bx, 0F000h              
            ror bx, 0Ch
            call output

            mov bx, resulthigher
            and bx, 0F00h
            ror bx, 08h
            call output

            mov bx, resulthigher
            and bx, 00F0h
            ror bx, 04h
            call output

            mov bx, resulthigher
            and bx, 000Fh
            call output



            mov bx,resultlower                
            and bx, 0F000h              
            ror bx, 0Ch
            call output

            mov bx, resultlower
            and bx, 0F00h
            ror bx, 08h
            call output

            mov bx, resultlower
            and bx, 00F0h
            ror bx, 04h
            call output

            mov bx, resultlower
            and bx, 000Fh
            call output
            
            jmp menu
    
    subtraction:
    
            cmp al, 02h        
            jnz temp2                                       
 
            jmp over2
            temp2:
            jmp exit
            
            over2:
            mov bx,num1lower
            mov cx,num2lower
            sub bx, cx
            mov resultlower,bx
            
            mov bx,num1higher
            mov cx,num2higher
            sbb bx, cx
            mov resulthigher,bx
            
            mov dx, offset msg6         ; Displaying the ouput 
            mov ah, 09h
            int 21h
            
            mov bx,resulthigher                
            and bx, 0F000h              
            ror bx, 0Ch
            call output

            mov bx, resulthigher
            and bx, 0F00h
            ror bx, 08h
            call output

            mov bx, resulthigher
            and bx, 00F0h
            ror bx, 04h
            call output

            mov bx, resulthigher
            and bx, 000Fh
            call output



            mov bx,resultlower                
            and bx, 0F000h              
            ror bx, 0Ch
            call output

            mov bx, resultlower
            and bx, 0F00h
            ror bx, 08h
            call output

            mov bx, resultlower
            and bx, 00F0h
            ror bx, 04h
            call output

            mov bx, resultlower
            and bx, 000Fh
            call output
            
            jmp menu

   
input proc

    mov ah, 01h
    int 21h
    
    cmp al, 41h
    jc X
    sub al, 07h
    X:
    sub al, 30h
ret
endp

output proc
    
    cmp bl, 0Ah
    jc Y
    add bl, 07h
    Y:
    add bl, 30h
    
    mov dl,bl
    mov ah, 02h
    int 21h
ret
endp


code ends
end start