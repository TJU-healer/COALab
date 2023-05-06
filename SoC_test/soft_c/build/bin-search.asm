
build/bin-search:     file format elf32-tradbigmips
build/bin-search


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de80f0 	addiu	s8,s8,-32528
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf000b2 	j	bfc002c8 <main>
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

bfc00138 <bin_search>:
bin_search():
bfc00138:	27bdffe0 	addiu	sp,sp,-32
bfc0013c:	afbf001c 	sw	ra,28(sp)
bfc00140:	afbe0018 	sw	s8,24(sp)
bfc00144:	03a0f021 	move	s8,sp
bfc00148:	afc40020 	sw	a0,32(s8)
bfc0014c:	afc50024 	sw	a1,36(s8)
bfc00150:	afc60028 	sw	a2,40(s8)
bfc00154:	3c028000 	lui	v0,0x8000
bfc00158:	8fc30024 	lw	v1,36(s8)
bfc0015c:	00000000 	nop
bfc00160:	00031880 	sll	v1,v1,0x2
bfc00164:	24420000 	addiu	v0,v0,0
bfc00168:	00621021 	addu	v0,v1,v0
bfc0016c:	8c430000 	lw	v1,0(v0)
bfc00170:	8fc20020 	lw	v0,32(s8)
bfc00174:	00000000 	nop
bfc00178:	0043102a 	slt	v0,v0,v1
bfc0017c:	14400013 	bnez	v0,bfc001cc <bin_search+0x94>
bfc00180:	00000000 	nop
bfc00184:	3c028000 	lui	v0,0x8000
bfc00188:	8fc30028 	lw	v1,40(s8)
bfc0018c:	00000000 	nop
bfc00190:	00031880 	sll	v1,v1,0x2
bfc00194:	24420000 	addiu	v0,v0,0
bfc00198:	00621021 	addu	v0,v1,v0
bfc0019c:	8c430000 	lw	v1,0(v0)
bfc001a0:	8fc20020 	lw	v0,32(s8)
bfc001a4:	00000000 	nop
bfc001a8:	0062102a 	slt	v0,v1,v0
bfc001ac:	14400007 	bnez	v0,bfc001cc <bin_search+0x94>
bfc001b0:	00000000 	nop
bfc001b4:	8fc30024 	lw	v1,36(s8)
bfc001b8:	8fc20028 	lw	v0,40(s8)
bfc001bc:	00000000 	nop
bfc001c0:	0043102a 	slt	v0,v0,v1
bfc001c4:	10400004 	beqz	v0,bfc001d8 <bin_search+0xa0>
bfc001c8:	00000000 	nop
bfc001cc:	2402ffff 	li	v0,-1
bfc001d0:	10000037 	b	bfc002b0 <bin_search+0x178>
bfc001d4:	00000000 	nop
bfc001d8:	8fc30024 	lw	v1,36(s8)
bfc001dc:	8fc20028 	lw	v0,40(s8)
bfc001e0:	00000000 	nop
bfc001e4:	00621021 	addu	v0,v1,v0
bfc001e8:	00021fc2 	srl	v1,v0,0x1f
bfc001ec:	00621021 	addu	v0,v1,v0
bfc001f0:	00021043 	sra	v0,v0,0x1
bfc001f4:	afc20010 	sw	v0,16(s8)
bfc001f8:	3c028000 	lui	v0,0x8000
bfc001fc:	8fc30010 	lw	v1,16(s8)
bfc00200:	00000000 	nop
bfc00204:	00031880 	sll	v1,v1,0x2
bfc00208:	24420000 	addiu	v0,v0,0
bfc0020c:	00621021 	addu	v0,v1,v0
bfc00210:	8c430000 	lw	v1,0(v0)
bfc00214:	8fc20020 	lw	v0,32(s8)
bfc00218:	00000000 	nop
bfc0021c:	14620004 	bne	v1,v0,bfc00230 <bin_search+0xf8>
bfc00220:	00000000 	nop
bfc00224:	8fc20010 	lw	v0,16(s8)
bfc00228:	10000021 	b	bfc002b0 <bin_search+0x178>
bfc0022c:	00000000 	nop
bfc00230:	3c028000 	lui	v0,0x8000
bfc00234:	8fc30010 	lw	v1,16(s8)
bfc00238:	00000000 	nop
bfc0023c:	00031880 	sll	v1,v1,0x2
bfc00240:	24420000 	addiu	v0,v0,0
bfc00244:	00621021 	addu	v0,v1,v0
bfc00248:	8c430000 	lw	v1,0(v0)
bfc0024c:	8fc20020 	lw	v0,32(s8)
bfc00250:	00000000 	nop
bfc00254:	0043102a 	slt	v0,v0,v1
bfc00258:	1040000b 	beqz	v0,bfc00288 <bin_search+0x150>
bfc0025c:	00000000 	nop
bfc00260:	8fc20010 	lw	v0,16(s8)
bfc00264:	00000000 	nop
bfc00268:	2442ffff 	addiu	v0,v0,-1
bfc0026c:	8fc40020 	lw	a0,32(s8)
bfc00270:	8fc50024 	lw	a1,36(s8)
bfc00274:	00403021 	move	a2,v0
bfc00278:	0ff0004e 	jal	bfc00138 <bin_search>
bfc0027c:	00000000 	nop
bfc00280:	10000009 	b	bfc002a8 <bin_search+0x170>
bfc00284:	00000000 	nop
bfc00288:	8fc20010 	lw	v0,16(s8)
bfc0028c:	00000000 	nop
bfc00290:	24420001 	addiu	v0,v0,1
bfc00294:	8fc40020 	lw	a0,32(s8)
bfc00298:	00402821 	move	a1,v0
bfc0029c:	8fc60028 	lw	a2,40(s8)
bfc002a0:	0ff0004e 	jal	bfc00138 <bin_search>
bfc002a4:	00000000 	nop
bfc002a8:	10000001 	b	bfc002b0 <bin_search+0x178>
bfc002ac:	00000000 	nop
bfc002b0:	03c0e821 	move	sp,s8
bfc002b4:	8fbf001c 	lw	ra,28(sp)
bfc002b8:	8fbe0018 	lw	s8,24(sp)
bfc002bc:	27bd0020 	addiu	sp,sp,32
bfc002c0:	03e00008 	jr	ra
bfc002c4:	00000000 	nop

bfc002c8 <main>:
main():
bfc002c8:	27bdffd8 	addiu	sp,sp,-40
bfc002cc:	afbf0024 	sw	ra,36(sp)
bfc002d0:	afbe0020 	sw	s8,32(sp)
bfc002d4:	03a0f021 	move	s8,sp
bfc002d8:	0ff00023 	jal	bfc0008c <init>
bfc002dc:	00000000 	nop
bfc002e0:	afc00014 	sw	zero,20(s8)
bfc002e4:	afc00010 	sw	zero,16(s8)
bfc002e8:	10000022 	b	bfc00374 <main+0xac>
bfc002ec:	00000000 	nop
bfc002f0:	3c028000 	lui	v0,0x8000
bfc002f4:	8fc30010 	lw	v1,16(s8)
bfc002f8:	00000000 	nop
bfc002fc:	00031880 	sll	v1,v1,0x2
bfc00300:	244200a4 	addiu	v0,v0,164
bfc00304:	00621021 	addu	v0,v1,v0
bfc00308:	8c420000 	lw	v0,0(v0)
bfc0030c:	00000000 	nop
bfc00310:	00402021 	move	a0,v0
bfc00314:	00002821 	move	a1,zero
bfc00318:	24060028 	li	a2,40
bfc0031c:	0ff0004e 	jal	bfc00138 <bin_search>
bfc00320:	00000000 	nop
bfc00324:	afc20018 	sw	v0,24(s8)
bfc00328:	3c028000 	lui	v0,0x8000
bfc0032c:	8fc30010 	lw	v1,16(s8)
bfc00330:	00000000 	nop
bfc00334:	00031880 	sll	v1,v1,0x2
bfc00338:	244200cc 	addiu	v0,v0,204
bfc0033c:	00621021 	addu	v0,v1,v0
bfc00340:	8c430000 	lw	v1,0(v0)
bfc00344:	8fc20018 	lw	v0,24(s8)
bfc00348:	00000000 	nop
bfc0034c:	14620010 	bne	v1,v0,bfc00390 <main+0xc8>
bfc00350:	00000000 	nop
bfc00354:	8fc20014 	lw	v0,20(s8)
bfc00358:	00000000 	nop
bfc0035c:	24420001 	addiu	v0,v0,1
bfc00360:	afc20014 	sw	v0,20(s8)
bfc00364:	8fc20010 	lw	v0,16(s8)
bfc00368:	00000000 	nop
bfc0036c:	24420001 	addiu	v0,v0,1
bfc00370:	afc20010 	sw	v0,16(s8)
bfc00374:	8fc20010 	lw	v0,16(s8)
bfc00378:	00000000 	nop
bfc0037c:	2c42000a 	sltiu	v0,v0,10
bfc00380:	1440ffdb 	bnez	v0,bfc002f0 <main+0x28>
bfc00384:	00000000 	nop
bfc00388:	10000002 	b	bfc00394 <main+0xcc>
bfc0038c:	00000000 	nop
bfc00390:	00000000 	nop
bfc00394:	8fc20014 	lw	v0,20(s8)
bfc00398:	00000000 	nop
bfc0039c:	3842000a 	xori	v0,v0,0xa
bfc003a0:	2c420001 	sltiu	v0,v0,1
bfc003a4:	304200ff 	andi	v0,v0,0xff
bfc003a8:	00402021 	move	a0,v0
bfc003ac:	0ff00033 	jal	bfc000cc <print_result>
bfc003b0:	00000000 	nop
bfc003b4:	1000ffff 	b	bfc003b4 <main+0xec>
bfc003b8:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	0000000a 	0xa
80000004:	0000000b 	0xb
80000008:	0000000c 	syscall
8000000c:	0000000d 	break
80000010:	0000000e 	0xe
80000014:	0000000f 	0xf
80000018:	00000010 	mfhi	zero
8000001c:	00000011 	mthi	zero
80000020:	00000012 	mflo	zero
80000024:	00000013 	mtlo	zero
80000028:	00000014 	0x14
8000002c:	00000015 	0x15
80000030:	00000016 	0x16
80000034:	00000017 	0x17
80000038:	00000018 	mult	zero,zero
8000003c:	00000019 	multu	zero,zero
80000040:	0000001a 	div	zero,zero,zero
80000044:	0000001b 	divu	zero,zero,zero
80000048:	0000001c 	0x1c
8000004c:	0000001d 	0x1d
80000050:	0000001e 	0x1e
80000054:	0000001f 	0x1f
80000058:	00000020 	add	zero,zero,zero
8000005c:	00000021 	move	zero,zero
80000060:	00000022 	neg	zero,zero
80000064:	00000023 	negu	zero,zero
80000068:	00000024 	and	zero,zero,zero
8000006c:	00000025 	move	zero,zero
80000070:	00000026 	xor	zero,zero,zero
80000074:	00000027 	nor	zero,zero,zero
80000078:	00000028 	0x28
8000007c:	00000029 	0x29
80000080:	0000002a 	slt	zero,zero,zero
80000084:	0000002b 	sltu	zero,zero,zero
80000088:	0000002c 	0x2c
8000008c:	0000002d 	0x2d
80000090:	0000002e 	0x2e
80000094:	0000002f 	0x2f
80000098:	00000030 	0x30
8000009c:	00000031 	0x31
800000a0:	00000032 	0x32

800000a4 <test_data>:
800000a4:	00000011 	mthi	zero
800000a8:	0000001a 	div	zero,zero,zero
800000ac:	0000002d 	0x2d
800000b0:	0000001f 	0x1f
800000b4:	00000058 	0x58
800000b8:	0000001d 	0x1d
800000bc:	00000016 	0x16
800000c0:	00000023 	negu	zero,zero
800000c4:	00000029 	0x29
800000c8:	00000009 	jalr	zero,zero

800000cc <ans>:
800000cc:	00000007 	srav	zero,zero,zero
800000d0:	00000010 	mfhi	zero
800000d4:	00000023 	negu	zero,zero
800000d8:	00000015 	0x15
800000dc:	ffffffff 	0xffffffff
800000e0:	00000013 	mtlo	zero
800000e4:	0000000c 	syscall
800000e8:	00000019 	multu	zero,zero
800000ec:	0000001f 	0x1f
800000f0:	ffffffff 	0xffffffff

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	800080f0 	lb	zero,-32528(zero)

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
  64:	c0000000 	lwc0	$0,0(zero)
  68:	fffffffc 	0xfffffffc
	...
  74:	00000020 	add	zero,zero,zero
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f
  80:	bfc002c8 	0xbfc002c8
  84:	c0000000 	lwc0	$0,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000028 	0x28
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
