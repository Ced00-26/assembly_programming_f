; nasm -f elf32 01_immediate.asm && ld -m elf_i386 01_immediate.o && ./a.out
; nasm -f elf32 01 imediate.asm &&
; ld - m elf_1386 01_imediate.o
; ./a.out
section .text
global _start

_start:

    mov eax, 10 
    mov ebx, 20

    add eax, 5

    mov eax, 1
    int 0x80