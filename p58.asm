assume cs:code

code segment
        mov ax, 0ffffh
        mov ds, ax
        mov ax, 20h
        mov es, ax
        mov bx, 0

        mov cx, 12

     s: mov dl, [bx]
        mov es:[bx], dl
        inc bx
        loop s
code ends

end