.section .text
.global main
.type main,%function

main:
	mov r0, #0xff @assign value 0xff to r1
	/*Codes*/
	and r1, r0, #0xff @bitwise and r0 and 0xff to r1
	lsr r0, #8			@shift left 8bits on r0
	and r2, r0, #0xff	@bitwise and r0 and 0xff to r2
	lsr r0, #10			@shift left 10bits on r0
	mov r4, #7			@assign value 7 to r4
	lsl r4, #8			@shift left 8bits on r4
	orr r4, r4, #0xff	@bitwise or on r4 and 0xff to r4
	and r3, r0, r4		@bitwise and on r0 and r4 to r3
	/*End Codes*/
	nop
	.end

