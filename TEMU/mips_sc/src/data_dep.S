.set noreorder
    .set nomacro
    .set noat
    .globl main
    .text
main:
    lui     $at, 0x1234             # A = 1234 0000
    addi    $at, $at, 0x5678        # A = 1234 5678(RAW)
    lui     $t0, 0x8765             # B = 8765 0000
    addi    $t0, $t0, 0x4321        # B = 8765 4321(RAW)
    addi    $v0, $t0, 0x1           # C = 8765 4322(RAW)
    addi    $v0, $v0, 0xffff        # C = 8765 4321(RAW)
    ori     $v0, $v0, 0xf           # C = 8765 432f(RAW)
    sll     $v0, $v0, 0x10          # C = 432f 0000(RAW)
    nop
    addi    $v0, $v0, 0x1           # C = 432f 0001(RAW)
    nop
    nop
    addi    $v0, $v0, 0xffff        # C = 432f 0000(RAW)
    mult    $at, $t0                # HI = f76c 768d, LO = 70b8 8d78
    mfhi    $at                     # A = f76c 768d(RAW)
    mflo    $t0                     # B = 70b8 8d78(RAW)