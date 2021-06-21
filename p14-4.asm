; 编程，在屏幕中间显示当前的月份

assume cs:code

code segment
    start: mov al, 0 ; 秒的单元
           out 70h, al
           in al, 71h

           mov ah, al
           mov cl, 4
           shr ah, cl ; 把高 4 位挪到低 4 位
           and al, 00001111b ; 把高 4 位置为 0

           add ah, 30h
           add al, 30h

           mov bx, 0b800h
           mov es, bx
           mov byte ptr es:[160*8+40*2], ah            ; 显示月份的示威码
           mov byte ptr es:[160*8+40*2+2], al          ; 接着显示月份的格纹数据

           mov ax, 4c00h
           int 21h
code ends

end start