.set noreorder
   .set nomacro
   .set noat
   .globl main
   .text
main:
    j       L0
    nop
    BAD:
    addi    $v0, $v0, 0x1       # C += 1
    L0:
    addi    $at, $at, 0x1       # A = 0000 0001
    addi    $t0, $t0, 0x1       # B = 0000 0001
    beq     $at, $t0, L1
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L1:
    addi    $at, $at, 0x1       # A = 0000 0002
    bne     $at, $t0, L2
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L2:
    addi    $at, $zero, 0x0     # A = 0000 0000
    bgez    $at, L3
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L3:
    blez    $at, L4
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L4:
    addi    $at, $at, 0x1       # A = 0000 0001
    bgtz    $at, L5
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L5:
    addi    $at, $zero, 0xffff  # A = ffff ffff
    bltz    $at, L6
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L6:
    bltzal  $at, L7             # $ra = PC + 8
    nop
    addi    $v0, $v0, 0x1       # C += 1
    L7:
    bgezal  $at, BAD            # $ra = PC + 8
    nop
    jal     L8                  # $ra = PC + 8
    nop
    addi    $v0, $v0, 0x1       # C += 1                
    L8:
    addi    $ra, $ra, 0x14
    jr      $ra
    nop
    addi    $v0, $v0, 0x1       # C += 1
    addi    $ra, $ra, 0x10
    jalr    $at, $ra            # A = PC + 8
    nop
    addi    $v0, $v0, 0x1       # C += 1
    addi    $v0, $v0, 0x1234    # C = 0000 1234