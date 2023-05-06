`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    input   wire [`INST_ADDR_BUS]   jump_addr_1,    //J,JAL
    input   wire [`INST_ADDR_BUS]   jump_addr_2,    //BEQ,BNE
    input   wire [`INST_ADDR_BUS]   jump_addr_3,    //JR
    input   wire [`JTSEL_BUS    ]   jtsel,
    input   wire [`STALL_BUS    ]   stall,  
    input   wire                    flush,          //清空流水线
    input   wire [`INST_ADDR_BUS]   cp0_excaddr,    //异常处理程序入口地址 
    input   wire                    inst_addr_ok,
    input   wire                    inst_data_ok,
    input   wire                    mem_mem_flag,
    
    //output  wire                   ice,
    output 	wire  [`INST_ADDR_BUS] 	pc_o,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    output  wire [`INST_ADDR_BUS]   pc_plus_4,
    output  wire [`EXC_CODE_BUS ]   if_exccode_o,
    output  reg                     inst_req,
    output  wire                    inst_data_ok_o  
    );
    
    reg ce;
    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ce <= `CHIP_DISABLE;
		end 
		else begin
			ce <= `CHIP_ENABLE;
		end
	end 
    
    assign inst_data_ok_o = inst_data_ok;
    //取指模块1
    wire [`INST_ADDR_BUS] pc_next;
    reg  [`INST_ADDR_BUS] pc;

    assign pc_o = pc;
    assign pc_plus_4 = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : pc + 4;
    assign pc_next = (jtsel == 2'b00) ? pc_plus_4 : 
                     (jtsel == 2'b01) ? jump_addr_1 : 
                     (jtsel == 2'b10) ? jump_addr_3 : 
                     (jtsel == 2'b11) ? jump_addr_2 : `PC_INIT;
    
    assign iaddr = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 32'h1fffffff&pc;
    
    //取指阶段状态机
    reg  [2:0] if_state;
    wire [2:0] next_state;
    reg[2:0] pc_state;
    reg[`REG_BUS] pc_next_reg;
    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE) begin
            if_state <= `IF_READY;
            inst_req <= 1'b0;
            pc <= `PC_INIT;
            pc_state <= `PC_NO_DELAY;
            pc_next_reg <= `ZERO_WORD;
        end
        else begin 
            if (flush) begin
                pc <= cp0_excaddr;
            end
            else if(stall[0] == `NOSTOP & inst_data_ok) begin
                case (pc_state)
                    `PC_NO_DELAY: begin
                        pc <= pc_plus_4;
                        if(jtsel != 2'b00) begin // 代表有跳转需要延迟
                            pc_state <= `PC_IN_DELAY;
                            pc_next_reg <= pc_next;
                        end
                    end 
                    `PC_IN_DELAY: begin
                        pc <= pc_next_reg; // 延迟结束，回到原来pc的下一个位置
                        pc_state <= `PC_NO_DELAY;
                    end
                    default: begin
                        pc <= `ZERO_WORD;
                    end
                endcase
            end
            
            case (if_state)
                `IF_READY:begin
                    if(pc[1 : 0] == 2'b00) begin
                        inst_req <= 1'b1; // 请求读指令
                        if_state <= `IF_WAIT_ADDROK; 
                    end
                end 
                `IF_WAIT_ADDROK: begin
                    if(inst_addr_ok)begin   // 读请求被接收
                        inst_req <= 1'b0;
                        if_state <= `IF_WAIT_DATAOK;
                    end
                end
                `IF_WAIT_DATAOK: begin
                    if(inst_data_ok) begin // 读数据被接受
                        if_state <= `IF_WAIT_ID;
                    end
                end
                `IF_WAIT_ID:begin // 至少等 x 个周期
                    if_state <= `IF_WAIT_EXE;
                end
                `IF_WAIT_EXE:begin
                    if_state <= `IF_WAIT_MEM;
                end
                `IF_WAIT_MEM:begin
                    if(mem_mem_flag) begin
                    end  //该指令运行到访存阶段时需要访存，此时继续阻塞
                    else begin
                        if_state <= `IF_READY;
                    end
                end
            default: begin
            end
        endcase
        end
    end   
    
    assign if_exccode_o = (cpu_rst_n == `RST_ENABLE) ? `EXC_NONE : 
                          (pc[1 : 0] != 2'b00) ? `EXC_ADEL : `EXC_NONE;
endmodule