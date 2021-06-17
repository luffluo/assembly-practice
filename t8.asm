; 在屏幕中间分别显示 绿色、绿底红色、白底蓝色的字符串 'welcome to masm!'
; 注意，直接给内存里存储立即数时，必须指明立即数的长度 如: mov byte ptr [0], 1
; 给 内存 [0] 处 存储 1 长度一字节

assume cs:code, ds:data

data segment
    db 'welcome to masm!'
data ends

code segment
    start: mov ax, data ; Init data segment
           mov ds, ax

           mov ax, 0b800h
           mov es, ax

           mov cx, 16
           sub di, di
           sub si, si

        s: mov al, ds:[si]
           mov es:[di+160], al
           mov byte ptr es:[di+161], 00000010b ; green word
           add di, 2
           inc si
           loop s

           mov ax, 4c00h
           int 21h
code ends

end start