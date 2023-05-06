`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    input   wire [`INST_ADDR_BUS]   jump_addr_1,    //J,JAL指令转移地址
    input   wire [`INST_ADDR_BUS]   jump_addr_2,    //BEQ,BNE指令转移地址
    input   wire [`INST_ADDR_BUS]   jump_addr_3,    //JR指令转移地址
    input   wire [`JTSEL_BUS    ]   jtsel,         //转移指令选择信号
    input   wire [`STALL_BUS    ]   stall,         //流水线暂停控制信号
    input   wire                    flush,          //清空流水线信号
    input   wire [`INST_ADDR_BUS]   cp0_excaddr,    //异常处理程序入口地址

    output  wire                   ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    output  wire [`INST_ADDR_BUS]   pc_plus_4, //当前pc值加4后的值(即PC + 4)
    output  wire [`EXC_CODE_BUS ]   if_exccode_o
    );
    wire [`INST_ADDR_BUS] pc_next; 
    wire [`INST_ADDR_BUS] mapping_addr;
    
    //获得PC + 4，提供给译码阶段，获得转移地址
    assign pc_plus_4 = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : pc + 4;

    // 计算下一条指令的地址
    assign pc_next = (jtsel == 2'b00) ? pc_plus_4 : 
                     (jtsel == 2'b01) ? jump_addr_1 :           //J, JAR
                     (jtsel == 2'b10) ? jump_addr_3 :           //JR
                     (jtsel == 2'b11) ? jump_addr_2 : `PC_INIT; //BEQ,BNE 


    reg ce;  //指令存储器使能        

    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE)
            ce <= `CHIP_DISABLE;    //复位时指令存储器禁用
        else begin
            ce <= `CHIP_ENABLE;   //复位结束后指令存储器使能
        end
    end                
                   
    assign ice = (stall[1] == `TRUE_V || flush) ? `CHIP_DISABLE : ce;    //清空流水线信号和暂停信号都不为1时才访问指令存储器

    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // 指令存储器禁用的时候，PC保持初始值（MiniMIPS32中设置为0x00000000）
        else begin
            if(flush == `FLUSH)    //stall[0]为0时，pc等于pc_next,否则pc值保持不变
                pc <= cp0_excaddr;  
            else if(stall[0] == `NOSTOP) begin                        // 指令存储器使能后，PC值每时钟周期加4 	
                pc <= pc_next;
            end
        end
    end
    
    // TODO：指令存储器的访问地址没有根据其所处范围进行进行固定地址映射，需要修改!!!
    assign mapping_addr = pc & 32'h1fff_ffff;
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : mapping_addr;    // 获得访问指令存储器的地址
    
    wire misalign = (iaddr[1 : 0] != 2'b00);    //取指令的地址不是4对齐
    assign if_exccode_o = (cpu_rst_n == `RST_ENABLE) ? `EXC_NONE : 
                          (misalign == `TRUE_V) ? `EXC_ADEL : `EXC_NONE;
    
endmodule