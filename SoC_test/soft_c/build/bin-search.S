	.file	1 "bin-search.c"
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
	.globl	search_seq
	.data
	.align	2
	.type	search_seq, @object
	.size	search_seq, 164
search_seq:
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.word	15
	.word	16
	.word	17
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	25
	.word	26
	.word	27
	.word	28
	.word	29
	.word	30
	.word	31
	.word	32
	.word	33
	.word	34
	.word	35
	.word	36
	.word	37
	.word	38
	.word	39
	.word	40
	.word	41
	.word	42
	.word	43
	.word	44
	.word	45
	.word	46
	.word	47
	.word	48
	.word	49
	.word	50
	.globl	test_data
	.align	2
	.type	test_data, @object
	.size	test_data, 40
test_data:
	.word	17
	.word	26
	.word	45
	.word	31
	.word	88
	.word	29
	.word	22
	.word	35
	.word	41
	.word	9
	.globl	ans
	.align	2
	.type	ans, @object
	.size	ans, 40
ans:
	.word	7
	.word	16
	.word	35
	.word	21
	.word	-1
	.word	19
	.word	12
	.word	25
	.word	31
	.word	-1
	.text
	.align	2
	.globl	bin_search
	.set	nomips16
	.set	nomicromips
	.ent	bin_search
	.type	bin_search, @function
bin_search:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$6,40($fp)
	lui	$2,%hi(search_seq)
	lw	$3,36($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(search_seq)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,32($fp)
	nop
	slt	$2,$2,$3
	bne	$2,$0,.L9
	nop

	lui	$2,%hi(search_seq)
	lw	$3,40($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(search_seq)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,32($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,.L9
	nop

	lw	$3,36($fp)
	lw	$2,40($fp)
	nop
	slt	$2,$2,$3
	beq	$2,$0,.L10
	nop

.L9:
	li	$2,-1			# 0xffffffffffffffff
	b	.L11
	nop

.L10:
	lw	$3,36($fp)
	lw	$2,40($fp)
	nop
	addu	$2,$3,$2
	srl	$3,$2,31
	addu	$2,$3,$2
	sra	$2,$2,1
	sw	$2,16($fp)
	lui	$2,%hi(search_seq)
	lw	$3,16($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(search_seq)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,32($fp)
	nop
	bne	$3,$2,.L12
	nop

	lw	$2,16($fp)
	b	.L11
	nop

.L12:
	lui	$2,%hi(search_seq)
	lw	$3,16($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(search_seq)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,32($fp)
	nop
	slt	$2,$2,$3
	beq	$2,$0,.L13
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,-1
	lw	$4,32($fp)
	lw	$5,36($fp)
	move	$6,$2
	jal	bin_search
	nop

	b	.L14
	nop

.L13:
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	lw	$4,32($fp)
	move	$5,$2
	lw	$6,40($fp)
	jal	bin_search
	nop

.L14:
	b	.L8
	nop

.L11:
.L8:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	bin_search
	.size	bin_search, .-bin_search
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	jal	init
	nop

	sw	$0,20($fp)
	sw	$0,16($fp)
	b	.L16
	nop

.L19:
	lui	$2,%hi(test_data)
	lw	$3,16($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(test_data)
	addu	$2,$3,$2
	lw	$2,0($2)
	nop
	move	$4,$2
	move	$5,$0
	li	$6,40			# 0x28
	jal	bin_search
	nop

	sw	$2,24($fp)
	lui	$2,%hi(ans)
	lw	$3,16($fp)
	nop
	sll	$3,$3,2
	addiu	$2,$2,%lo(ans)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,24($fp)
	nop
	bne	$3,$2,.L21
	nop

	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
.L16:
	lw	$2,16($fp)
	nop
	sltu	$2,$2,10
	bne	$2,$0,.L19
	nop

	b	.L18
	nop

.L21:
	nop
.L18:
	lw	$2,20($fp)
	nop
	xori	$2,$2,0xa
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	move	$4,$2
	jal	print_result
	nop

.L20:
	b	.L20
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
