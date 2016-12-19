.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set SWI_WriteC, 0x3
.set SWI_Write, 0x5
.set SWI_Read, 0x6
.set SWI_FLen, 0xC
.set AngelSWI, 0x123456


/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- a string --- */
.filename_addr:
	.ascii "input.txt\000"
.outputFile:
    .ascii "output.txt\000"
.readbuffer:
	.space 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.filename:
	.word .filename_addr
.open_param_in:
	.word .filename_addr
	.word 0x2
	.word 0x9
.open_param_out:
	.word .outputFile
	.word 0x4
	.word 0x10
.flen_param:
	.space 4
.read_param:
	.space 4
	.word .readbuffer
	.space 4
.write_param:
    .space 4    /*File descriptor*/
    .space 4    /*String addr*/
    .word 0x1   /*String length*/
.close_param:
	.space 4
main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4

        /* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param_in
	swi AngelSWI
	mov r2, r0                /* r2 is file descriptor */

    mov r0, #SWI_Open
    adr r1, .open_param_out
    swi AngelSWI
    mov r7, r0  /*r7 is output file descriptor*/

	/* get length of a file */
	mov r0, #SWI_FLen
	adr r1, .flen_param
	str r2, [r1, #0]
	swi AngelSWI
	mov r6, r0 /*r6 is the length of a file*/
      
        /* read from a file */
	adr r1, .read_param
	str r2, [r1, #0]          /* store file descriptor */

	ldr r5, [r1, #4]          /* r5 is the address of readbuffer */

	mov r3, #1
	str r3, [r1, #8]          /* store the length of the string */

    adr r8, .write_param
    str r7, [r8, #0]
    str r5, [r8, #4] /*r5 is the target character*/

loop:
	mov r0, #SWI_Read
	swi AngelSWI

	ldrb r4, [r5, #0]         /* r4 is the read data */
    /*TODO: Lower to Upper*/
    cmp r4, #0x61
    blt DO_NOTHING
    cmp r4, #0x7A
    bgt DO_NOTHING
    sub r4, r4, #0x20
DO_NOTHING:
    strb r4, [r5, #0]
    mov r9, r1
    mov r1, r8
    mov r0, #SWI_Write
    swi AngelSWI
    mov r1, r9

	sub r6, r6, #1
    cmp r6, #0
	bne loop

    /* close a file */
	adr r1, .close_param
	str r7, [r1, #0]
	mov r0, #SWI_Close
	swi AngelSWI

	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	mov r0, #SWI_Close
	swi AngelSWI

	ldmea fp, {fp, sp, pc}

