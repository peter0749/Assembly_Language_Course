.section .data
.type result, %object
.size result, 400
result:
    .space 400

.section .text
    .global NumSort
    .type NumSort, %function
.res:
    .word result

/*Implement: insertion sort*/
NumSort:
    MOV ip, sp
    STMFD sp!,{r4-r10, fp, ip, lr, pc} /*Callee save registers*/
    SUB fp, ip, #4

    mov r5, r0 @get array size
    mov r6, r1 @get array address
    ldr r2, .res
COPY:
    LDMIA r1!, {r7-r10}
    STMIA r2!, {r7-r10}
    sub r0, r0, #4
    cmp r0, #0
    bgt COPY
    ldr r6, .res
    /*Num Sort*/
    ADD r0, r6, #4 @index of outer loop, i=1
    ADD r7, r6, r5, LSL #2 @index of full array
PIVOTLOOP:
    LDR r3, [r0]@ x = A[i]
    SUB r1, r0, #4 @j=i-1
    LDR r8, [r1] @A[j]

    INNERLOOP:
        LDR r9, [r1] @t=A[j]
        STR r9, [r1, #4] @A[j+1]=t
        SUB r1, r1, #4 @--j
        CMP r1, r6
        BLT BREAKLOOP
        LDR r8, [r1] @A[j]
        CMP r3, r8
        BGE BREAKLOOP
        B INNERLOOP
    BREAKLOOP:
    STR r3, [r1, #4] @A[j+1]=x
    ADD r0, r0, #4
    CMP r0, r7
    BLE PIVOTLOOP
    /*End Numsort*/
    MOV r0, r6/*Return pointer*/
    nop
    LDMEA fp, {r4-r10, fp, sp, pc} /*Callee save register*/
    .end
