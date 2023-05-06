.set noreorder
   .set nomacro
   .set noat
   .globl main
   .text
main:
   lui      $at, 0x1234
   nop
   nop
   nop
   addi     $at, $at, 0x5678        # A = 1234 5678    
   addi     $t0, $t0, 0xabcd        # B = ffff abcd
   nop
   nop
   nop
   and      $v0, $at, $t0           # C = 1234 0248
   andi     $v0, $at, 0xabcd        # C = 0000 0248
   lui      $v0, 0x1234             # C = 1234 0000
   nor      $v0, $at, $t0           # C = 0000 0002
   or       $v0, $at, $t0           # C = ffff fffd
   ori      $v0, $at, 0xabcd        # C = 1234 fffd
   xor      $v0, $at, $t0           # C = edcb fdb5
   xori     $v0, $at, 0xabcd        # C = 1234 fdb5