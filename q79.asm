; 将 data 段中每个单词的前 4 个字母改为大写字母

assume cs:code, ss:stack, ds:data

stack segment
    dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

data segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends

code segment
    start: mov ax, data ; Init data segment
           mov ds, ax

           mov ax, start ; Init stack segment
           mov ss, ax
           mov sp, 16

           sub si, si ; Init row of array

           mov cx, 4

        s: push cx ; Stash row cx for column
           mov cx, 4
           mov di, 3 ; Init column of array

       s0: mov al, [si+3+di]
           and al, 11011111b
           mov [si+3+di], al
           inc di
           loop s0

           pop cx
           add si, 16
           loop s

           mov ax, 4c00h
           int 21h
code ends

end start