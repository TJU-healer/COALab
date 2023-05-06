#include "helper.h"
#include "all-instr.h"

typedef void (*op_fun)(uint32_t);

static make_helper(_2byte_esc); //op为全0的情况下用func字段识别指令
static make_helper(rt_sel);    //区分bltz bgez bltzal bgezal
static make_helper(coprocessor_instr); //区分协处理器指令——mfc0 mtc0 eret

Operands ops_decoded;
uint32_t instr;
	

/* TODO: Add more instructions!!! */

op_fun opcode_table [64] = {
/* 0x00 */	_2byte_esc, rt_sel, j, jal,
/* 0x04 */	beq, bne, blez, bgtz,
/* 0x08 */	addi, addiu, slti, sltiu,
/* 0x0c */	andi, ori, xori, lui,
/* 0x10 */	coprocessor_instr, inv, temu_trap, inv,
/* 0x14 */	inv, inv, inv, inv,
/* 0x18 */	inv, inv, inv, inv,
/* 0x1c */	inv, inv, inv, inv,
/* 0x20 */	lb, lh , inv, lw,
/* 0x24 */	lbu, lhu, inv, inv,
/* 0x28 */	sb, sh, inv, sw,
/* 0x2c */	inv, inv, inv, inv,
/* 0x30 */	inv, inv, inv, inv,
/* 0x34 */	inv, inv, inv, inv,
/* 0x38 */	inv, inv, inv, inv,
/* 0x3c */	inv, inv, inv, inv
};

op_fun _2byte_opcode_table [64] = {
/* 0x00 */	sll, inv, srl, sra, 
/* 0x04 */	sllv, inv, srlv, srav, 
/* 0x08 */	jr, jalr, inv, inv, 
/* 0x0c */	syscall, _break, inv, inv, 
/* 0x10 */	mfhi, mthi, mflo, mtlo, 
/* 0x14 */	inv, inv, inv, inv, 
/* 0x18 */	mult, multu, div, divu, 
/* 0x1c */	inv, inv, inv, inv, 
/* 0x20 */	add, addu, sub, subu, 
/* 0x24 */	and, or, xor, nor,
/* 0x28 */	inv, inv, slt, sltu, 
/* 0x2c */	inv, inv, inv, inv, 
/* 0x30 */	inv, inv, inv, inv, 
/* 0x34 */	inv, inv, inv, inv,
/* 0x38 */	inv, inv, inv, inv, 
/* 0x3c */	inv, inv, inv, bad_temu_trap
};

make_helper(exec) {
	if(pc & 0x3){  //PC值的最低两位应该是"00",否则会触发取指阶段的地址错误异常
		if(cpu.cp0.Status.EXL == 0){
			cpu.cp0.Cause.ExcCode = AdEL;
			cpu.cp0.BadVAddr = pc;
			cpu.cp0.EPC = pc;
			cpu.cp0.Status.EXL = 1;
			pc = TRAP_ADDR;
		}
       return;
	}
	if(pc == 0x1FC00380 && cpu.cp0.Cause.ExcCode != 0){ //控制流正处于异常处理程序
		switch(cpu.cp0.Cause.ExcCode){
			case AdEL : 
			   printf("Instruction read address error!\n");
			   break;
			case AdES :
			   printf("Instruction write address error!\n");
			   break;
			case Ov :
			   printf("Int overflow error!\n");
			   break;
			case Sys :
			   printf("Syscall.\n");
			   break;
			case Bp :
			   printf("Break.\n");
			   break;
			case RI :
			   printf("Reversed instruction error!\n");
			   break;
			default :
			   printf("Unkown exception!\n");
		}
		eret(pc); //从当前异常中返回
		return;
	}
	instr = instr_fetch(pc, 4);
	ops_decoded.opcode = instr >> 26;
	opcode_table[ ops_decoded.opcode ](pc);
}

static make_helper(_2byte_esc) {
	ops_decoded.func = instr & FUNC_MASK;
	_2byte_opcode_table[ops_decoded.func](pc); 
}

static make_helper(rt_sel) {
	uint32_t sel = (instr & 0x001F0000) >> 16;
	switch(sel){
		case 0x0 : bltz(pc); break;
		case 0x1 : bgez(pc); break;
		case 0x10 : bltzal(pc); break;
		case 0x11 : bgezal(pc); break;
	}
}

static make_helper(coprocessor_instr) {
	uint32_t sel = (instr >> 21) & 0x001F;
	switch(sel){
		case 0x0 : mfc0(pc); break;
		case 0x4 : mtc0(pc); break;
		case 0x10 : eret(pc); break;
	}
}
