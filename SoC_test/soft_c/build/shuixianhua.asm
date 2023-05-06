
build/shuixianhua:     file format elf32-tradbigmips
build/shuixianhua


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de8000 	addiu	s8,s8,-32768
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf00061 	j	bfc00184 <main>
bfc00030:	00000000 	nop

bfc00034 <exit>:
exit():
bfc00034:	0bf0000d 	j	bfc00034 <exit>
bfc00038:	00000000 	nop

bfc0003c <delay>:
delay():
bfc0003c:	27bdfff0 	addiu	sp,sp,-16
bfc00040:	afbe000c 	sw	s8,12(sp)
bfc00044:	03a0f021 	move	s8,sp
bfc00048:	afc00000 	sw	zero,0(s8)
bfc0004c:	10000005 	b	bfc00064 <delay+0x28>
bfc00050:	00000000 	nop
bfc00054:	8fc20000 	lw	v0,0(s8)
bfc00058:	00000000 	nop
bfc0005c:	24420001 	addiu	v0,v0,1
bfc00060:	afc20000 	sw	v0,0(s8)
bfc00064:	8fc30000 	lw	v1,0(s8)
bfc00068:	3c02004c 	lui	v0,0x4c
bfc0006c:	34424b40 	ori	v0,v0,0x4b40
bfc00070:	1462fff8 	bne	v1,v0,bfc00054 <delay+0x18>
bfc00074:	00000000 	nop
bfc00078:	03c0e821 	move	sp,s8
bfc0007c:	8fbe000c 	lw	s8,12(sp)
bfc00080:	27bd0010 	addiu	sp,sp,16
bfc00084:	03e00008 	jr	ra
bfc00088:	00000000 	nop

bfc0008c <init>:
init():
bfc0008c:	27bdffe8 	addiu	sp,sp,-24
bfc00090:	afbf0014 	sw	ra,20(sp)
bfc00094:	afbe0010 	sw	s8,16(sp)
bfc00098:	03a0f021 	move	s8,sp
bfc0009c:	3c02bfaf 	lui	v0,0xbfaf
bfc000a0:	3442f000 	ori	v0,v0,0xf000
bfc000a4:	240300f0 	li	v1,240
bfc000a8:	ac430000 	sw	v1,0(v0)
bfc000ac:	0ff0000f 	jal	bfc0003c <delay>
bfc000b0:	00000000 	nop
bfc000b4:	03c0e821 	move	sp,s8
bfc000b8:	8fbf0014 	lw	ra,20(sp)
bfc000bc:	8fbe0010 	lw	s8,16(sp)
bfc000c0:	27bd0018 	addiu	sp,sp,24
bfc000c4:	03e00008 	jr	ra
bfc000c8:	00000000 	nop

bfc000cc <print_result>:
print_result():
bfc000cc:	27bdffe8 	addiu	sp,sp,-24
bfc000d0:	afbf0014 	sw	ra,20(sp)
bfc000d4:	afbe0010 	sw	s8,16(sp)
bfc000d8:	03a0f021 	move	s8,sp
bfc000dc:	afc40018 	sw	a0,24(s8)
bfc000e0:	8fc30018 	lw	v1,24(s8)
bfc000e4:	24020001 	li	v0,1
bfc000e8:	14620009 	bne	v1,v0,bfc00110 <print_result+0x44>
bfc000ec:	00000000 	nop
bfc000f0:	0ff0000f 	jal	bfc0003c <delay>
bfc000f4:	00000000 	nop
bfc000f8:	3c02bfaf 	lui	v0,0xbfaf
bfc000fc:	3442f000 	ori	v0,v0,0xf000
bfc00100:	2403000f 	li	v1,15
bfc00104:	ac430000 	sw	v1,0(v0)
bfc00108:	1000fff9 	b	bfc000f0 <print_result+0x24>
bfc0010c:	00000000 	nop
bfc00110:	3c02bfaf 	lui	v0,0xbfaf
bfc00114:	3442f000 	ori	v0,v0,0xf000
bfc00118:	240300f0 	li	v1,240
bfc0011c:	ac430000 	sw	v1,0(v0)
bfc00120:	03c0e821 	move	sp,s8
bfc00124:	8fbf0014 	lw	ra,20(sp)
bfc00128:	8fbe0010 	lw	s8,16(sp)
bfc0012c:	27bd0018 	addiu	sp,sp,24
bfc00130:	03e00008 	jr	ra
bfc00134:	00000000 	nop

bfc00138 <cube>:
cube():
bfc00138:	27bdfff8 	addiu	sp,sp,-8
bfc0013c:	afbe0004 	sw	s8,4(sp)
bfc00140:	03a0f021 	move	s8,sp
bfc00144:	afc40008 	sw	a0,8(s8)
bfc00148:	8fc30008 	lw	v1,8(s8)
bfc0014c:	8fc20008 	lw	v0,8(s8)
bfc00150:	00000000 	nop
bfc00154:	00620018 	mult	v1,v0
bfc00158:	8fc20008 	lw	v0,8(s8)
bfc0015c:	00001812 	mflo	v1
	...
bfc00168:	00620018 	mult	v1,v0
bfc0016c:	00001012 	mflo	v0
bfc00170:	03c0e821 	move	sp,s8
bfc00174:	8fbe0004 	lw	s8,4(sp)
bfc00178:	27bd0008 	addiu	sp,sp,8
bfc0017c:	03e00008 	jr	ra
bfc00180:	00000000 	nop

bfc00184 <main>:
main():
bfc00184:	27bdffc0 	addiu	sp,sp,-64
bfc00188:	afbf003c 	sw	ra,60(sp)
bfc0018c:	afbe0038 	sw	s8,56(sp)
bfc00190:	afb00034 	sw	s0,52(sp)
bfc00194:	03a0f021 	move	s8,sp
bfc00198:	0ff00023 	jal	bfc0008c <init>
bfc0019c:	00000000 	nop
bfc001a0:	afc00014 	sw	zero,20(s8)
bfc001a4:	afc00018 	sw	zero,24(s8)
bfc001a8:	24020064 	li	v0,100
bfc001ac:	afc20010 	sw	v0,16(s8)
bfc001b0:	10000049 	b	bfc002d8 <main+0x154>
bfc001b4:	00000000 	nop
bfc001b8:	8fc20010 	lw	v0,16(s8)
bfc001bc:	00000000 	nop
bfc001c0:	afc2001c 	sw	v0,28(s8)
bfc001c4:	8fc3001c 	lw	v1,28(s8)
bfc001c8:	24020064 	li	v0,100
bfc001cc:	14400002 	bnez	v0,bfc001d8 <main+0x54>
bfc001d0:	0062001a 	div	zero,v1,v0
bfc001d4:	0007000d 	break	0x7
bfc001d8:	00001010 	mfhi	v0
bfc001dc:	afc2001c 	sw	v0,28(s8)
bfc001e0:	8fc30010 	lw	v1,16(s8)
bfc001e4:	24020064 	li	v0,100
bfc001e8:	14400002 	bnez	v0,bfc001f4 <main+0x70>
bfc001ec:	0062001a 	div	zero,v1,v0
bfc001f0:	0007000d 	break	0x7
bfc001f4:	00001010 	mfhi	v0
bfc001f8:	00001012 	mflo	v0
bfc001fc:	afc20020 	sw	v0,32(s8)
bfc00200:	8fc3001c 	lw	v1,28(s8)
bfc00204:	2402000a 	li	v0,10
bfc00208:	14400002 	bnez	v0,bfc00214 <main+0x90>
bfc0020c:	0062001a 	div	zero,v1,v0
bfc00210:	0007000d 	break	0x7
bfc00214:	00001010 	mfhi	v0
bfc00218:	00001012 	mflo	v0
bfc0021c:	afc20024 	sw	v0,36(s8)
bfc00220:	8fc3001c 	lw	v1,28(s8)
bfc00224:	2402000a 	li	v0,10
bfc00228:	14400002 	bnez	v0,bfc00234 <main+0xb0>
bfc0022c:	0062001a 	div	zero,v1,v0
bfc00230:	0007000d 	break	0x7
bfc00234:	00001010 	mfhi	v0
bfc00238:	afc20028 	sw	v0,40(s8)
bfc0023c:	8fc40020 	lw	a0,32(s8)
bfc00240:	0ff0004e 	jal	bfc00138 <cube>
bfc00244:	00000000 	nop
bfc00248:	00408021 	move	s0,v0
bfc0024c:	8fc40024 	lw	a0,36(s8)
bfc00250:	0ff0004e 	jal	bfc00138 <cube>
bfc00254:	00000000 	nop
bfc00258:	02028021 	addu	s0,s0,v0
bfc0025c:	8fc40028 	lw	a0,40(s8)
bfc00260:	0ff0004e 	jal	bfc00138 <cube>
bfc00264:	00000000 	nop
bfc00268:	02021821 	addu	v1,s0,v0
bfc0026c:	8fc20010 	lw	v0,16(s8)
bfc00270:	00000000 	nop
bfc00274:	14620014 	bne	v1,v0,bfc002c8 <main+0x144>
bfc00278:	00000000 	nop
bfc0027c:	3c028000 	lui	v0,0x8000
bfc00280:	8fc30018 	lw	v1,24(s8)
bfc00284:	00000000 	nop
bfc00288:	00031880 	sll	v1,v1,0x2
bfc0028c:	24420000 	addiu	v0,v0,0
bfc00290:	00621021 	addu	v0,v1,v0
bfc00294:	8c430000 	lw	v1,0(v0)
bfc00298:	8fc20010 	lw	v0,16(s8)
bfc0029c:	00000000 	nop
bfc002a0:	14620007 	bne	v1,v0,bfc002c0 <main+0x13c>
bfc002a4:	00000000 	nop
bfc002a8:	8fc20018 	lw	v0,24(s8)
bfc002ac:	00000000 	nop
bfc002b0:	24420001 	addiu	v0,v0,1
bfc002b4:	afc20018 	sw	v0,24(s8)
bfc002b8:	10000003 	b	bfc002c8 <main+0x144>
bfc002bc:	00000000 	nop
bfc002c0:	24020001 	li	v0,1
bfc002c4:	afc20014 	sw	v0,20(s8)
bfc002c8:	8fc20010 	lw	v0,16(s8)
bfc002cc:	00000000 	nop
bfc002d0:	24420001 	addiu	v0,v0,1
bfc002d4:	afc20010 	sw	v0,16(s8)
bfc002d8:	8fc20010 	lw	v0,16(s8)
bfc002dc:	00000000 	nop
bfc002e0:	284203e8 	slti	v0,v0,1000
bfc002e4:	1440ffb4 	bnez	v0,bfc001b8 <main+0x34>
bfc002e8:	00000000 	nop
bfc002ec:	8fc30018 	lw	v1,24(s8)
bfc002f0:	24020004 	li	v0,4
bfc002f4:	10620003 	beq	v1,v0,bfc00304 <main+0x180>
bfc002f8:	00000000 	nop
bfc002fc:	24020001 	li	v0,1
bfc00300:	afc20014 	sw	v0,20(s8)
bfc00304:	8fc20014 	lw	v0,20(s8)
bfc00308:	00000000 	nop
bfc0030c:	2c420001 	sltiu	v0,v0,1
bfc00310:	304200ff 	andi	v0,v0,0xff
bfc00314:	00402021 	move	a0,v0
bfc00318:	0ff00033 	jal	bfc000cc <print_result>
bfc0031c:	00000000 	nop
bfc00320:	1000ffff 	b	bfc00320 <main+0x19c>
bfc00324:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	00000099 	0x99
80000004:	00000172 	0x172
80000008:	00000173 	0x173
8000000c:	00000197 	0x197

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	80008000 	lb	zero,-32768(zero)

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	bfc0003c 	0xbfc0003c
   4:	40000000 	mfc0	zero,c0_index
   8:	fffffffc 	0xfffffffc
	...
  14:	00000010 	mfhi	zero
  18:	0000001e 	0x1e
  1c:	0000001f 	0x1f
  20:	bfc0008c 	0xbfc0008c
  24:	c0000000 	lwc0	$0,0(zero)
  28:	fffffffc 	0xfffffffc
	...
  34:	00000018 	mult	zero,zero
  38:	0000001e 	0x1e
  3c:	0000001f 	0x1f
  40:	bfc000cc 	0xbfc000cc
  44:	c0000000 	lwc0	$0,0(zero)
  48:	fffffffc 	0xfffffffc
	...
  54:	00000018 	mult	zero,zero
  58:	0000001e 	0x1e
  5c:	0000001f 	0x1f
  60:	bfc00138 	0xbfc00138
  64:	40000000 	mfc0	zero,c0_index
  68:	fffffffc 	0xfffffffc
	...
  74:	00000008 	jr	zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc00184 	0xbfc00184
  84:	c0010000 	lwc0	$1,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000040 	ssnop
  98:	0000001e 	0x1e
  9c:	0000001f 	0x1f

Disassembly of section .comment:

00000000 <.comment>:
   0:	4743433a 	c1	0x143433a
   4:	2028536f 	addi	t0,at,21359
   8:	75726365 	jalx	5c98d94 <_fdata-0x7a36726c>
   c:	72792043 	0x72792043
  10:	6f646542 	0x6f646542
  14:	656e6368 	0x656e6368
  18:	204c6974 	addi	t4,v0,26996
  1c:	65203230 	0x65203230
  20:	31332e30 	andi	s3,t1,0x2e30
  24:	352d3635 	ori	t5,t1,0x3635
  28:	2920342e 	slti	zero,t1,13358
  2c:	372e3300 	ori	t6,t9,0x3300

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	41000000 	bc0f	4 <_fdata-0x7ffffffc>
   4:	0f676e75 	jal	d9db9d4 <_fdata-0x7262462c>
   8:	00010000 	sll	zero,at,0x0
   c:	00070401 	0x70401
