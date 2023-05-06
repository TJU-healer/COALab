
build/exception:     file format elf32-tradlittlemips
build/exception


Disassembly of section .text:

bfc00000 <main>:
bfc00000:	0000000c 	syscall
bfc00004:	4a000000 	c2	0x0
bfc00008:	3c01ffff 	lui	at,0xffff
bfc0000c:	3c088000 	lui	t0,0x8000
bfc00010:	00280820 	add	at,at,t0
bfc00014:	20010001 	addi	at,zero,1
bfc00018:	8c280000 	lw	t0,0(at)
bfc0001c:	ac280000 	sw	t0,0(at)
bfc00020:	84280000 	lh	t0,0(at)
bfc00024:	a4280000 	sh	t0,0(at)
bfc00028:	0007000d 	break	0x7
bfc0002c:	0bf00147 	j	bfc0051c <_etext>
bfc00030:	00000000 	nop
	...
bfc00380:	40026800 	mfc0	v0,c0_cause
bfc00384:	00021082 	srl	v0,v0,0x2
bfc00388:	3042001f 	andi	v0,v0,0x1f
bfc0038c:	0bf00140 	j	bfc00500 <exc_eret>
bfc00390:	00000000 	nop
	...

bfc00500 <exc_eret>:
exc_eret():
bfc00500:	40097000 	mfc0	t1,c0_epc
bfc00504:	21290004 	addi	t1,t1,4
bfc00508:	40897000 	mtc0	t1,c0_epc
bfc0050c:	42000018 	c0	0x18
	...

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	00000306 	0x306
	...
