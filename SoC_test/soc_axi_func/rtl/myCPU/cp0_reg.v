`timescale 1ns / 1ps
`include "defines.v"

module cp0_reg(
    input wire                    cpu_clk_50M,
    input wire                    cpu_rst_n,
    
    input  wire 				  we,
	input  wire 				  re,
	input  wire [`REG_ADDR_BUS ]  raddr,
	input  wire [`REG_ADDR_BUS ]  waddr,
	input  wire [`REG_BUS      ]  wdata,
	input  wire [`CP0_INT_BUS  ]  int_i,
	
	input  wire [`INST_ADDR_BUS]  pc_i,
	input  wire 				  in_delay_i,
	input  wire [`EXC_CODE_BUS ]  exccode_i,
	input  wire [`INST_ADDR_BUS]  misalign_addr,
	input  wire                   inst_data_ok,
	
	output wire 				  flush,
	output reg                    flush_im,
	output wire [`INST_ADDR_BUS]  cp0_excaddr,
	output wire	[`REG_BUS      ]  data_o,
	
	output wire [`REG_BUS 	   ]  status_o,
	output wire [`REG_BUS 	   ]  cause_o
    );
    
    reg [`REG_BUS   ]   badvaddr;
    reg [`REG_BUS   ]   status;
    reg [`REG_BUS   ]   cause;
    reg [`REG_BUS   ]   epc;
    reg [`REG_BUS   ]   count;
    reg [`REG_BUS   ]   compare;
    
    reg in_delay_reg;

    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE) begin
            in_delay_reg <= 1'b0;
        end
        else begin
            if(inst_data_ok) begin
                in_delay_reg <= in_delay_i;
            end
        end
    end
    
    assign status_o = status;
    assign cause_o = cause;
    
    // 根据异常信息生成清空流水线信号flush
    assign flush = (cpu_rst_n == `RST_ENABLE) ? `NOFLUSH :
                   (exccode_i != `EXC_NONE) ? `FLUSH : `NOFLUSH;
    
    // 生成清空从指令存储器IM中取出的指令的信号flush_im
    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE)
            flush_im <= `NOFLUSH;
        else 
            flush_im <= flush;
    end
    
    // 处理异常
    task do_exc;begin
        if(status[1] == 0) begin
            if(in_delay_reg) begin // 判断异常发生指令是否为延迟槽指令
                cause[31] <= 1'b1; // 若为延迟槽指令，cause[31]置为1
                epc       <= (exccode_i == `EXC_INT) ? pc_i : pc_i - 4;
                if((exccode_i == `EXC_ADEL) || (exccode_i == `EXC_ADES)) begin
                    badvaddr  <= misalign_addr;
                end
            end else begin
                cause[31] <= 1'b0;
                epc       <= (exccode_i == `EXC_INT) ? pc_i + 4 : pc_i; 
                if((exccode_i == `EXC_ADEL) || (exccode_i == `EXC_ADES)) begin
                    badvaddr  <= misalign_addr;
                end 
            end
        end
        status[1]    <= 1'b1;  //status.exl = 1
        cause[6 : 2] <= exccode_i; 
        if((exccode_i == `EXC_ADEL) || (exccode_i == `EXC_ADES)) begin
            badvaddr  <= misalign_addr;
        end 
    end
    endtask
    
    // 处理ERET指令
    task do_eret; begin
        status[1] <= 1'b0;
    end
    endtask
        
    // 产生异常处理程序入口地址
    assign cp0_excaddr = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : 
                         (exccode_i == `EXC_INT) ? `EXC_INT_ADDR :
                         (exccode_i == `EXC_ERET && waddr == `CP0_EPC && we == `WRITE_ENABLE) ? wdata : //写epc锟斤拷锟斤拷锟斤拷锟?
                         (exccode_i == `EXC_ERET) ? epc :
                         (exccode_i != `EXC_NONE) ? `EXC_ADDR : `ZERO_WORD;
    
    // 更新CP0寄存器数据
    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE) begin
            badvaddr <= `ZERO_WORD;
            status   <= 32'h0000_0000;
            cause    <= {25'b0, `EXC_NONE, 2'b0};
            epc      <=  `ZERO_WORD;
            count    <=  `ZERO_WORD;
            compare  <=  `ZERO_WORD;
        end
        
        else begin
            cause[15 : 10] <= int_i;    
            case(exccode_i)
                `EXC_NONE : 
                    if(we == `WRITE_ENABLE) begin
                        case(waddr)
                            `CP0_BADVADDR : badvaddr <= wdata;
                            `CP0_STATUS : begin
//                                            status[15 : 8] <= wdata[15 : 8]; 
//                                            status[1 : 0] <= wdata[1 : 0];
                                            status <= wdata;                                     
                                          end
                            `CP0_CAUSE : begin
                                            cause[9 : 8] <= wdata[9 : 8];
           
                                         end
                            `CP0_EPC : epc <= wdata; 
                        endcase
                    end
                 `EXC_ERET : do_eret();
                 default : do_exc();
            endcase
        end
    end
    
    assign data_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                    (re != `READ_ENABLE) ? `ZERO_WORD :
                    (raddr == `CP0_BADVADDR) ? badvaddr :
                    (raddr == `CP0_STATUS) ? status :
                    (raddr == `CP0_CAUSE) ? cause :
                    (raddr == `CP0_EPC) ? epc : `ZERO_WORD;
    
endmodule
