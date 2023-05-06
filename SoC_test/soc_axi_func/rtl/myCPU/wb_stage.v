`include "defines.v"

module wb_stage(
    input wire                    cpu_rst_n,
    
    // 从访存阶段获得的信息
	input  wire [`REG_ADDR_BUS  ] wb_wa_i,
	input  wire                   wb_wreg_i,
	input  wire                   wb_whilo_i,
	input  wire                   wb_mreg_i,	
	input  wire [`REG_BUS       ] wb_dreg_i,
	input  wire [`DOUBLE_REG_BUS] wb_hilo_i,
	input  wire [`EQU_BUS      ] wb_dre_i,
    input  wire [`INST_ADDR_BUS ] wb_pc_i,
	
	input  wire                   cp0_we_i,
    input  wire [`REG_ADDR_BUS  ] cp0_waddr_i,
    input  wire [`REG_BUS       ] cp0_wdata_i,

	input  wire [`WORD_BUS      ] dm,
	
	input  wire                   wb_whi_i,
	input  wire                   wb_wlo_i,
	input  wire                   wb_unsigned_i,
	
    // 写回目的寄存器的数据
    output wire [`REG_ADDR_BUS  ] wb_wa_o,
	output wire                   wb_wreg_o,
    output wire                   wb_whilo_o,
    output wire [`WORD_BUS      ] wb_wd_o,
    
    output wire                   wb_whi_o,
    output wire                   wb_wlo_o,
    
    output wire                   cp0_we_o,
	output wire [`REG_ADDR_BUS  ] cp0_waddr_o,
    output wire [`REG_BUS       ] cp0_wdata_o,
    
	output wire [`INST_ADDR_BUS ] wb_pc_o,
	output wire [`DOUBLE_REG_BUS] wb_hilo_o
    );

    wire [`WORD_BUS]    data;
    
    assign wb_hilo_o    = (cpu_rst_n == `RST_ENABLE) ? `ZERO_DWORD : wb_hilo_i;
    assign wb_whi_o     = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_whi_i;
    assign wb_wlo_o     = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_wlo_i;
    
    assign wb_pc_o = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : wb_pc_i;
    
    // 直接送至CP0协处理器的信号
    assign cp0_we_o     = (cpu_rst_n == `RST_ENABLE) ? 1'b0  : cp0_we_i;
	assign cp0_waddr_o  = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD  : cp0_waddr_i;
	assign cp0_wdata_o  = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD  : cp0_wdata_i;

    
    assign data               = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                                (wb_dre_i == 4'b1111) ? dm  :
                                (wb_dre_i == 4'b1000) ? (wb_unsigned_i == `TRUE_V ? {24'b0, dm[7:0]} : {{24{dm[7]}}, dm[7:0]}) : 
                                (wb_dre_i == 4'b0100) ? (wb_unsigned_i == `TRUE_V ? {24'b0, dm[15:8]} : {{24{dm[15]}}, dm[15:8]}) :
                                (wb_dre_i == 4'b0010) ? (wb_unsigned_i == `TRUE_V ? {24'b0, dm[23:16]} : {{24{dm[23]}}, dm[23:16]}) :
                                (wb_dre_i == 4'b0001) ? (wb_unsigned_i == `TRUE_V ? {24'b0, dm[31:24]} : {{24{dm[31]}}, dm[31:24]}) : 
                                (wb_dre_i == 4'b1100) ? (wb_unsigned_i == `TRUE_V ? {16'b0, dm[15:0]} : {{16{dm[15]}}, dm[15:0]}) :
                                (wb_dre_i == 4'b0011) ? (wb_unsigned_i == `TRUE_V ? {16'b0, dm[31:16]} : {{16{dm[31]}}, dm[31:16]}) : `ZERO_WORD;
    
    assign wb_wa_o      = (cpu_rst_n == `RST_ENABLE) ? 5'b0 : wb_wa_i;
    assign wb_wreg_o    = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_wreg_i;
    assign wb_whilo_o   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_whilo_i;                            
    assign wb_wd_o      = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 
                          (wb_mreg_i == `MREG_ENABLE) ? data : wb_dreg_i;
endmodule
