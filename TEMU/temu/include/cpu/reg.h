#ifndef __REG_H__
#define __REG_H__

#include "common.h"

#define AdEL 0x04 //取指或加载数据出现地址错误异常
#define AdES 0x05 //存储数据出现地址错误异常
#define Sys 0x08 //执行系统调用指令
#define Bp 0x09  //断点异常
#define RI 0x0A   //执行未执行的指令
#define Ov 0x0C  //算术运算(加法和减法)结果溢出

#define TRAP_ADDR (0xBFC00380 - 4)  //异常处理程序入口地址

//协处理器cp0中寄存器的编号
#define BadVAddr_R 8
#define Status_R 12
#define Cause_R 13
#define EPC_R 14

enum { R_ZERO, R_AT, R_V0, R_V1, R_A0, R_A1, R_A2, R_A3, R_T0, R_T1, R_T2, R_T3, R_T4, R_T5, R_T6, R_T7, R_S0, R_S1, R_S2, R_S3, R_S4, R_S5, R_S6, R_S7, R_T8, R_T9, R_K0, R_K1, R_GP, R_SP, R_FP, R_RA };

typedef union {
	struct{
		uint32_t IE : 1;   //全局中断使能标志位:1表示中断使能，0表示中断禁止
		uint32_t EXL : 1;  //表示是否处于异常级，异常发生时，设置该标志位为1，处理器进入内核模式，并且禁止中断
		uint32_t space1 : 6;
		uint32_t IM : 8;   //IM[7:0]表示是否屏蔽相应中断，0表示屏蔽，1表示不屏蔽
		uint32_t space2: 16;
	};
	uint32_t val;
} STATUS;


typedef union {
	struct {
		uint32_t space1 : 1;
		uint32_t ExcCode : 5;  //用于记录发生了哪种异常
		uint32_t space2 : 1;
		uint32_t IP : 8;    //IP[7:0]对应位用来指明外部硬件中断是否发生，1表示发生，0表示没有发生
	    uint32_t space3: 15;
		uint32_t BD : 1;   //当发生异常的指令为延迟槽指令时，该字段被设置为1
		uint32_t flag : 1;
	};
	uint32_t val;
} CAUSE;


typedef struct CP0{
	uint32_t BadVAddr;  //记录最近一次地址相关异常的地址
	STATUS Status; //处理器状态和控制
	CAUSE Cause;  //上一次发生异常的原因
	uint32_t EPC; //上一次发生异常的PC值
}CP0;


typedef struct {
    union {
		union {
			uint32_t _32;
			uint16_t _16;
			uint8_t _8;
		} gpr[32];

		/* Do NOT change the order of the GPRs' definitions. */
		struct {
			uint32_t zero, at, v0, v1, a0, a1, a2, a3;
			uint32_t t0, t1, t2, t3, t4, t5, t6, t7;
			uint32_t s0, s1, s2, s3, s4, s5, s6, s7;
			uint32_t t8, t9, k0, k1, gp, sp, fp, ra;
		};
     };
	uint32_t pc;	// 32
	uint32_t hi;	// 33
	uint32_t lo;	// 34

    CP0 cp0;  //系统控制协处理器

} CPU_state;

extern CPU_state cpu;

static inline int check_reg_index(int index) {
	assert(index >= 0 && index <= 31);
	return index;
}

#define reg_w(index) (cpu.gpr[check_reg_index(index)]._32)
#define reg_h(index) (cpu.gpr[check_reg_index(index)]._16)
#define reg_b(index) (cpu.gpr[check_reg_index(index)]._8)

extern const char* regfile[];

#endif
