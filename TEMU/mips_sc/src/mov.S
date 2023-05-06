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
   mult     $at, $t0                # HI = f76c 768d, LO = 70b8 8d78
   nop
   nop
   nop
   mfhi     $v0                     # C = f76c 768d
   mflo     $v0                     # C = 70b8 8d78
   mthi     $at                     # HI = 1234 5678
   mtlo     $t0                     # LO = 8765 4321