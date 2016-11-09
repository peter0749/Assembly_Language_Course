/* 
*	DATA Section 
*/
	.data
/* --- Contents of A 2x5 --- */
	.type a, %object
a:
	.space 40, 0	@2x5x4 bytes
@endof a
/* --- Contents of B 5x2 --- */
b:
	.space 40, 0	@5x2x4 bytes
@endof b
/* --- Contents of C 2x2 --- */
c:
	.space 16, 0	@2x2x4 bytes
@endof c
/*
*	TEXT Section
*/
	.section .text
	.global main
	.type main,%function
.matrix:
	.word a
	.word b
	.word c
main:
	ldr r0, .matrix	@r0 points to address of 'a'
/* In C:
*	
	for(int k=0; k<5; ++k){
		for(int i=0; i<2; ++i){
			for(int j=0; j<2; ++j){
				C[i][j] += A[i][k]*B[k][j]
			}
		}
	}
*
*
*/
	mov r1, #0		@k
SECTIONk:
	mov r2, #0		@i
SECTIONi:
	mov r3, #0		@j
SECTIONj:
	mov r5, #2
	MUL r4, r2, r5
	ADD r4, r4, r3							@for C matrix
	ADD r4, r4, #20
	MUL r6, r1, r5
	ADD r6, r6, r3							@for B matrix
	ADD r6, r6, #10
	ADD r5, r2, r2, LSL #2					@for A matrix
	ADD r5, r5, r1
	ADD r4, r0, r4, LSL #2
	ADD r5, r0, r5, LSL #2
	ADD r6, r0, r6, LSL #2
	LDR r7, [r4]
	LDR r5, [r5]
	LDR r6, [r6]
	MUL r5, r6, r5
	ADD r7, r5, r7
	STR r7, [r4]
	ADD r3, r3, #1
	CMP r3, #2
	BNE SECTIONj
	ADD r2, r2, #1
	CMP r2, #2
	BNE SECTIONi
	ADD r1, r1, #1
	CMP r1, #5
	BNE SECTIONk
	ADD r1, r0, #80
	nop
	.end
