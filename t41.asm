; 编程向内存 0:200～023F 依次传送数据 0～63(3FH)

assume cs:code

code segment
        mov ax, 20h
        mov ds, ax
        mov dx, 0

        mov cx, 3fh
     s: mov [dx], dl
        inc dx
        loop s

        mov ax, 4c00h
        int 21h
code ends

end