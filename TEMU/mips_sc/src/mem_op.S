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
   lui      $t0, 0x8765
   nop
   nop
   nop           
   addi     $t0, $t0, 0x4321        # B = 8765 4321
   nop
   nop
   nop
   sw       $at, 0x0($zero)         # 0x0: 78 56 34 12
   sw       $t0, 0x4($zero)         # 0x4: 21 43 65 87
   lw       $v0, 0x0($zero)         # C = 1234 5678
   lh       $v0, 0x6($zero)         # C = ffff 8765
   lhu      $v0, 0x6($zero)         # C = 0000 8765
   lb       $v0, 0x7($zero)         # C = ffff ff87
   lbu      $v0, 0x7($zero)         # C = 0000 0087
   sw       $zero, 0x0($zero)       # 0x0: 00 00 00 00
   sw       $zero, 0x4($zero)       # 0x4: 00 00 00 00
   sh       $at, 0x2($zero)         # 0x0: 00 00 78 56
   lw       $v0, 0x0($zero)         # C = 5678 0000
   sb       $t0, 0x5($zero)         # 0x4: 00 21 00 00
   lw       $v0, 0x4($zero)         # C = 0000 2100