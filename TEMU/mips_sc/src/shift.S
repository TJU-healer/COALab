.set noreorder
   .set nomacro
   .set noat
   .globl main
   .text
main:
   ori      $at, $zero, 0xabcd      # A = 0000 abcd
   addi     $t0, $zero, 0x0030      # B = 0000 0030
   nop
   nop
   nop
   sll      $v0, $at, 0x14          # C = bcd0 0000
   sllv     $v0, $at, $t0           # C = abcd 0000
   nop
   nop
   nop
   add      $at, $zero, $v0         # A = abcd 0000
   nop
   nop
   nop
   sra      $v0, $at, 0x14          # C = ffff fabc
   srav     $v0, $at, $t0           # C = ffff abcd
   srl      $v0, $at, 0x14          # C = 0000 0abc
   srlv     $v0, $at, $t0           # C = 0000 abcd