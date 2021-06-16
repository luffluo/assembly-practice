; 利用 jcxz 指令，实现在内存 2000h 段中查找第一个值为 0 的字节
; 找到后，将它的偏移地址存储在 dx 中

assume cs:code

code segment
    start: mov ax, 2000h
           mov ds, ax
           sub bx, bx ; (bx) = 0

        s: sub ch, ch ; (ch) = 0
           mov cl, [bx]
           jcxz ok ; if cx == 0 go to ok
           inc bx
           jmp short s

       ok: mov dx, bx

           mov ax, 4c00h
           int 21h
code ends

end start