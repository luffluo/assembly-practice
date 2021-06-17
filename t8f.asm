assume cs:code, ds:data, ss:stack

data segment
    db 'welcome to masm!'
data ends

stack segment ; 用于逆序暂存生成的结果，相当于中转
    db 32 dup (0)
stack ends

code segment
    start: mov ax, data ; Init data segment
           mov ds, ax

           mov ax, stack ; Init stack segment
           mov ss, ax
           mov sp, 32

           sub bx, bx ; Init data index = 0
           mov cx, 7
           ; 设置 welcome
        s: mov al, ds:[bx]
           mov ah, 00000010B
           push ax ; 暂存入栈，后期逆序输出屏幕
           inc bx
           loop s

           ; 设置空格
           mov al, ds:[bx]
           mov ah, 0
           push ax ; 暂存入栈，后期逆序输出屏幕
           inc bx

           ; 设置 to
           mov cx, 2
        a: mov al, ds:[bx]
           mov ah, 00100100B
           push ax ; 暂存入栈，后期逆序输出屏幕
           inc bx
           loop a

           ; 设置空格
           mov al, ds:[bx]
           mov ah, 0
           push ax ; 暂存入栈，后期逆序输出屏幕
           inc bx

           ; 设置 masm!
           mov cx, 5
        w: mov al, ds:[bx]
           mov ah, 01110001B
           push ax
           inc bx
           loop w

           ; 使屏幕偏移量为屏幕中央
           mov ax, 0b800h
           mov ds, ax
           mov bx, 2014 ; 使屏幕偏移量为屏幕中央

           ; 从栈中把数据逆序读取到屏幕
           mov cx, 16
        f: pop ds:[bx]
           sub bx, 2
           loop f

           mov ax, 4c00h
           int 21h
code ends

end start