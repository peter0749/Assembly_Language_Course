	.file	"sample.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	@ lr needed for prologue
	mov	r0, #0
	bx	lr
	.size	main, .-main
	.ident	"GCC: (GNU) 4.2.4"
