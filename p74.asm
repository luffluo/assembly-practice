; 将 data 中的第一个字符串转化为大写，第二个字符串转化为小写
; 通过观察，大写和小写字符的 ascii 的二进制 只有第五位不一样
; 所以，用 and 11011111b 把第五位变成 0 就变成大写字符了
; 用 or 00100000b 把第五位变成 1 就变成小写字符了

assume cs:code, ds:data

data segment
    db 'BaSiC'
    db 'iNfOrMaTiOn'
data ends

code segment
    start: mov ax, data
           mov ds, ax

           mov cx, 5
           sub bx, bx

        s: mov al, ds:[bx]
           and al, 11011111b
           mov ds:[bx], al
           inc bx
           loop s

           mov cx, 11
           mov bx, 5

       s1: mov al, ds:[bx]
           or al, 00100000b
           mov ds:[bx], al
           inc bx
           loop s1

           mov ax, 4c00h
           int 21h
code ends

end start