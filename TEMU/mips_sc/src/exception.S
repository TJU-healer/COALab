#include "trap.h"
.set noreorder
    .set noat
    .globl main
    .text
main:
    syscall
    HIT_GOOD_TRAP       
    lui     $at, 0xffff         # A = ffff 0000
    lui     $t0, 0x8000         # B = 8000 0000
    add     $at, $at, $t0
    addi    $at, $zero, 0x1     # A = 0000 0001
    lw      $t0, 0x0($at)
    sw      $t0, 0x0($at)
    lh      $t0, 0x0($at)
    sh      $t0, 0x0($at)
    div     $at, $zero
    j done

    .org 0x380
    mfc0    $v0, $13            # C = Cause
    srl     $v0, $v0, 0x2
    andi    $v0, $v0, 0x1f      # C = Cause.ExcCode
    j exc_eret

    .org 0x500
    exc_eret:
    mfc0    $t1, $14
    addi    $t1, $t1, 0x4
    mtc0    $t1, $14
    .set mips32
    eret
    .set mips1
    nop
    nop
    nop
    done:



