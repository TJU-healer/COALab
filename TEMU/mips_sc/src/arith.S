.set noreorder
   .set nomacro
   .set noat
   .globl main
   .text
main:
   addi     $at, $zero, 0x1234      # A = 0000 1234         
   addi     $t0, $zero, 0xffff      # B = ffff ffff
   nop
   nop
   nop
   add      $v0, $at, $t0           # C = 0000 1233
   addi     $v0, $at, 0xfffe        # C = 0000 1232
   addu     $v0, $at, $t0           # C = 0000 1233
   addiu    $v0, $at, 0xfffe        # C = 0000 1232
   sub      $v0, $at, $t0           # C = 0000 1235
   subu     $v0, $t0, $at           # C = ffff edcb
   slt      $v0, $t0, $at           # C = 0000 0001
   slti     $v0, $t0, 0xfffe        # C = 0000 0000
   sltu     $v0, $at, $t0           # C = 0000 0001
   sltiu    $v0, $t0, 0xfffe        # C = 0000 0000
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
   mthi     $zero                   
   mtlo     $zero                   # HI = 0000 0000, LO = 0000 0000
   multu    $at, $t0                # HI = 09a0 cd05, LO = 70b8 8d78
   
