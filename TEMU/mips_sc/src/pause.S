.set noreorder
    .set at
    .set macro
    .globl main
    .text
main:
    addi    $v0, $v0, 0x1234    # C = 0000 1234
    addi    $t0, $t0, 0x10      # B = 0000 0010
    divu    $v0, $t0            # HI = 0000 0004, LO = 0000 0123, C = 0000 0123
    addi    $v0, $zero, 0x1234  # C = 0000 1234
    addi    $t0, $zero, 0xfff0  # B = ffff fff0
    div     $v0, $t0            # HI = 0000 0004, LO = ffff fedd, C = ffff fedd
    addi    $t0, $zero, 0x1234  # B = 0000 1234
    sw      $t0, 0x0($zero)     # 0x0: 34 12 00 00
    addi    $t0, $t0, 0x4       # B = 0000 1238
    loop:
    lw      $v0, 0x0($zero)
    addi    $v0, $v0, 0x1       # C += 1(RAW)
    sw      $v0, 0x0($zero)    
    beq     $v0, $t0, done
    nop
    j       loop
    done:
