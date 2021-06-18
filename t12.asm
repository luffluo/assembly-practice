; 实验 12 编写 0 号中断处理程序

assume cs:code

code segment
    start: mov ax, cs
           mov ds, ax
           mov si, offset do0 ; 设置 ds:si 指向源地址

           mov ax, 0
           mov es, ax
           mov di, 200h ; 设置 es:di 指向目的地址

           mov cx, offset do0end-offset do0 ; do0 部分代码的长度

           cld ; 设置传输方向为正

           rep movsb ; 把 ds:si 长度为 cx 字节的数据 送到 es:di 处

           ; 设置中断向量表
           mov ax, 0
           mov es, ax
           mov word ptr es:[0*4], 200h
           mov word ptr es:[0*4+2], 0

           mov ax, 4c00h
           int 21h

      do0: jmp short do0start
           db "overflow!"

 do0start: mov ax, cs
           mov ds, ax
           mov si, 202h ; 设置 ds:si 指向字符串

           mov ax, 0b800h
           mov es, ax
           mov di, 7*160+3*2

           mov cx, 9
        s: mov al, [si]
           mov es:[di], al
           mov byte ptr es:[di+1], 2
           inc si
           add di, 2
           loop s

           mov ax, 4c00h
           int 21h
   do0end: nop
code ends

end start