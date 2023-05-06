`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    input   wire [`INST_ADDR_BUS]   jump_addr_1,    //J,JALָ��ת�Ƶ�ַ
    input   wire [`INST_ADDR_BUS]   jump_addr_2,    //BEQ,BNEָ��ת�Ƶ�ַ
    input   wire [`INST_ADDR_BUS]   jump_addr_3,    //JRָ��ת�Ƶ�ַ
    input   wire [`JTSEL_BUS    ]   jtsel,         //ת��ָ��ѡ���ź�
    input   wire [`STALL_BUS    ]   stall,         //��ˮ����ͣ�����ź�
    input   wire                    flush,          //�����ˮ���ź�
    input   wire [`INST_ADDR_BUS]   cp0_excaddr,    //�쳣���������ڵ�ַ

    output  wire                   ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    output  wire [`INST_ADDR_BUS]   pc_plus_4, //��ǰpcֵ��4���ֵ(��PC + 4)
    output  wire [`EXC_CODE_BUS ]   if_exccode_o
    );
    wire [`INST_ADDR_BUS] pc_next; 
    wire [`INST_ADDR_BUS] mapping_addr;
    
    //���PC + 4���ṩ������׶Σ����ת�Ƶ�ַ
    assign pc_plus_4 = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : pc + 4;

    // ������һ��ָ��ĵ�ַ
    assign pc_next = (jtsel == 2'b00) ? pc_plus_4 : 
                     (jtsel == 2'b01) ? jump_addr_1 :           //J, JAR
                     (jtsel == 2'b10) ? jump_addr_3 :           //JR
                     (jtsel == 2'b11) ? jump_addr_2 : `PC_INIT; //BEQ,BNE 


    reg ce;  //ָ��洢��ʹ��        

    always @(posedge cpu_clk_50M) begin
        if(cpu_rst_n == `RST_ENABLE)
            ce <= `CHIP_DISABLE;    //��λʱָ��洢������
        else begin
            ce <= `CHIP_ENABLE;   //��λ������ָ��洢��ʹ��
        end
    end                
                   
    assign ice = (stall[1] == `TRUE_V || flush) ? `CHIP_DISABLE : ce;    //�����ˮ���źź���ͣ�źŶ���Ϊ1ʱ�ŷ���ָ��洢��

    always @(posedge cpu_clk_50M) begin
        if (ce == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // ָ��洢�����õ�ʱ��PC���ֳ�ʼֵ��MiniMIPS32������Ϊ0x00000000��
        else begin
            if(flush == `FLUSH)    //stall[0]Ϊ0ʱ��pc����pc_next,����pcֵ���ֲ���
                pc <= cp0_excaddr;  
            else if(stall[0] == `NOSTOP) begin                        // ָ��洢��ʹ�ܺ�PCֵÿʱ�����ڼ�4 	
                pc <= pc_next;
            end
        end
    end
    
    // TODO��ָ��洢���ķ��ʵ�ַû�и�����������Χ���н��й̶���ַӳ�䣬��Ҫ�޸�!!!
    assign mapping_addr = pc & 32'h1fff_ffff;
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : mapping_addr;    // ��÷���ָ��洢���ĵ�ַ
    
    wire misalign = (iaddr[1 : 0] != 2'b00);    //ȡָ��ĵ�ַ����4����
    assign if_exccode_o = (cpu_rst_n == `RST_ENABLE) ? `EXC_NONE : 
                          (misalign == `TRUE_V) ? `EXC_ADEL : `EXC_NONE;
    
endmodule