.section .text
.global main
.type main,%function

main:
    MOV ip, sp
    STMFD sp!, {fp,ip,lr,pc}
    SUB fp, ip, #4
    
    MOV r0, #100 /*Array address*/
    MOV r1, #10  /*Array size*/

    STR r0, [sp, #-4]!
    STR r1, [sp, #-4]!

    bl NumSort

    LDMEA fp, {fp,sp,pc}
    nop
    .end
