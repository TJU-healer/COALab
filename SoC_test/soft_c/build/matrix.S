	.file	1 "matrix.c"
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
	.globl	a
	.data
	.align	2
	.type	a, @object
	.size	a, 400
a:
	.word	31
	.word	-73
	.word	-67
	.word	-28
	.word	87
	.word	-17
	.word	-15
	.word	-35
	.word	-53
	.word	-54
	.word	52
	.word	36
	.word	9
	.word	-91
	.word	-27
	.word	-78
	.word	42
	.word	82
	.word	19
	.word	-6
	.word	41
	.word	-56
	.word	31
	.word	32
	.word	-52
	.word	74
	.word	28
	.word	20
	.word	55
	.word	-72
	.word	-59
	.word	2
	.word	-79
	.word	-8
	.word	44
	.word	55
	.word	-83
	.word	-95
	.word	-45
	.word	50
	.word	-95
	.word	61
	.word	-63
	.word	62
	.word	-16
	.word	52
	.word	40
	.word	92
	.word	-32
	.word	-26
	.word	-99
	.word	52
	.word	96
	.word	63
	.word	-75
	.word	-74
	.word	-82
	.word	82
	.word	-95
	.word	42
	.word	11
	.word	-22
	.word	27
	.word	-27
	.word	-27
	.word	-76
	.word	-71
	.word	58
	.word	-40
	.word	-65
	.word	91
	.word	-53
	.word	-67
	.word	72
	.word	36
	.word	-77
	.word	-3
	.word	93
	.word	-24
	.word	97
	.word	-52
	.word	-11
	.word	-77
	.word	-93
	.word	-92
	.word	-24
	.word	70
	.word	18
	.word	56
	.word	88
	.word	-43
	.word	-41
	.word	-26
	.word	11
	.word	-84
	.word	-14
	.word	-41
	.word	83
	.word	27
	.word	-11
	.globl	b
	.align	2
	.type	b, @object
	.size	b, 400
b:
	.word	-48
	.word	-70
	.word	-40
	.word	-82
	.word	-74
	.word	-63
	.word	-59
	.word	-72
	.word	-100
	.word	-72
	.word	5
	.word	-84
	.word	28
	.word	56
	.word	60
	.word	-33
	.word	-42
	.word	-50
	.word	-83
	.word	-83
	.word	-5
	.word	5
	.word	48
	.word	75
	.word	-78
	.word	-9
	.word	9
	.word	2
	.word	88
	.word	70
	.word	69
	.word	23
	.word	66
	.word	66
	.word	-11
	.word	50
	.word	67
	.word	18
	.word	-58
	.word	76
	.word	30
	.word	45
	.word	32
	.word	25
	.word	-73
	.word	57
	.word	-67
	.word	-14
	.word	53
	.word	-33
	.word	98
	.word	-86
	.word	-63
	.word	80
	.word	-45
	.word	-88
	.word	80
	.word	-64
	.word	58
	.word	-84
	.word	-55
	.word	-39
	.word	-13
	.word	-27
	.word	-37
	.word	8
	.word	-96
	.word	84
	.word	-89
	.word	31
	.word	-82
	.word	58
	.word	81
	.word	-41
	.word	-58
	.word	36
	.word	76
	.word	-79
	.word	-29
	.word	23
	.word	86
	.word	-46
	.word	16
	.word	-18
	.word	81
	.word	90
	.word	35
	.word	-90
	.word	43
	.word	55
	.word	-38
	.word	-19
	.word	-40
	.word	82
	.word	-76
	.word	57
	.word	-29
	.word	-2
	.word	79
	.word	-48
	.globl	ans
	.align	2
	.type	ans, @object
	.size	ans, 400
ans:
	.word	-1317
	.word	10379
	.word	-5821
	.word	-14322
	.word	-4330
	.word	-3114
	.word	-9940
	.word	7033
	.word	-1883
	.word	-6027
	.word	-24266
	.word	-861
	.word	4044
	.word	-19824
	.word	-223
	.word	886
	.word	-11988
	.word	-6442
	.word	-13846
	.word	-1054
	.word	9783
	.word	-7073
	.word	-918
	.word	-5911
	.word	-967
	.word	-7100
	.word	14605
	.word	-7556
	.word	-3439
	.word	9607
	.word	15980
	.word	-520
	.word	-13297
	.word	15043
	.word	6185
	.word	-3654
	.word	1325
	.word	4193
	.word	16925
	.word	-17761
	.word	2566
	.word	3187
	.word	10248
	.word	7925
	.word	6318
	.word	1421
	.word	14648
	.word	700
	.word	-12193
	.word	1083
	.word	-12603
	.word	19006
	.word	20952
	.word	18599
	.word	-1539
	.word	5184
	.word	17408
	.word	6740
	.word	6264
	.word	15114
	.word	-12715
	.word	15121
	.word	9963
	.word	-13717
	.word	2411
	.word	-2196
	.word	6147
	.word	-1698
	.word	-3389
	.word	8200
	.word	-19007
	.word	12417
	.word	5723
	.word	-11309
	.word	-19242
	.word	15740
	.word	-3791
	.word	-3949
	.word	-13130
	.word	-21
	.word	-12557
	.word	-5970
	.word	-11570
	.word	-8905
	.word	12227
	.word	7814
	.word	-5094
	.word	4532
	.word	1071
	.word	-1309
	.word	-2955
	.word	9381
	.word	6372
	.word	-6898
	.word	9117
	.word	5753
	.word	20778
	.word	-5045
	.word	1047
	.word	12114

	.comm	c,400,4
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,48,$31		# vars= 24, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$fp,40($sp)
	move	$fp,$sp
	jal	init
	nop

	sw	$0,28($fp)
	sw	$0,32($fp)
	sw	$0,16($fp)
	b	.L9
	nop

.L16:
	sw	$0,20($fp)
	b	.L10
	nop

.L15:
	lui	$4,%hi(c)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$3,$2,2
	addu	$2,$2,$3
	lw	$3,20($fp)
	nop
	addu	$2,$2,$3
	sll	$3,$2,2
	addiu	$2,$4,%lo(c)
	addu	$2,$3,$2
	sw	$0,0($2)
	sw	$0,24($fp)
	b	.L11
	nop

.L12:
	lui	$4,%hi(c)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$3,$2,2
	addu	$2,$2,$3
	lw	$3,20($fp)
	nop
	addu	$2,$2,$3
	sll	$3,$2,2
	addiu	$2,$4,%lo(c)
	addu	$2,$3,$2
	lw	$3,0($2)
	lui	$5,%hi(a)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$4,$2,2
	addu	$2,$2,$4
	lw	$4,24($fp)
	nop
	addu	$2,$2,$4
	sll	$4,$2,2
	addiu	$2,$5,%lo(a)
	addu	$2,$4,$2
	lw	$4,0($2)
	lui	$6,%hi(b)
	lw	$2,24($fp)
	nop
	sll	$2,$2,1
	sll	$5,$2,2
	addu	$2,$2,$5
	lw	$5,20($fp)
	nop
	addu	$2,$2,$5
	sll	$5,$2,2
	addiu	$2,$6,%lo(b)
	addu	$2,$5,$2
	lw	$2,0($2)
	nop
	mult	$4,$2
	mflo	$2
	addu	$3,$3,$2
	lui	$5,%hi(c)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$4,$2,2
	addu	$2,$2,$4
	lw	$4,20($fp)
	nop
	addu	$2,$2,$4
	sll	$4,$2,2
	addiu	$2,$5,%lo(c)
	addu	$2,$4,$2
	sw	$3,0($2)
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
.L11:
	lw	$2,24($fp)
	nop
	slt	$2,$2,10
	bne	$2,$0,.L12
	nop

	lui	$4,%hi(c)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$3,$2,2
	addu	$2,$2,$3
	lw	$3,20($fp)
	nop
	addu	$2,$2,$3
	sll	$3,$2,2
	addiu	$2,$4,%lo(c)
	addu	$2,$3,$2
	lw	$3,0($2)
	lui	$5,%hi(ans)
	lw	$2,16($fp)
	nop
	sll	$2,$2,1
	sll	$4,$2,2
	addu	$2,$2,$4
	lw	$4,20($fp)
	nop
	addu	$2,$2,$4
	sll	$4,$2,2
	addiu	$2,$5,%lo(ans)
	addu	$2,$4,$2
	lw	$2,0($2)
	nop
	beq	$3,$2,.L13
	nop

	li	$2,1			# 0x1
	sw	$2,32($fp)
	b	.L14
	nop

.L13:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
.L10:
	lw	$2,20($fp)
	nop
	slt	$2,$2,10
	bne	$2,$0,.L15
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
.L9:
	lw	$2,16($fp)
	nop
	slt	$2,$2,10
	bne	$2,$0,.L16
	nop

	lw	$3,28($fp)
	li	$2,1000			# 0x3e8
	beq	$3,$2,.L14
	nop

	li	$2,1			# 0x1
	sw	$2,32($fp)
.L14:
	lw	$2,32($fp)
	nop
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	move	$4,$2
	jal	print_result
	nop

.L17:
	b	.L17
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2013.05-65) 4.7.3"
