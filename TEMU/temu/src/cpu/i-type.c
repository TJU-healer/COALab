#include "helper.h"
#include "monitor.h"
#include "reg.h"

#define MASK_IMM (int)0xFFFF0000

extern uint32_t instr;
extern char assembly[80];

/* decode I-type instrucion with unsigned immediate */
static void decode_imm_type(uint32_t instr) {

	op_src1->type = OP_TYPE_REG;
	op_src1->reg = (instr & RS_MASK) >> (RT_SIZE + IMM_SIZE);
	op_src1->val = reg_w(op_src1->reg);
	
	op_src2->type = OP_TYPE_IMM;
	op_src2->imm = instr & IMM_MASK;
	op_src2->val = op_src2->imm;

	op_dest->type = OP_TYPE_REG;
	op_dest->reg = (instr & RT_MASK) >> (IMM_SIZE);
}


make_helper(addi){
	int imm, res;
	decode_imm_type(instr);
	if(op_src2->val & 0x8000)     //负数
		imm = MASK_IMM | op_src2->val;  //符号扩展
	else      //正数
		imm = op_src2->val; //位扩展
	
	res = (int)op_src1->val + imm;

	if(((int)op_src1->val > 0 && imm > 0 && res < 0) || ((int)op_src1->val < 0 && imm < 0 && res > 0)) {
		if(cpu.cp0.Status.EXL == 0){  //当前处理器没有在处理异常
			cpu.cp0.Cause.ExcCode = Ov;  //整数溢出异常
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR; //转移到异常处理程序入口地址
		}
	}else{
		reg_w(op_dest->reg) = res;
		write_trace(op_dest->reg, res);
	}

	sprintf(assembly, "ADDI %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(addiu){
	decode_imm_type(instr);
	int imm; 
	if(op_src2->val & 0x8000) 
		imm = MASK_IMM | op_src2->val;
	else 
		imm = op_src2->val;
	
	uint32_t res = op_src1->val + imm;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "ADDIU %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(slti){
	decode_imm_type(instr);
	int imm; 
	if(op_src2->val & 0x8000) 
		imm = MASK_IMM | op_src2->val;
	else 
		imm = op_src2->val;

    if((int)op_src1->val < imm){
		reg_w(op_dest->reg) = 1;
		write_trace(op_dest->reg, 1);
	}
	else{
		reg_w(op_dest->reg) = 0;
		write_trace(op_dest->reg, 0);
	}                  
	    
	sprintf(assembly, "SLTI %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(sltiu){
	decode_imm_type(instr);
	int imm;
	if(op_src2->val & 0x8000) 
		imm = MASK_IMM | op_src2->val;
	else 
		imm = op_src2->val;

	if(op_src1->val < imm){
		reg_w(op_dest->reg) = 1;
		write_trace(op_dest->reg, 1);
	}
	else{
		reg_w(op_dest->reg) = 0;
		write_trace(op_dest->reg, 0);
	}
	sprintf(assembly, "SLTIU %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(andi) {
	decode_imm_type(instr);
	uint32_t res = op_src1->val & op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "ANDI %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(lui) {
	decode_imm_type(instr);
	uint32_t res = (op_src2->val << 16);
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "LUI %s, 0x%04x", REG_NAME(op_dest->reg), op_src2->imm);
}

make_helper(ori) {
	decode_imm_type(instr);
	uint32_t res = op_src1->val | op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "ORI %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(xori) {
	decode_imm_type(instr);
	uint32_t res = op_src1->val ^ op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "XORI %s, %s, 0x%04x", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(beq) {
	decode_imm_type(instr);
	if(reg_w(op_src1->reg) == reg_w(op_dest->reg)) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val; 
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BEQ %s, %s, 0x%04x", REG_NAME(op_src1->reg), REG_NAME(op_dest->reg), op_src2->val);
	
}

make_helper(bne) {
	decode_imm_type(instr);
	if( reg_w(op_src1->reg)!= reg_w(op_dest->reg)) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BNE %s, %s, 0x%04x", REG_NAME(op_src1->reg),REG_NAME(op_dest->reg), op_src2->val);
}

make_helper(bgez) {
	decode_imm_type(instr);
	if((int)op_src1->val >= 0) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BGEZ %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(bgtz) {
	decode_imm_type(instr);
	if((int)op_src1->val > 0) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BGTZ %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(blez) {
	decode_imm_type(instr);
	if((int)op_src1->val <= 0) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BLEZ %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(bltz) {
	decode_imm_type(instr);
	if((int)op_src1->val < 0) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = (int)cpu.pc + (offset << 2);
		cpu.pc = addr;
	}
	sprintf(assembly, "BLTZ %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(bgezal) {
	decode_imm_type(instr);
	if(((int)op_src1->val) >= 0) {
		int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
		uint32_t addr = cpu.pc + (offset << 2);
		reg_w(31) = cpu.pc + 8;
		cpu.pc = addr;
	}else {
		reg_w(31) = cpu.pc + 8;
	}
	sprintf(assembly, "BGEZAL %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}

make_helper(bltzal) {
	decode_imm_type(instr);
    if(((int)op_src1->val) < 0){
        int offset;
		if(op_src2->val & 0x8000){
			offset = MASK_IMM | op_src2->val;
		} 
	    else {
			offset = op_src2->val;
		}
        uint32_t addr = cpu.pc + (offset << 2);
        reg_w(31) = cpu.pc + 8;
        cpu.pc = addr;
    }else {
        reg_w(31) = cpu.pc + 8;
    }
	sprintf(assembly, "BLTZAL %s, 0x%04x", REG_NAME(op_src1->reg), op_src2->val);
}


make_helper(lb) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;
	
	int val = mem_read((uint32_t)addr, 1);
	if(val & 0x80) {
		val = (int)0xFFFFFF00 | val;
	}
	reg_w(op_dest->reg) = val;

	write_trace(op_dest->reg, val);
	sprintf(assembly, "LB %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(lbu) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;
	
	int val = mem_read((uint32_t)addr, 1);

	reg_w(op_dest->reg) = val;
	
	write_trace(op_dest->reg, val);
	sprintf(assembly, "LBU %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(lh) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;

	if(addr & 0x1) {
		// 地址错异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdEL;
			cpu.cp0.BadVAddr = addr;
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR;
		}
	}else {
		int val = mem_read((uint32_t)addr, 2);
		if(val & 0x8000) {
			val = (int)0xFFFF0000 | val;
		}
		reg_w(op_dest->reg) = val;
		write_trace(op_dest->reg, val);
	}
	sprintf(assembly, "LH %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(lhu) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;
	if(addr & 0x1) {
		// 地址错异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdEL;
			cpu.cp0.BadVAddr = addr;
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR;
		}
	}else {
		int val = mem_read((uint32_t)addr, 2);
		reg_w(op_dest->reg) = val;
		write_trace(op_dest->reg, val);
	}
	sprintf(assembly, "LHU %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(lw) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;
	if(addr & 0x3) {
		// 地址错异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdEL;
			cpu.cp0.BadVAddr = addr;
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR;
		}
	}else {
		uint32_t val = mem_read((uint32_t)addr, 4);
		reg_w(op_dest->reg) = val;
		write_trace(op_dest->reg, val);
	}
	sprintf(assembly, "LW %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));

}

make_helper(sb) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;

	mem_write((uint32_t)addr, 1, reg_w(op_dest->reg));
	
	sprintf(assembly, "SB %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(sh) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;

	if(addr & 0x1) {
		// 地址错异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdES;
			cpu.cp0.BadVAddr = addr;
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR;
		}
	}
	else {
		mem_write((uint32_t)addr, 2, reg_w(op_dest->reg));
	}
	sprintf(assembly, "SH %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}

make_helper(sw) {
	decode_imm_type(instr);
	int offset;
	if(op_src2->val & 0x8000){
		offset = MASK_IMM | op_src2->val;
	}
	else {
		offset = op_src2->val;
	}
	int addr = op_src1->val + offset;
	if(addr & 0x3) {
		// 地址错异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdES;
			cpu.cp0.BadVAddr = addr;
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR;
		}
	}else {
		mem_write((uint32_t)addr, 4, reg_w(op_dest->reg));
	}
	sprintf(assembly, "SW %s, 0x%08x(%s)", REG_NAME(op_dest->reg), op_src2->val, REG_NAME(op_src1->reg));
}