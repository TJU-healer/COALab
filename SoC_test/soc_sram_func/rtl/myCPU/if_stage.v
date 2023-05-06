`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    
    input   wire [ 1: 0         ]  jtsel,        //转移指令选择信号
    input   wire [`REG_BUS      ]  jump_addr_1,  //J,JAL指令转移地址
    input   wire [`REG_BUS      ]  jump_addr_2,  //BEQ,BNE指令转移地址
    input   wire [`REG_BUS      ]  jump_addr_3,  //JR指令转移地址
    
    input   wire [`STALL_BUS    ]  stall,       //流水线暂停控制信号
    
    output  wire                   ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    
    input  wire                    flush,       //清空流水线信号
    input  wire  [`INST_ADDR_BUS]  cp0_excaddr   //异常处理程序入口地址
    );

    wire [`INST_ADDR_BUS] pc_next; 

    //计算下一条指令的地址
    assign pc_next = (jtsel == 2'b00) ? pc + 4 :                  
                     (jtsel == 2'b01) ? jump_addr_1 :   //J, JAR
                     (jtsel == 2'b10) ? jump_addr_3 :   //JR
                     (jtsel == 2'b11) ? jump_addr_2 :   //BEQ,BNE 
                     `PC_INIT;
    
    reg ce;  //指令存储器使能 

    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ce <= `CHIP_DISABLE;		       //复位时指令存储器禁用  
		end else begin
			ce <= `CHIP_ENABLE; 		       //复位结束后指令存储器使能
		end
	end

    assign ice = (stall[1] == `STOP || flush == `FLUSH) ? 0 : ce;   //清空流水线信号和暂停信号都不为1时才访问指令存储器

    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // 指令存储器禁用的时候，PC保持初始值（MiniMIPS32中设置为0x00000000）
        else begin
            if (flush == `FLUSH) begin      //stall[0]为0时，pc等于pc_next,否则pc值保持不变
                pc <= cp0_excaddr;
            end
            else if (stall[0] == `NOSTOP) begin  // 指令存储器使能后，PC值每时钟周期加4 
                pc <= pc_next;
            end
        end
    end
    
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;    // 获得访问指令存储器的地址

endmodule