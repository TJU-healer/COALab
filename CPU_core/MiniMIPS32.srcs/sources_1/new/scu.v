`include "defines.v"

module scu(
    input   wire                cpu_rst_n,
    input   wire                stallreq_id,    //����׶���ͣ�ź�
    input   wire                stallreq_exe,   //ִ�н׶���ͣ�ź�
    
    output  wire [`STALL_BUS]   stall
    );
    
    assign  stall = (cpu_rst_n == `RST_ENABLE) ? 4'b0000 :
                    (stallreq_exe == `STOP) ? 4'b1111 :         //����ָ����Ҫ��ִ�н׶���ͣ
                    (stallreq_id == `STOP) ? 4'b0111 : 4'b0000; //������ز���Ҫ��ִ�н׶���ͣ
    
endmodule
