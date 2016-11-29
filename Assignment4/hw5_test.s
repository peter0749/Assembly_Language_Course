.data
    .type arr, %object
arr:
    .space 40, 0 @10ints

    .type res, %object
res:
    .space 40, 0 @10ints

.section .text
.global main
.type main,%function

.arrs:
    .word arr
    .word res

main:
    MOV ip, sp
    STMFD sp!, {fp,ip,lr,pc}
    SUB fp, ip, #4

    LDR r0, .arrs   @input array
    ADD r3, r0, #40 @result array
    MOV r1, #10  @array size
    MOV r2, r1   @array size
STORELOOP:
    LDMIA r0!, {r4-r7}
    STMIA r3!, {r4-r7}
    SUB r2, r2, #4
    CMP r2, #0
    BGT STORELOOP
    LDR r0, .arrs
    ADD r3, r0, #40

    STR r3, [sp, #-4]!
    STR r1, [sp, #-4]!

    bl NumSort

    LDMEA fp, {fp,sp,pc}
    nop
    .end
