	.file	1 "shuixianhua.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 1
	.text
	.align	2
	.globl	delay
	.set	nomips16
	.set	nomicromips
	.ent	delay
	.type	delay, @function
delay:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$0,0($fp)
	b	.L2
	nop

.L3:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
.L2:
	lw	$3,0($fp)
	li	$2,4980736			# 0x4c0000
	ori	$2,$2,0x4b40
	bne	$3,$2,.L3
	nop

	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	delay
	.size	delay, .-delay
	.align	2
	.globl	init
	.set	nomips16
	.set	nomicromips
	.ent	init
	.type	init, @function
init:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,240			# 0xf0
	sw	$3,0($2)
	jal	delay
	nop

	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	init
	.size	init, .-init
	.align	2
	.globl	print_result
	.set	nomips16
	.set	nomicromips
	.ent	print_result
	.type	print_result, @function
print_result:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	lw	$3,24($fp)
	li	$2,1			# 0x1
	bne	$3,$2,.L6
	nop

.L7:
	jal	delay
	nop

	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,15			# 0xf
	sw	$3,0($2)
	b	.L7
	nop

.L6:
	li	$2,-1079050240			# 0xffffffffbfaf0000
	ori	$2,$2,0xf000
	li	$3,240			# 0xf0
	sw	$3,0($2)
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	print_result
	.size	print_result, .-print_result
	.globl	ans
	.data
	.align	2
	.type	ans, @object
	.size	ans, 16
ans:
	.word	153
	.word	370
	.word	371
	.word	407
	.text
	.align	2
	.globl	cube
	.set	nomips16
	.set	nomicromips
	.ent	cube
	.type	cube, @function
cube:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$3,8($fp)
	lw	$2,8($fp)
	nop
	mult	$3,$2
	lw	$2,8($fp)
	mflo	$3
	nop
	nop
	mult	$3,$2
	mflo	$2
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	cube
	.size	cube, .-cube
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,64,$31		# vars= 32, regs= 3/0, args= 16, gp= 0
	.mask	0xc0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$16,52($sp)
	move	$fp,$sp
	jal	init
	nop

	sw	$0,20($fp)
	sw	$0,24($fp)
	li	$2,100			# 0x64
	sw	$2,16($fp)
	b	.L11
	nop

.L14:
	lw	$2,16($fp)
	nop
	sw	$2,28($fp)
	lw	$3,28($fp)
	li	$2,100			# 0x64
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	sw	$2,28($fp)
	lw	$3,16($fp)
	li	$2,100			# 0x64
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	mflo	$2
	sw	$2,32($fp)
	lw	$3,28($fp)
	li	$2,10			# 0xa
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	mflo	$2
	sw	$2,36($fp)
	lw	$3,28($fp)
	li	$2,10			# 0xa
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mfhi	$2
	sw	$2,40($fp)
	lw	$4,32($fp)
	jal	cube
	nop

	move	$16,$2
	lw	$4,36($fp)
	jal	cube
	nop

	addu	$16,$16,$2
	lw	$4,40($fp)
	jal	cube
	nop

	addu	$3,$16,$2
	lw	$2,16($fp)
	nop
	bne	$3,$2,.L12
	nop

	lui	$2,%hi(ans)
	lw	$3,24($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,16($fp)
	nop
	bne	$3,$2,.L13
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
	b	.L12
	nop

.L13:
	li	$2,1			# 0x1
	sw	$2,20($fp)
.L12:
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
.L11:
	lw	$2,16($fp)
	nop
	slt	$2,$2,1000
	bne	$2,$0,.L14
	nop

	lw	$3,24($fp)
	li	$2,4			# 0x4
	beq	$3,$2,.L15
	nop

	li	$2,1			# 0x1
	sw	$2,20($fp)
.L15:
	lw	$2,20($fp)
	nop
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	move	$4,$2
	jal	print_result
	nop

.L16:
	b	.L16
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
