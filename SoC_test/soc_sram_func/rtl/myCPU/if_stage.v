`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    
    input   wire [ 1: 0         ]  jtsel,        //ת��ָ��ѡ���ź�
    input   wire [`REG_BUS      ]  jump_addr_1,  //J,JALָ��ת�Ƶ�ַ
    input   wire [`REG_BUS      ]  jump_addr_2,  //BEQ,BNEָ��ת�Ƶ�ַ
    input   wire [`REG_BUS      ]  jump_addr_3,  //JRָ��ת�Ƶ�ַ
    
    input   wire [`STALL_BUS    ]  stall,       //��ˮ����ͣ�����ź�
    
    output  wire                   ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    
    input  wire                    flush,       //�����ˮ���ź�
    input  wire  [`INST_ADDR_BUS]  cp0_excaddr   //�쳣���������ڵ�ַ
    );

    wire [`INST_ADDR_BUS] pc_next; 

    //������һ��ָ��ĵ�ַ
    assign pc_next = (jtsel == 2'b00) ? pc + 4 :                  
                     (jtsel == 2'b01) ? jump_addr_1 :   //J, JAR
                     (jtsel == 2'b10) ? jump_addr_3 :   //JR
                     (jtsel == 2'b11) ? jump_addr_2 :   //BEQ,BNE 
                     `PC_INIT;
    
    reg ce;  //ָ��洢��ʹ�� 

    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ce <= `CHIP_DISABLE;		       //��λʱָ��洢������  
		end else begin
			ce <= `CHIP_ENABLE; 		       //��λ������ָ��洢��ʹ��
		end
	end

    assign ice = (stall[1] == `STOP || flush == `FLUSH) ? 0 : ce;   //�����ˮ���źź���ͣ�źŶ���Ϊ1ʱ�ŷ���ָ��洢��

    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // ָ��洢�����õ�ʱ��PC���ֳ�ʼֵ��MiniMIPS32������Ϊ0x00000000��
        else begin
            if (flush == `FLUSH) begin      //stall[0]Ϊ0ʱ��pc����pc_next,����pcֵ���ֲ���
                pc <= cp0_excaddr;
            end
            else if (stall[0] == `NOSTOP) begin  // ָ��洢��ʹ�ܺ�PCֵÿʱ�����ڼ�4 
                pc <= pc_next;
            end
        end
    end
    
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;    // ��÷���ָ��洢���ĵ�ַ

endmodule