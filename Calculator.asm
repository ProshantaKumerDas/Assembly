.model small
.stack 100h
.data 

;only works for 0-255 decimal after addition,subtraction,multiplication,division,power or factorial

opt1 db "Enter (1) for Addition"
opt2 db 0ah,0dh,"Enter (2) for Subtraction"
opt3 db 0ah,0dh,"Enter (3) for Multiplication"
opt4 db 0ah,0dh,"Enter (4) for Division"
opt5 db 0ah,0dh,"Enter (5) for Power Value"
opt6 db 0ah,0dh,"Enter (6) for Factorial"
opt7 db 0ah,0dh,"Enter ( E ) for Exit"

choice db 0ah,0dh,"Enter your choice: $"

msg1 db 0ah,0dh,"Enter first number: $"
msg2 db 0ah,0dh,"Enter second number: $"
msg3 db 0ah,0dh,"Addition is: $" 
msg4 db 0ah,0dh,"Subtraction is: $" 
msg5 db 0ah,0dh,"Multiplication is: $" 
msg6 db 0ah,0dh,"Division is: $"
msg7 db 0ah,0dh,"Power is: $"
msg8 db 0ah,0dh,"Factorial is: $" 
msg9 db 0ah,0dh,"Oppss Exit!!! $"

opt db 0
num1 db 0
num2 db 0
digit1 db 0
digit2 db 0
r db 0

.code
main proc
    mov ax,data
    mov ds,ax
    lea dx,opt1
    mov ah,9
    int 21h
     
    start: 
    mov ah,9
    lea dx,choice
    int 21h
    mov ah,1
    int 21h
    mov opt,al
    
    cmp opt,'E'
    je Exit
    
    input1:
    mov ah,9
    lea dx,msg1
    int 21h
    mov ah,1
    int 21h
    cmp al,'0'
    jb input1
    cmp al,'9'
    ja input1
    sub al,30h
    mov digit1,al
    mov ah,1
    int 21h 
    cmp al,'0'   ;check if it is in range from 0 - 9
    jb input1
    cmp al,'9'
    ja input1
    sub al,30h          ;convert to real number entered
    mov digit2,al
    mov al,digit1       ;convert 1st digit to tens place
    mov bl,10
    mul bl
    mov num1,al         ;add 1st digit to 2nd digit
    mov al,digit2
    add num1,al
    
    input2:
    lea dx,msg2
    mov ah,9
    int 21h
    mov ah,1
    int 21h
    cmp al,'0'
    jb input2
    cmp al,'9'
    ja input2
    sub al,30h
    mov digit1,al
    mov ah,1
    int 21h
    cmp al,'0'
    jb input2
    cmp al,'9'
    ja input2
    sub al,30h
    mov digit2,al
    mov al,digit1
    mov bl,10
    mul bl
    mov num2,al
    mov al,digit2
    add num2,al
    
    cmp opt,'1'
    je addition
    cmp opt,'2'
    je subtruction
    cmp opt,'3'
    je multiplication 
    cmp opt,'4'
    je division
    cmp opt,'5'
    je p1
    cmp opt,'6'
    je f1 
    
    addition: 
    mov bl,num1
    add bl,num2
    call change
    lea dx,msg3
    call result
    jmp end
    
    subtruction:
    mov bl,num1
    cmp bl,num2
    jl less
    sub bl,num2
    call change
    lea dx,msg4
    call result
    jmp end 
    
    multiplication:
    mov al,num1
    mov bl,num2
    mul bl
    mov bl,al
    call change
    lea dx,msg5
    call result 
    jmp end
    
    
    division:
    mov al,num1
    mov bl,num2
    div bl
    mov bl,al
    call change
    lea dx,msg6
    call result
    jmp end 
    
    
    p1:
    mov al,num1
    mov bh,num2
    mov cl,1
    mov bl,al 
    
    power:
    
    cmp cl,bh
    jl check
    je power2
    
    check:
    mul bl
    add cl,1
    jmp power
    
    power2:
    mov bl,al
    call change 
    lea dx,msg7
    call result 
    jmp end
    
    f1:
    mov al,1
    mov bl,num1
    fact:
    cmp bl,1
    je fact2
    mul bl
    sub bl,1
    jmp fact
     
    fact2: 
    mov bl,al
    call change 
    lea dx,msg8
    call result  
    jmp end
        
    
    less:
    mov bl,num2
    sub bl,num1
    call change
 
    end:
    mov ah,9
    lea dx,choice
    int 21h 
    mov ah,1
    int 21h
    mov opt,al
    cmp opt,'E'
    je Exit
    jne input1 
    end2:
    mov ah,4ch
    int 21h
    main endp

    change proc
        mov ah,0
        mov al,bl
        mov bl,10
        div bl
        mov bl,al
        mov bh,ah
        add bh,30h
        mov r,bh
        mov ah,0
        mov al,bl
        mov bl,10
        div bl
        mov bl,al
        mov bh,ah
        add bh,30h
        add bl,30h
        ret
        change endp
        
    result proc
        mov ah,9
        int 21h
        mov dl,bl
        mov ah,2
        int 21h 
        mov dl,bh
        mov ah,2
        int 21h 
        mov dl,r 
        mov ah,2
        int 21h
        ret 
        result endp 
    
    Exit:
    mov ah,9
    lea dx,msg9
    int 21h
    jmp end2
    
    end main
