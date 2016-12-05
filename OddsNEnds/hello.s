    .data
    .align 4
yolo:
    .ascii "Hello, World\n\0000"

    .section .text
    .global main
    .type main, %function
.string:
    .word yolo

main:
    mov r0, #0x4
    ldr r1, .string
    swi #0x123456
    mov r0, #0x3
    ldr r1, .string
    mov r3, #13
loop:
    swi #0x123456
    add r1, r1, #1
    sub r3, r3, #1
    cmp r3, #0
    bgt loop

    nop
    .end
