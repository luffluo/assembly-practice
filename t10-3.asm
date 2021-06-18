; 问题 数值显示
; 编程，将 data 段中的数据以十进制的形式显示出来
; data segment
;   dw 12666
; data ends

assume cs:code, ds:data

data segment
    db 10 dup (0)
data ends

code segment
    start: mov ax, 12666
           mov bx, data
           mov ds, bx
           mov si, 0

           call dtoc

           mov dh, 8
           mov dl, 3
           mov cl, 2
           call show_str

           mov ax, 4c00h
           int 21h

     dtoc: mov cx, 10
           div cx
           add dx, 30h
           mov [si], dx
           inc si
           mov cx, ax
           jcxz ok
           jmp short dtoc_ok
           sub si, si
  dtoc_ok: ret

 show_str: mov bl, cl
           mov ax, 0b800h
           mov es, ax
           sub di, di

           dec dl

           mov al, 160 ; 计算行对应的偏移
           mul dh

           add dl, dl ; 计算列对应的偏移

           mov cl, dl ; set cx = 列
           sub ch, ch

           add ax, cx ; 行 + 列
           add di, ax

        s: sub ch, ch
           mov cl, [si]
           jcxz show_str_ok
           mov es:[di], cl
           inc di
           mov es:[di], bl
           inc si
           inc di
           jmp short s
show_str_ok: ret
code ends

end start