; 将 data 段中每个单词的头一个字母改为大写字母

assume cs:code, ds:data

data segment
    db '1. file         '
    db '2. edit         '
    db '3. search       '
data ends

code segment
    start: mov ax, data
           mov ds, ax

           mov cx, 6
           sub bx, bx

        s: mov al, [bx+3]
           and al, 11011111B
           mov [bx+3], al
           add bx, 16
           loop s

           mov ax, 4c00h
           int 21h
code ends

end start