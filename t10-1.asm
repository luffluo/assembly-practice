; 编写一个通用子程序来实现显示字符串功能

; 名称: show_str
; 功能: 在指定的位置，用指定的颜色，显示一个用 0 结束的字符串
; 参数: (dh) = 行号(取值范围 0 ~ 14)，dl = 列号(取值范围 0 ~ 79)
;      (cl) = 颜色，ds:si 指向字符串的首地址
; 返回: 无
; 应用举例: 在屏幕的 8 行 3 列，用绿色显示 data 段中的字符串

assume cs:code, ds:data

data segment
    db 'Welcome to masm!', 0
data ends

code segment
    start: mov ax, data ; Init data segment
           mov ds, ax
           sub si, si ; Init data index = 0

           mov dh, 8
           mov dl, 30
           mov cl, 2 ; 00000010b green word

           call show_str

           mov ax, 4c00h
           int 21h

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
           jcxz ok
           mov es:[di], cl
           inc di
           mov es:[di], bl
           inc si
           inc di
           jmp short s
       ok: ret
code ends

end start