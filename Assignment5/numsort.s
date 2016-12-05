.section .text
    .global NumSort
    .type NumSort, %function

/*Implement: insertion sort*/
NumSort:
    MOV ip, sp
    STMFD sp!,{r4-r10, fp, ip, lr, pc} /*Callee save registers*/
    SUB fp, ip, #4

    mov r5, r0 @get array size
    mov r6, r1 @get array address
    /*Num Sort*/
    ADD r0, r6, #4 @index of outer loop, i=1
    ADD r7, r6, r5, LSL #2 @index of full array
PIVOTLOOP:
    LDR r3, [r0]
    MOV r1, r0
    LDR r8, [r1]

    INNERLOOP:
        LDR r9, [r1, #-4]
        STR r9, [r1]
        SUB r1, r1, #4
        CMP r1, r6
        BEQ BREAKLOOP
        LDR r8, [r1]
        CMP r3, r8
        BLT BREAKLOOP
        B INNERLOOP
    BREAKLOOP:
    STR r3, [r1]
    ADD r0, r0, #4
    CMP r0, r7
    BNE PIVOTLOOP
    /*End Numsort*/
    MOV r0, r6/*Return pointer*/
    nop
    LDMEA fp, {r4-r10, fp, sp, pc} /*Callee save register*/
    .end
