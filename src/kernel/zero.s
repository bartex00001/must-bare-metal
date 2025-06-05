.extern main

.global _start
.section .init
_start:
    la sp, __stack_top  # load address into stack pointer
   j main
