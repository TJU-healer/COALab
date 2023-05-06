
build/matrix:     file format elf32-tradbigmips
build/matrix


Disassembly of section .text:

bfc00000 <_start>:
bfc00000:	3c061000 	lui	a2,0x1000
bfc00004:	40866000 	mtc0	a2,c0_sr
bfc00008:	40806800 	mtc0	zero,c0_cause
bfc0000c:	3c1d8000 	lui	sp,0x8000
bfc00010:	27bd3fe0 	addiu	sp,sp,16352
bfc00014:	3c1e8001 	lui	s8,0x8001
bfc00018:	27de84a0 	addiu	s8,s8,-31584
bfc0001c:	34070000 	li	a3,0x0
bfc00020:	00e00013 	mtlo	a3
bfc00024:	34180000 	li	t8,0x0
bfc00028:	03000011 	mthi	t8
bfc0002c:	0bf0004e 	j	bfc00138 <main>
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

bfc00138 <main>:
main():
bfc00138:	27bdffd0 	addiu	sp,sp,-48
bfc0013c:	afbf002c 	sw	ra,44(sp)
bfc00140:	afbe0028 	sw	s8,40(sp)
bfc00144:	03a0f021 	move	s8,sp
bfc00148:	0ff00023 	jal	bfc0008c <init>
bfc0014c:	00000000 	nop
bfc00150:	afc0001c 	sw	zero,28(s8)
bfc00154:	afc00020 	sw	zero,32(s8)
bfc00158:	afc00010 	sw	zero,16(s8)
bfc0015c:	10000087 	b	bfc0037c <main+0x244>
bfc00160:	00000000 	nop
bfc00164:	afc00014 	sw	zero,20(s8)
bfc00168:	1000007b 	b	bfc00358 <main+0x220>
bfc0016c:	00000000 	nop
bfc00170:	3c048000 	lui	a0,0x8000
bfc00174:	8fc20010 	lw	v0,16(s8)
bfc00178:	00000000 	nop
bfc0017c:	00021040 	sll	v0,v0,0x1
bfc00180:	00021880 	sll	v1,v0,0x2
bfc00184:	00431021 	addu	v0,v0,v1
bfc00188:	8fc30014 	lw	v1,20(s8)
bfc0018c:	00000000 	nop
bfc00190:	00431021 	addu	v0,v0,v1
bfc00194:	00021880 	sll	v1,v0,0x2
bfc00198:	248204b0 	addiu	v0,a0,1200
bfc0019c:	00621021 	addu	v0,v1,v0
bfc001a0:	ac400000 	sw	zero,0(v0)
bfc001a4:	afc00018 	sw	zero,24(s8)
bfc001a8:	10000041 	b	bfc002b0 <main+0x178>
bfc001ac:	00000000 	nop
bfc001b0:	3c048000 	lui	a0,0x8000
bfc001b4:	8fc20010 	lw	v0,16(s8)
bfc001b8:	00000000 	nop
bfc001bc:	00021040 	sll	v0,v0,0x1
bfc001c0:	00021880 	sll	v1,v0,0x2
bfc001c4:	00431021 	addu	v0,v0,v1
bfc001c8:	8fc30014 	lw	v1,20(s8)
bfc001cc:	00000000 	nop
bfc001d0:	00431021 	addu	v0,v0,v1
bfc001d4:	00021880 	sll	v1,v0,0x2
bfc001d8:	248204b0 	addiu	v0,a0,1200
bfc001dc:	00621021 	addu	v0,v1,v0
bfc001e0:	8c430000 	lw	v1,0(v0)
bfc001e4:	3c058000 	lui	a1,0x8000
bfc001e8:	8fc20010 	lw	v0,16(s8)
bfc001ec:	00000000 	nop
bfc001f0:	00021040 	sll	v0,v0,0x1
bfc001f4:	00022080 	sll	a0,v0,0x2
bfc001f8:	00441021 	addu	v0,v0,a0
bfc001fc:	8fc40018 	lw	a0,24(s8)
bfc00200:	00000000 	nop
bfc00204:	00441021 	addu	v0,v0,a0
bfc00208:	00022080 	sll	a0,v0,0x2
bfc0020c:	24a20000 	addiu	v0,a1,0
bfc00210:	00821021 	addu	v0,a0,v0
bfc00214:	8c440000 	lw	a0,0(v0)
bfc00218:	3c068000 	lui	a2,0x8000
bfc0021c:	8fc20018 	lw	v0,24(s8)
bfc00220:	00000000 	nop
bfc00224:	00021040 	sll	v0,v0,0x1
bfc00228:	00022880 	sll	a1,v0,0x2
bfc0022c:	00451021 	addu	v0,v0,a1
bfc00230:	8fc50014 	lw	a1,20(s8)
bfc00234:	00000000 	nop
bfc00238:	00451021 	addu	v0,v0,a1
bfc0023c:	00022880 	sll	a1,v0,0x2
bfc00240:	24c20190 	addiu	v0,a2,400
bfc00244:	00a21021 	addu	v0,a1,v0
bfc00248:	8c420000 	lw	v0,0(v0)
bfc0024c:	00000000 	nop
bfc00250:	00820018 	mult	a0,v0
bfc00254:	00001012 	mflo	v0
bfc00258:	00621821 	addu	v1,v1,v0
bfc0025c:	3c058000 	lui	a1,0x8000
bfc00260:	8fc20010 	lw	v0,16(s8)
bfc00264:	00000000 	nop
bfc00268:	00021040 	sll	v0,v0,0x1
bfc0026c:	00022080 	sll	a0,v0,0x2
bfc00270:	00441021 	addu	v0,v0,a0
bfc00274:	8fc40014 	lw	a0,20(s8)
bfc00278:	00000000 	nop
bfc0027c:	00441021 	addu	v0,v0,a0
bfc00280:	00022080 	sll	a0,v0,0x2
bfc00284:	24a204b0 	addiu	v0,a1,1200
bfc00288:	00821021 	addu	v0,a0,v0
bfc0028c:	ac430000 	sw	v1,0(v0)
bfc00290:	8fc2001c 	lw	v0,28(s8)
bfc00294:	00000000 	nop
bfc00298:	24420001 	addiu	v0,v0,1
bfc0029c:	afc2001c 	sw	v0,28(s8)
bfc002a0:	8fc20018 	lw	v0,24(s8)
bfc002a4:	00000000 	nop
bfc002a8:	24420001 	addiu	v0,v0,1
bfc002ac:	afc20018 	sw	v0,24(s8)
bfc002b0:	8fc20018 	lw	v0,24(s8)
bfc002b4:	00000000 	nop
bfc002b8:	2842000a 	slti	v0,v0,10
bfc002bc:	1440ffbc 	bnez	v0,bfc001b0 <main+0x78>
bfc002c0:	00000000 	nop
bfc002c4:	3c048000 	lui	a0,0x8000
bfc002c8:	8fc20010 	lw	v0,16(s8)
bfc002cc:	00000000 	nop
bfc002d0:	00021040 	sll	v0,v0,0x1
bfc002d4:	00021880 	sll	v1,v0,0x2
bfc002d8:	00431021 	addu	v0,v0,v1
bfc002dc:	8fc30014 	lw	v1,20(s8)
bfc002e0:	00000000 	nop
bfc002e4:	00431021 	addu	v0,v0,v1
bfc002e8:	00021880 	sll	v1,v0,0x2
bfc002ec:	248204b0 	addiu	v0,a0,1200
bfc002f0:	00621021 	addu	v0,v1,v0
bfc002f4:	8c430000 	lw	v1,0(v0)
bfc002f8:	3c058000 	lui	a1,0x8000
bfc002fc:	8fc20010 	lw	v0,16(s8)
bfc00300:	00000000 	nop
bfc00304:	00021040 	sll	v0,v0,0x1
bfc00308:	00022080 	sll	a0,v0,0x2
bfc0030c:	00441021 	addu	v0,v0,a0
bfc00310:	8fc40014 	lw	a0,20(s8)
bfc00314:	00000000 	nop
bfc00318:	00441021 	addu	v0,v0,a0
bfc0031c:	00022080 	sll	a0,v0,0x2
bfc00320:	24a20320 	addiu	v0,a1,800
bfc00324:	00821021 	addu	v0,a0,v0
bfc00328:	8c420000 	lw	v0,0(v0)
bfc0032c:	00000000 	nop
bfc00330:	10620005 	beq	v1,v0,bfc00348 <main+0x210>
bfc00334:	00000000 	nop
bfc00338:	24020001 	li	v0,1
bfc0033c:	afc20020 	sw	v0,32(s8)
bfc00340:	10000019 	b	bfc003a8 <main+0x270>
bfc00344:	00000000 	nop
bfc00348:	8fc20014 	lw	v0,20(s8)
bfc0034c:	00000000 	nop
bfc00350:	24420001 	addiu	v0,v0,1
bfc00354:	afc20014 	sw	v0,20(s8)
bfc00358:	8fc20014 	lw	v0,20(s8)
bfc0035c:	00000000 	nop
bfc00360:	2842000a 	slti	v0,v0,10
bfc00364:	1440ff82 	bnez	v0,bfc00170 <main+0x38>
bfc00368:	00000000 	nop
bfc0036c:	8fc20010 	lw	v0,16(s8)
bfc00370:	00000000 	nop
bfc00374:	24420001 	addiu	v0,v0,1
bfc00378:	afc20010 	sw	v0,16(s8)
bfc0037c:	8fc20010 	lw	v0,16(s8)
bfc00380:	00000000 	nop
bfc00384:	2842000a 	slti	v0,v0,10
bfc00388:	1440ff76 	bnez	v0,bfc00164 <main+0x2c>
bfc0038c:	00000000 	nop
bfc00390:	8fc3001c 	lw	v1,28(s8)
bfc00394:	240203e8 	li	v0,1000
bfc00398:	10620003 	beq	v1,v0,bfc003a8 <main+0x270>
bfc0039c:	00000000 	nop
bfc003a0:	24020001 	li	v0,1
bfc003a4:	afc20020 	sw	v0,32(s8)
bfc003a8:	8fc20020 	lw	v0,32(s8)
bfc003ac:	00000000 	nop
bfc003b0:	2c420001 	sltiu	v0,v0,1
bfc003b4:	304200ff 	andi	v0,v0,0xff
bfc003b8:	00402021 	move	a0,v0
bfc003bc:	0ff00033 	jal	bfc000cc <print_result>
bfc003c0:	00000000 	nop
bfc003c4:	1000ffff 	b	bfc003c4 <main+0x28c>
bfc003c8:	00000000 	nop

Disassembly of section .data:

80000000 <_fdata>:
_fdata():
80000000:	0000001f 	0x1f
80000004:	ffffffb7 	0xffffffb7
80000008:	ffffffbd 	0xffffffbd
8000000c:	ffffffe4 	0xffffffe4
80000010:	00000057 	0x57
80000014:	ffffffef 	0xffffffef
80000018:	fffffff1 	0xfffffff1
8000001c:	ffffffdd 	0xffffffdd
80000020:	ffffffcb 	0xffffffcb
80000024:	ffffffca 	0xffffffca
80000028:	00000034 	0x34
8000002c:	00000024 	and	zero,zero,zero
80000030:	00000009 	jalr	zero,zero
80000034:	ffffffa5 	0xffffffa5
80000038:	ffffffe5 	0xffffffe5
8000003c:	ffffffb2 	0xffffffb2
80000040:	0000002a 	slt	zero,zero,zero
80000044:	00000052 	0x52
80000048:	00000013 	mtlo	zero
8000004c:	fffffffa 	0xfffffffa
80000050:	00000029 	0x29
80000054:	ffffffc8 	0xffffffc8
80000058:	0000001f 	0x1f
8000005c:	00000020 	add	zero,zero,zero
80000060:	ffffffcc 	0xffffffcc
80000064:	0000004a 	0x4a
80000068:	0000001c 	0x1c
8000006c:	00000014 	0x14
80000070:	00000037 	0x37
80000074:	ffffffb8 	0xffffffb8
80000078:	ffffffc5 	0xffffffc5
8000007c:	00000002 	srl	zero,zero,0x0
80000080:	ffffffb1 	0xffffffb1
80000084:	fffffff8 	0xfffffff8
80000088:	0000002c 	0x2c
8000008c:	00000037 	0x37
80000090:	ffffffad 	0xffffffad
80000094:	ffffffa1 	0xffffffa1
80000098:	ffffffd3 	0xffffffd3
8000009c:	00000032 	0x32
800000a0:	ffffffa1 	0xffffffa1
800000a4:	0000003d 	0x3d
800000a8:	ffffffc1 	0xffffffc1
800000ac:	0000003e 	0x3e
800000b0:	fffffff0 	0xfffffff0
800000b4:	00000034 	0x34
800000b8:	00000028 	0x28
800000bc:	0000005c 	0x5c
800000c0:	ffffffe0 	0xffffffe0
800000c4:	ffffffe6 	0xffffffe6
800000c8:	ffffff9d 	0xffffff9d
800000cc:	00000034 	0x34
800000d0:	00000060 	0x60
800000d4:	0000003f 	0x3f
800000d8:	ffffffb5 	0xffffffb5
800000dc:	ffffffb6 	0xffffffb6
800000e0:	ffffffae 	0xffffffae
800000e4:	00000052 	0x52
800000e8:	ffffffa1 	0xffffffa1
800000ec:	0000002a 	slt	zero,zero,zero
800000f0:	0000000b 	0xb
800000f4:	ffffffea 	0xffffffea
800000f8:	0000001b 	divu	zero,zero,zero
800000fc:	ffffffe5 	0xffffffe5
80000100:	ffffffe5 	0xffffffe5
80000104:	ffffffb4 	0xffffffb4
80000108:	ffffffb9 	0xffffffb9
8000010c:	0000003a 	0x3a
80000110:	ffffffd8 	0xffffffd8
80000114:	ffffffbf 	0xffffffbf
80000118:	0000005b 	0x5b
8000011c:	ffffffcb 	0xffffffcb
80000120:	ffffffbd 	0xffffffbd
80000124:	00000048 	0x48
80000128:	00000024 	and	zero,zero,zero
8000012c:	ffffffb3 	0xffffffb3
80000130:	fffffffd 	0xfffffffd
80000134:	0000005d 	0x5d
80000138:	ffffffe8 	0xffffffe8
8000013c:	00000061 	0x61
80000140:	ffffffcc 	0xffffffcc
80000144:	fffffff5 	0xfffffff5
80000148:	ffffffb3 	0xffffffb3
8000014c:	ffffffa3 	0xffffffa3
80000150:	ffffffa4 	0xffffffa4
80000154:	ffffffe8 	0xffffffe8
80000158:	00000046 	0x46
8000015c:	00000012 	mflo	zero
80000160:	00000038 	0x38
80000164:	00000058 	0x58
80000168:	ffffffd5 	0xffffffd5
8000016c:	ffffffd7 	0xffffffd7
80000170:	ffffffe6 	0xffffffe6
80000174:	0000000b 	0xb
80000178:	ffffffac 	0xffffffac
8000017c:	fffffff2 	0xfffffff2
80000180:	ffffffd7 	0xffffffd7
80000184:	00000053 	0x53
80000188:	0000001b 	divu	zero,zero,zero
8000018c:	fffffff5 	0xfffffff5

80000190 <b>:
80000190:	ffffffd0 	0xffffffd0
80000194:	ffffffba 	0xffffffba
80000198:	ffffffd8 	0xffffffd8
8000019c:	ffffffae 	0xffffffae
800001a0:	ffffffb6 	0xffffffb6
800001a4:	ffffffc1 	0xffffffc1
800001a8:	ffffffc5 	0xffffffc5
800001ac:	ffffffb8 	0xffffffb8
800001b0:	ffffff9c 	0xffffff9c
800001b4:	ffffffb8 	0xffffffb8
800001b8:	00000005 	0x5
800001bc:	ffffffac 	0xffffffac
800001c0:	0000001c 	0x1c
800001c4:	00000038 	0x38
800001c8:	0000003c 	0x3c
800001cc:	ffffffdf 	0xffffffdf
800001d0:	ffffffd6 	0xffffffd6
800001d4:	ffffffce 	0xffffffce
800001d8:	ffffffad 	0xffffffad
800001dc:	ffffffad 	0xffffffad
800001e0:	fffffffb 	0xfffffffb
800001e4:	00000005 	0x5
800001e8:	00000030 	0x30
800001ec:	0000004b 	0x4b
800001f0:	ffffffb2 	0xffffffb2
800001f4:	fffffff7 	0xfffffff7
800001f8:	00000009 	jalr	zero,zero
800001fc:	00000002 	srl	zero,zero,0x0
80000200:	00000058 	0x58
80000204:	00000046 	0x46
80000208:	00000045 	0x45
8000020c:	00000017 	0x17
80000210:	00000042 	srl	zero,zero,0x1
80000214:	00000042 	srl	zero,zero,0x1
80000218:	fffffff5 	0xfffffff5
8000021c:	00000032 	0x32
80000220:	00000043 	sra	zero,zero,0x1
80000224:	00000012 	mflo	zero
80000228:	ffffffc6 	0xffffffc6
8000022c:	0000004c 	syscall	0x1
80000230:	0000001e 	0x1e
80000234:	0000002d 	0x2d
80000238:	00000020 	add	zero,zero,zero
8000023c:	00000019 	multu	zero,zero
80000240:	ffffffb7 	0xffffffb7
80000244:	00000039 	0x39
80000248:	ffffffbd 	0xffffffbd
8000024c:	fffffff2 	0xfffffff2
80000250:	00000035 	0x35
80000254:	ffffffdf 	0xffffffdf
80000258:	00000062 	0x62
8000025c:	ffffffaa 	0xffffffaa
80000260:	ffffffc1 	0xffffffc1
80000264:	00000050 	0x50
80000268:	ffffffd3 	0xffffffd3
8000026c:	ffffffa8 	0xffffffa8
80000270:	00000050 	0x50
80000274:	ffffffc0 	0xffffffc0
80000278:	0000003a 	0x3a
8000027c:	ffffffac 	0xffffffac
80000280:	ffffffc9 	0xffffffc9
80000284:	ffffffd9 	0xffffffd9
80000288:	fffffff3 	0xfffffff3
8000028c:	ffffffe5 	0xffffffe5
80000290:	ffffffdb 	0xffffffdb
80000294:	00000008 	jr	zero
80000298:	ffffffa0 	0xffffffa0
8000029c:	00000054 	0x54
800002a0:	ffffffa7 	0xffffffa7
800002a4:	0000001f 	0x1f
800002a8:	ffffffae 	0xffffffae
800002ac:	0000003a 	0x3a
800002b0:	00000051 	0x51
800002b4:	ffffffd7 	0xffffffd7
800002b8:	ffffffc6 	0xffffffc6
800002bc:	00000024 	and	zero,zero,zero
800002c0:	0000004c 	syscall	0x1
800002c4:	ffffffb1 	0xffffffb1
800002c8:	ffffffe3 	0xffffffe3
800002cc:	00000017 	0x17
800002d0:	00000056 	0x56
800002d4:	ffffffd2 	0xffffffd2
800002d8:	00000010 	mfhi	zero
800002dc:	ffffffee 	0xffffffee
800002e0:	00000051 	0x51
800002e4:	0000005a 	0x5a
800002e8:	00000023 	negu	zero,zero
800002ec:	ffffffa6 	0xffffffa6
800002f0:	0000002b 	sltu	zero,zero,zero
800002f4:	00000037 	0x37
800002f8:	ffffffda 	0xffffffda
800002fc:	ffffffed 	0xffffffed
80000300:	ffffffd8 	0xffffffd8
80000304:	00000052 	0x52
80000308:	ffffffb4 	0xffffffb4
8000030c:	00000039 	0x39
80000310:	ffffffe3 	0xffffffe3
80000314:	fffffffe 	0xfffffffe
80000318:	0000004f 	0x4f
8000031c:	ffffffd0 	0xffffffd0

80000320 <ans>:
80000320:	fffffadb 	0xfffffadb
80000324:	0000288b 	0x288b
80000328:	ffffe943 	0xffffe943
8000032c:	ffffc80e 	0xffffc80e
80000330:	ffffef16 	0xffffef16
80000334:	fffff3d6 	0xfffff3d6
80000338:	ffffd92c 	0xffffd92c
8000033c:	00001b79 	0x1b79
80000340:	fffff8a5 	0xfffff8a5
80000344:	ffffe875 	0xffffe875
80000348:	ffffa136 	0xffffa136
8000034c:	fffffca3 	0xfffffca3
80000350:	00000fcc 	syscall	0x3f
80000354:	ffffb290 	0xffffb290
80000358:	ffffff21 	0xffffff21
8000035c:	00000376 	0x376
80000360:	ffffd12c 	0xffffd12c
80000364:	ffffe6d6 	0xffffe6d6
80000368:	ffffc9ea 	0xffffc9ea
8000036c:	fffffbe2 	0xfffffbe2
80000370:	00002637 	0x2637
80000374:	ffffe45f 	0xffffe45f
80000378:	fffffc6a 	0xfffffc6a
8000037c:	ffffe8e9 	0xffffe8e9
80000380:	fffffc39 	0xfffffc39
80000384:	ffffe444 	0xffffe444
80000388:	0000390d 	break	0x0,0xe4
8000038c:	ffffe27c 	0xffffe27c
80000390:	fffff291 	0xfffff291
80000394:	00002587 	0x2587
80000398:	00003e6c 	0x3e6c
8000039c:	fffffdf8 	0xfffffdf8
800003a0:	ffffcc0f 	0xffffcc0f
800003a4:	00003ac3 	sra	a3,zero,0xb
800003a8:	00001829 	0x1829
800003ac:	fffff1ba 	0xfffff1ba
800003b0:	0000052d 	0x52d
800003b4:	00001061 	0x1061
800003b8:	0000421d 	0x421d
800003bc:	ffffba9f 	0xffffba9f
800003c0:	00000a06 	0xa06
800003c4:	00000c73 	0xc73
800003c8:	00002808 	0x2808
800003cc:	00001ef5 	0x1ef5
800003d0:	000018ae 	0x18ae
800003d4:	0000058d 	break	0x0,0x16
800003d8:	00003938 	0x3938
800003dc:	000002bc 	0x2bc
800003e0:	ffffd05f 	0xffffd05f
800003e4:	0000043b 	0x43b
800003e8:	ffffcec5 	0xffffcec5
800003ec:	00004a3e 	0x4a3e
800003f0:	000051d8 	0x51d8
800003f4:	000048a7 	0x48a7
800003f8:	fffff9fd 	0xfffff9fd
800003fc:	00001440 	sll	v0,zero,0x11
80000400:	00004400 	sll	t0,zero,0x10
80000404:	00001a54 	0x1a54
80000408:	00001878 	0x1878
8000040c:	00003b0a 	0x3b0a
80000410:	ffffce55 	0xffffce55
80000414:	00003b11 	0x3b11
80000418:	000026eb 	0x26eb
8000041c:	ffffca6b 	0xffffca6b
80000420:	0000096b 	0x96b
80000424:	fffff76c 	0xfffff76c
80000428:	00001803 	sra	v1,zero,0x0
8000042c:	fffff95e 	0xfffff95e
80000430:	fffff2c3 	0xfffff2c3
80000434:	00002008 	0x2008
80000438:	ffffb5c1 	0xffffb5c1
8000043c:	00003081 	0x3081
80000440:	0000165b 	0x165b
80000444:	ffffd3d3 	0xffffd3d3
80000448:	ffffb4d6 	0xffffb4d6
8000044c:	00003d7c 	0x3d7c
80000450:	fffff131 	0xfffff131
80000454:	fffff093 	0xfffff093
80000458:	ffffccb6 	0xffffccb6
8000045c:	ffffffeb 	0xffffffeb
80000460:	ffffcef3 	0xffffcef3
80000464:	ffffe8ae 	0xffffe8ae
80000468:	ffffd2ce 	0xffffd2ce
8000046c:	ffffdd37 	0xffffdd37
80000470:	00002fc3 	sra	a1,zero,0x1f
80000474:	00001e86 	0x1e86
80000478:	ffffec1a 	0xffffec1a
8000047c:	000011b4 	0x11b4
80000480:	0000042f 	0x42f
80000484:	fffffae3 	0xfffffae3
80000488:	fffff475 	0xfffff475
8000048c:	000024a5 	0x24a5
80000490:	000018e4 	0x18e4
80000494:	ffffe50e 	0xffffe50e
80000498:	0000239d 	0x239d
8000049c:	00001679 	0x1679
800004a0:	0000512a 	0x512a
800004a4:	ffffec4b 	0xffffec4b
800004a8:	00000417 	0x417
800004ac:	00002f52 	0x2f52

Disassembly of section .bss:

800004b0 <c>:
	...

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	710000c0 	0x710000c0
	...
  14:	800084a0 	lb	zero,-31584(zero)

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
  74:	00000030 	0x30
  78:	0000001e 	0x1e
  7c:	0000001f 	0x1f

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
