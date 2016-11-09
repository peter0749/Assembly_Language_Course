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
	mov r1, #0		@k
	mov r2, #0		@i
	mov r3, #0		@j
STARTi:
	

	nop
	.end
