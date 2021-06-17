; 在屏幕中间分别显示 绿色、绿底红色、白底蓝色的字符串 'Welcome to MASM!'

assume cs:code, ds:data, ss:stack

data segment
    db 'Welcome to MASM!'
data ends

stack segment
    db 32 dup(0)
stack ends

code segment
    start: mov ax, data ; Init data segment
           mov ds, ax

           mov ax, stack ; Init stack segment
           mov ss, ax
           mov sp, 32

           ; push 'welcome' to stack
           sub bx, bx ; Set data index = 0
           mov cx, 7
        a: mov al, [bx]
           mov ah, 00000010b
           push ax
           inc bx
           loop a

           ; push 'space' to stack
           mov al, [bx]
           mov ah, 0
           push ax
           inc bx

           ; push 'to' to stack
           mov cx, 2
        b: mov al, [bx]
           mov ah, 00100100b ; green background and red word
           push ax
           inc bx
           loop b

           ; push 'space' to stack
           mov al, [bx]
           mov ah, 0
           push ax
           inc bx

           mov cx, 4
        c: mov al, [bx]
           mov ah, 01110001b ; white background and blue word
           push ax
           inc bx
           loop c

           mov al, [bx]
           mov ah, 11000010b ; red background, flash and green word
           push ax

           mov ax, 0b800h ; set display segment
           mov ds, ax
           mov bx, 2014 ; set display on screen center

           mov cx, 16
        d: pop [bx]
           sub bx, 2
           loop d
           
           mov ax, 4c00h
           int 21h
code ends

end start