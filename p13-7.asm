; 在屏幕的 25 行 12 列显示字符串 “Welcome to masm!”

assume cs:code, ds:data

data segment
    db 'Welcome to masm!', '$'
data ends

code segment
    start: mov ah, 2 ; 设置光标
           mov bh, 0 ; 第 0 页
           mov dh, 24 ; dh 中放行号
           mov dl, 12 ; dl 中放列号
           int 10h

           mov ax, data
           mov ds, ax
           mov dx, 0
           mov ah, 9
           int 21h

           mov ax, 4c00h
           int 21h
code ends

end start