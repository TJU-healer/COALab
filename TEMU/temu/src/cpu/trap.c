#include "helper.h"
#include "monitor.h"
#include "reg.h"

extern uint32_t instr;
extern char assembly[80];

static void decode_mfc0(uint32_t instr) { //MFC0解码器
    op_src1->type = OP_TYPE_REG;
    op_src1->reg = (instr & 0x0000F800) >> 11;

    op_dest->type = OP_TYPE_REG;
    op_dest->reg = (instr & 0x001F0000) >> 16;
}

static void decode_mtc0(uint32_t instr) { //MTC0解码器
    op_src1->type = OP_TYPE_REG;
    op_src1->reg = (instr & 0x001F0000) >> 16;

    op_dest->type = OP_TYPE_REG;
    op_dest->reg = (instr & 0x001F0000) >> 11;
}

make_helper(_break) { //触发断点异常
    cpu.cp0.Cause.ExcCode = Bp;
    cpu.cp0.EPC = cpu.pc;
    cpu.cp0.Status.EXL = 1;
    cpu.pc = TRAP_ADDR;
    
    sprintf(assembly, "BREAK");
    temu_state = STOP;
}

make_helper(syscall) { //系统调用
    cpu.cp0.Cause.ExcCode = Sys;
    cpu.cp0.EPC = cpu.pc;
    cpu.cp0.Status.EXL = 1;
    cpu.pc = TRAP_ADDR;
    sprintf(assembly, "SYSCALL");
}

make_helper(eret) {  //异常返回
    cpu.pc = cpu.cp0.EPC;
    cpu.cp0.Status.EXL = 0;
    sprintf(assembly, "ERET");
}

make_helper(mfc0) { //读cp0中的寄存器
    decode_mfc0(instr);
    switch(op_src1->reg){
        case BadVAddr_R : 
           reg_w(op_dest->reg) = cpu.cp0.BadVAddr;
           sprintf(assembly, "MFC0 %s, $%d", REG_NAME(op_dest->reg), BadVAddr_R);
           write_trace(op_dest->reg, cpu.cp0.BadVAddr);
           break;
        case Cause_R :
           reg_w(op_dest->reg) = cpu.cp0.Cause.val;
           sprintf(assembly, "MFC0 %s, $%d", REG_NAME(op_dest->reg), Cause_R);
           write_trace(op_dest->reg, cpu.cp0.Cause.val);
           break;
        case Status_R :
           reg_w(op_dest->reg) = cpu.cp0.Status.val;
           sprintf(assembly, "MFC0 %s, $%d", REG_NAME(op_dest->reg), Status_R);
           write_trace(op_dest->reg, cpu.cp0.Status.val);
           break;
        case EPC_R :
           reg_w(op_dest->reg) = cpu.cp0.EPC;
           sprintf(assembly, "MFC0 %s, $%d", REG_NAME(op_dest->reg), EPC_R);
           write_trace(op_dest->reg, cpu.cp0.EPC);
           break;
        default : 
           panic("Invalid cp0 register!\n");
    }
}

make_helper(mtc0) { //写CP0中的寄存器
   decode_mtc0(instr);
    switch(op_dest->reg){
        case BadVAddr_R : 
           cpu.cp0.BadVAddr = reg_w(op_src1->reg);
           sprintf(assembly, "MTC0 %s, $%d", REG_NAME(op_src1->reg), BadVAddr_R);
           break;
        case Cause_R :
           cpu.cp0.Cause.val = reg_w(op_src1->reg);
           sprintf(assembly, "MTC0 %s, $%d", REG_NAME(op_src1->reg), Cause_R);
           break;
        case Status_R :
           cpu.cp0.Status.val  = reg_w(op_src1->reg);
           sprintf(assembly, "MTC0 %s, $%d", REG_NAME(op_src1->reg), Status_R);
           break;
        case EPC_R :
           cpu.cp0.EPC  = reg_w(op_src1->reg);
           sprintf(assembly, "MTC0 %s, $%d", REG_NAME(op_src1->reg), EPC_R);
           break;
        default : 
           panic("Invalid cp0 register!\n");
    }
}
