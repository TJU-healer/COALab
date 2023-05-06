`include "defines.v"

module wb_stage(
    input  wire                   cpu_rst_n,
    
    // �ӷô�׶λ�õ���Ϣ
    input  wire                   wb_unsign_i,
	input  wire [`REG_ADDR_BUS  ] wb_wa_i,
	input  wire                   wb_wreg_i,
	input  wire                   wb_whilo_i,
	input  wire                   wb_mreg_i,
	input  wire [`REG_BUS       ] wb_dreg_i,
	input  wire [`DOUBLE_REG_BUS] wb_dhilo_i,
	input  wire [`DATA_WE_BUS   ] wb_dre_i,
    input  wire [`INST_ADDR_BUS ] wb_pc_i,

    input  wire                     cp0_we_i,
    input  wire [`REG_ADDR_BUS  ]   cp0_waddr_i,
    input  wire [`REG_BUS       ]   cp0_wdata_i,

    input  wire                     device,

    // д��Ŀ�ļĴ���������
    output wire [`REG_ADDR_BUS  ] wb_wa_o,
	output wire                   wb_wreg_o,
	output wire                   wb_whilo_o,
    output wire [`WORD_BUS      ] wb_wd_o,

    
    output wire                   wb2exe_whilo,
    output wire [`DOUBLE_REG_BUS] wb2exe_hilo,
    
    input  wire [`DATA_BUS      ] dm,
    
    output wire                     cp0_we_o,
    output wire [`REG_ADDR_BUS  ]   cp0_waddr_o,    
    output wire [`REG_BUS       ]   cp0_wdata_o,

    output wire [`INST_ADDR_BUS ] wb_pc_o,
    output wire [`DOUBLE_REG_BUS] wb_hilo_o
    );
    
    wire [`REG_BUS] dmem;
    
    assign wb2exe_whilo = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_whilo_i;
    assign wb2exe_hilo  = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_dhilo_i;
    assign wb_hilo_o  = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_dhilo_i;

    assign wb_pc_o = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT: wb_pc_i;
    
    // ֱ������CP0Э���������ź�
    assign cp0_we_o     = (cpu_rst_n == `RST_ENABLE) ? 1'b0  : cp0_we_i;
    assign cp0_waddr_o  = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD  : cp0_waddr_i;
    assign cp0_wdata_o  = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD  : cp0_wdata_i;

    
    assign dmem         = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                          (wb_dre_i == 4'b1111 & device )? dm:
                          (wb_dre_i == 4'b1111 & !device) ? {dm[7:0], dm[15:8], dm[23:16], dm[31:24]} :
                          (wb_dre_i == 4'b1100 & wb_unsign_i == 1'b0) ? {{16{dm[23]}}, dm[23:16], dm[31:24]} :
                          (wb_dre_i == 4'b1100 & wb_unsign_i == 1'b1) ? { 16'b0,       dm[23:16], dm[31:24]} :
                          (wb_dre_i == 4'b0011 & wb_unsign_i == 1'b0) ? {{16{dm[ 7]}}, dm[ 7: 0], dm[15: 8]} :
                          (wb_dre_i == 4'b0011 & wb_unsign_i == 1'b1) ? { 16'b0,       dm[ 7: 0], dm[15: 8]} :
                          (wb_dre_i == 4'b1000 & wb_unsign_i == 1'b0) ? {{24{dm[31]}}, dm[31:24]} :
                          (wb_dre_i == 4'b1000 & wb_unsign_i == 1'b1) ? { 24'b0,       dm[31:24]} :
                          (wb_dre_i == 4'b0100 & wb_unsign_i == 1'b0) ? {{24{dm[23]}}, dm[23:16]} :
                          (wb_dre_i == 4'b0100 & wb_unsign_i == 1'b1) ? { 24'b0,       dm[23:16]} :
                          (wb_dre_i == 4'b0010 & wb_unsign_i == 1'b0) ? {{24{dm[15]}}, dm[15: 8]} :
                          (wb_dre_i == 4'b0010 & wb_unsign_i == 1'b1) ? { 24'b0,       dm[15: 8]} :
                          (wb_dre_i == 4'b0001 & wb_unsign_i == 1'b0) ? {{24{dm[ 7]}}, dm[ 7: 0]} :
                          (wb_dre_i == 4'b0001 & wb_unsign_i == 1'b1) ? { 24'b0,       dm[ 7: 0]} : `ZERO_WORD;

    assign wb_wa_o      = (cpu_rst_n == `RST_ENABLE) ? 5'b0 : wb_wa_i;
    assign wb_wreg_o    = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_wreg_i;
    assign wb_whilo_o   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : wb_whilo_i;
    assign wb_wd_o      = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                          (wb_mreg_i) ? dmem : wb_dreg_i;
    
endmodule
