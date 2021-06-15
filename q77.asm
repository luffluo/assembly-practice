; 将 data 段中每个单词改为大写字母
; 这里用到了 嵌套循环
; 嵌套循环怎么解决循环计算器的值会被内循环覆盖问题呢
; 就是 当要进行内循环时，在外循环把外循环的计数器保存到某个寄存器里
; 当内循环完了后 再还回了

assume cs:code, ds:data

data segment
    db 'ibm             '
    db 'dec             '
    db 'dos             '
    db 'vax             '
data ends

code segment
    start: mov ax, data
           mov ds, ax

           mov si, 0
           mov cx, 4

        s: mov dx, cx
           mov di, 0
           mov cx, 3

       s0: mov al, [si+di]
           and al, 11011111b
           mov [si+di], al
           inc di
           loop s0
           
           mov cx, dx
           add si, 16
           loop s

code ends

end start