; 解决除法溢出的问题

; div 可以做除法。当进行 8 位除法的时候，用 al 存储结果的商，ah 存储结果的余数 等
; 如果 结果的商过大，超出寄存器所能存储的范围，就会产生除法溢出

; 程序描述
; 名称：divdw
; 功能：进行不会产生溢出的除法运算，被除数为 dword 型，除数为 word 型，结果为 dword 型
; 参数：(ax) = dword 型数据的低 16 位
;      (dx) = dword 型数据的高 16 位
;      (cx) = 除数
; 返回：(dx) = 结果的高 16 位，(ax) = 结果的低 16 位
;      (cx) = 余数

; 举例：计算 1000000 / 10 (f4240h / 0ah)
;      mov ax, 4240h
;      mov dx, 000fh
;      mov cx, 0ah
;      call divdw
;      结果：(dx) = 0001h, (ax) = 86a0h, (cx) = 0

; 提示：给出一个公式
;      X：被除数，范围：[0, ffffffff]
;      N：除数，范围：[0, ffff]
;      H：X 高 16 位，范围：[0, ffff]
;      L：X 低 16 位，范围：[0, ffff]
;      int()：描述性运算符，取商，比如，int(38/10) = 3
;      rem()：描述性运算符，取余，比如，rem(38/10) = 8
;      公式：X/N = int(H/N) * 65535 + [rem(H/N) * 65535 + L] / N
;      这个公式将可能产生溢出的除法运算：X/N，转变为多个不会产生溢出的除法运算。
;      公式中，等号右边的所有除法运算都可以用 div 指令来做，肯定不会导致除法溢出

assume cs:code

code segment
    start: mov ax, 4240h ; low 16 of dividend
           mov dx, 000fh ; high 16 of dividend
           mov cx, 0ah ; divisor
           call divdw

           mov ax, 4c00h
           int 21h

    divdw: mov bx, ax ; store low 16 of dividend
           mov ax, dx ; store high 16 of dividend
           sub dx, dx
           div cx ; 商 ax = int(H/N), 余 dx = rem(H/N)

           push ax

           mov ax, bx
           div cx
           push ax
           push dx
           pop cx ; 余数
           pop ax ; 低位
           pop dx ; 高位
           ret
code ends

end start