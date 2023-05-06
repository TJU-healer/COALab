#include "trap.h"
   	.set noreorder
   	.set nomacro
   	.set at
   	.globl main
   	.text
main:
	syscall
	mfc0	$s0, $14
	li		$s0, 0x1234
	li		$s1, 0x1
	add		$t0, $s0, $s1
	bne		$t0, 0x1235, done
	HIT_GOOD_TRAP

	done:
	HIT_BAD_TRAP