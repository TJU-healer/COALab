#include "helper.h"
#include "monitor.h"
#include "reg.h"

extern uint32_t instr;
extern char assembly[80];

/* decode R-type instrucion */
static void decode_r_type(uint32_t instr) {

	op_src1->type = OP_TYPE_REG;
	op_src1->reg = (instr & RS_MASK) >> (RT_SIZE + IMM_SIZE);
	op_src1->val = reg_w(op_src1->reg);
	
	op_src2->type = OP_TYPE_REG;
	op_src2->imm = (instr & RT_MASK) >> (RD_SIZE + SHAMT_SIZE + FUNC_SIZE);
	op_src2->val = reg_w(op_src2->reg);

	op_dest->type = OP_TYPE_REG;
	op_dest->reg = (instr & RD_MASK) >> (SHAMT_SIZE + FUNC_SIZE);
}

make_helper(add) {
	decode_r_type(instr);
	uint32_t res = (int)(op_src1->val) + (int)(op_src2->val);
	if (((int)op_src1->val > 0 && (int)op_src2->val > 0 && res < 0) || ((int)op_src1->val < 0 && (int)op_src2->val < 0 && res > 0)) {
		if(cpu.cp0.Status.EXL == 0){  //当前处理器没有在处理异常
			cpu.cp0.Cause.ExcCode = Ov;  //整数溢出异常
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR; //转移到异常处理程序入口地址
		}
	}else {
		reg_w(op_dest->reg) = res;
		write_trace(op_dest->reg, res);
	}
	sprintf(assembly, "ADD %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(addu) {
	decode_r_type(instr);
	uint32_t res = op_src1->val + op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "ADDIU %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(sub) {
	decode_r_type(instr);
	uint32_t res = (int)(op_src1->val) - (int)(op_src2->val);
	if(((int)op_src1->val > 0 && (int)op_src2->val < 0 && res < 0) || ((int)op_src1->val < 0 && (int)op_src2->val > 0 && res > 0)) {
		//SignalException(IntegerOverflow)
		if(cpu.cp0.Status.EXL == 0){  
			cpu.cp0.Cause.ExcCode = Ov;  
			cpu.cp0.EPC = cpu.pc;
			cpu.cp0.Status.EXL = 1;
			cpu.pc = TRAP_ADDR; 
		}
	}else{
		reg_w(op_dest->reg) = res;
		write_trace(op_dest->reg, res);
	} 
	sprintf(assembly, "SUB %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(subu) {
	decode_r_type(instr);
	uint32_t res = op_src1->val - op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "SUBU %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(slt) {
	decode_r_type(instr);
	uint32_t res = ((int)op_src1->val < (int)op_src2->val) ? 1 : 0;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "SLT %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(sltu) {
	decode_r_type(instr);
	uint32_t res = (op_src1->val < op_src2->val) ? 1 : 0;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "SLT %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(div) {
	decode_r_type(instr);
	int val_lo = (int)op_src1->val / (int)op_src2->val;
	int val_hi = (int)op_src1->val % (int)op_src2->val;
	cpu.lo = val_lo;
	cpu.hi = val_hi;
	write_trace(34, val_lo);
	write_trace(33, val_hi);
	sprintf(assembly, "DIV %s, %s", REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}


make_helper(divu) {
	decode_r_type(instr);
	uint32_t val_lo = op_src1->val / op_src2->val;
	uint32_t val_hi = op_src1->val % op_src2->val;
	cpu.lo = val_lo;
	cpu.hi = val_hi;
	write_trace(34, val_lo);
	write_trace(33, val_hi);
	sprintf(assembly, "DIVU %s, %s", REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(mult) {
	decode_r_type(instr);
	long long val1, val2;
	if((int)op_src1->val < 0) {
		val1 = (0xFFFFFFFFLL << 32) | op_src1->val;
	}else {
		val1 = op_src1->val;
	}
	
	if((int)op_src2->val < 0) {
		val2 = (0xFFFFFFFFLL << 32) | op_src2->val;
	}else {
		val2 = op_src2->val;
	}

	uint64_t val = val1 * val2;
	uint32_t val_lo = val & 0xFFFFFFFF;
	uint32_t val_hi = (val >> 32) & 0xFFFFFFFF;
	cpu.lo = val_lo;
	cpu.hi = val_hi;
	write_trace(34, val_lo);
	write_trace(33, val_hi);
	sprintf(assembly, "MULT %s, %s", REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(multu) {
	decode_r_type(instr);
	uint64_t val = (uint64_t)op_src1->val * (uint64_t)op_src2->val;
	uint32_t val_lo = val & 0xFFFFFFFF;
	uint32_t val_hi = (val >> 32) & 0xFFFFFFFF;
	cpu.lo = val_lo;
	cpu.hi = val_hi;
	write_trace(34, val_lo);
	write_trace(33, val_hi);
	sprintf(assembly, "MULTU %s, %s", REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(and) {
	decode_r_type(instr);
	uint32_t res = op_src1->val & op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "AND %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(nor) {
	decode_r_type(instr);
	uint32_t res = ~(op_src1->val | op_src2->val);
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "NOR %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(or) {
	decode_r_type(instr);
	uint32_t res = op_src1->val | op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "OR %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(xor) {
	decode_r_type(instr);
	uint32_t res = op_src1->val ^ op_src2->val;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "XOR %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src1->reg), REG_NAME(op_src2->reg));
}

make_helper(sllv) {
	decode_r_type(instr);
	uint32_t s = (op_src1->val) & SV_MASK;
	uint32_t res = op_src2->val << s;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "SRLV %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), REG_NAME(op_src1->reg));
}

make_helper(sll) {
    decode_r_type(instr);
    uint32_t sa = (instr & SHAMT_MASK) >> FUNC_SIZE;
	uint32_t res = op_src2->val << sa;
    reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
    sprintf(assembly, "SLL %s, %s, %u", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), sa);
}

make_helper(srav) {
    decode_r_type(instr);
	uint32_t s = (op_src1->val) & SV_MASK;
	uint32_t res = (int)op_src2->val >> s;
    reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
    sprintf(assembly, "SRAV %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), REG_NAME(op_src1->reg));
}

make_helper(sra) {
    decode_r_type(instr);
    uint32_t sa = (instr & SHAMT_MASK) >> FUNC_SIZE;
	uint32_t res = (int)op_src2->val >> sa;
    reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
    sprintf(assembly, "SRA %s, %s, %u", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), sa);
}


make_helper(srl) {
    decode_r_type(instr);
    uint32_t sa = (instr & SHAMT_MASK) >> FUNC_SIZE;
	uint32_t res = op_src2->val >> sa;
    reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
    sprintf(assembly, "SRL %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), REG_NAME(op_src1->reg));
}

make_helper(srlv) {
	decode_r_type(instr);
	uint32_t s = (op_src1->val) & SV_MASK;
	uint32_t res = op_src2->val >> s;
	reg_w(op_dest->reg) = res;
	write_trace(op_dest->reg, res);
	sprintf(assembly, "SRLV %s, %s, %s", REG_NAME(op_dest->reg), REG_NAME(op_src2->reg), REG_NAME(op_src1->reg));
}

make_helper(jr) {
    decode_r_type(instr);
    uint32_t temp = op_src1->val;
	cpu.pc = temp - 4;
    sprintf(assembly, "JR %s", REG_NAME(op_src1->reg));
}

make_helper(jalr) {
    decode_r_type(instr);
    reg_w(op_dest->reg) = cpu.pc + 8;
    uint32_t temp = op_src1->val;
	cpu.pc = temp - 4;
    sprintf(assembly, "JALR %s", REG_NAME(op_src1->reg));
}
	
make_helper(mfhi) {
	uint32_t reg = (instr >> 11) & 0x1F;
	reg_w(reg) = cpu.hi;
	write_trace(reg, cpu.hi);
	sprintf(assembly, "MFHI %s", REG_NAME(reg));
}

make_helper(mflo) {
	uint32_t reg = (instr >> 11) & 0x1F;
	reg_w(reg) = cpu.lo;
	write_trace(reg, cpu.lo);
	sprintf(assembly, "MFLO %s", REG_NAME(reg));
}

make_helper(mthi) {
	uint32_t reg = (instr >> 21) & 0x1F;
	cpu.hi = reg_w(reg);
	write_trace(33, reg_w(reg));
	sprintf(assembly, "MTHI %s", REG_NAME(reg));
}

make_helper(mtlo) {
	uint32_t reg = (instr >> 21) & 0x1F;
	cpu.lo = reg_w(reg);
	write_trace(34, reg_w(reg));
	sprintf(assembly, "MTLO %s", REG_NAME(reg));
}
