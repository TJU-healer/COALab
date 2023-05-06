module mycpu(
    input wire           [5:0] ext_int,
    input wire           clk,
    input wire           resetn,

    input   wire [31:0]  inst_sram_addr_v,
    output  wire         inst_sram_en,
    output  wire [3:0]   inst_sram_wen,
    output  wire [31:0]  inst_sram_addr,
    output  wire [31:0]  inst_sram_wdata,
    input   wire [31:0]  inst_sram_rdata,
    
    input   wire [31:0]  data_sram_addr_v,
    output  wire         data_sram_en,
    output  wire [3:0]   data_sram_wen,
    output  wire [31:0]  data_sram_addr,
    output  wire [31:0]  data_sram_wdata,
    input   wire [31:0]  data_sram_rdata,
    
    output  wire [31:0]  debug_wb_pc,
    output  wire [3 :0]  debug_wb_rf_wen,
    output  wire [4 :0]  debug_wb_rf_wnum,
    output  wire [31:0]  debug_wb_rf_wdata
);

    wire           ice;
    wire           dce;

    assign inst_sram_en = (resetn == 1'b0) ? 1'b0 : ice;
    assign inst_sram_wen = 4'b0000;
    assign inst_sram_wdata = 32'h00000000;

    assign data_sram_en = (resetn == 1'b0) ? 1'b0 : dce;

    wire timer_int;

    MiniMIPS32 MiniMIPS32_0(
        .cpu_clk_50M(clk),
        .cpu_rst_n(resetn),

        .iaddr(inst_sram_addr_v), 
        .ice(ice),
        .inst(inst_sram_rdata),
        .dce(dce),
        .daddr(data_sram_addr_v),
        .we(data_sram_wen),
        .din(data_sram_wdata),
        .dm(data_sram_rdata),

        .int({timer_int, ext_int[4:0]}),
        .timer_int_o(timer_int),

        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_wnum(debug_wb_rf_wnum),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );

    //指令地址映射
    wire [2:0] inst_addr_head_i, inst_addr_head_o;
    wire inst_kseg0, inst_kseg1, inst_other_seg;
    assign inst_addr_head_i = inst_sram_addr_v[31:29];
    assign inst_kseg0 = inst_addr_head_i == 3'b100;
    assign inst_kseg1 = inst_addr_head_i == 3'b101;
    assign inst_other_seg = ~inst_kseg0 & ~inst_kseg1;
    assign inst_addr_head_o = {3{inst_kseg0}}&3'b000 | {3{inst_kseg1}}&3'b000 | {3{inst_other_seg}}&inst_addr_head_i;
    assign inst_sram_addr = {inst_addr_head_o, inst_sram_addr_v[28:0]};
    
    //数据地址映射
    wire [2:0] data_addr_head_i, data_addr_head_o;
    wire data_kseg0, data_kseg1, data_other_seg;
    assign data_addr_head_i = data_sram_addr_v[31:29];
    assign data_kseg0 = data_addr_head_i == 3'b100;
    assign data_kseg1 = data_addr_head_i == 3'b101;
    assign data_other_seg = ~data_kseg0 & ~data_kseg1;
    assign data_addr_head_o = {3{data_kseg0}}&3'b000 | {3{data_kseg1}}&3'b000 | {3{data_other_seg}}&data_addr_head_i;
    assign data_sram_addr = {data_addr_head_o, data_sram_addr_v[28:0]};
    
endmodule