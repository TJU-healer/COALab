`timescale 1ns/1ps
module inst_rom_tb;

reg clka, ena;
reg [10:0] addra;
wire [31:0] douta;

inst_rom uut (
.clka(clka), // input wire clka
.ena(ena), // input wire ena
.addra(addra), // input wire [10 : 0] addra
.douta(douta) // output wire [31 : 0] douta
);
initial begin
clka = 0; ena = 0; addra = 0;
#100 ena = 1; addra = 1;
#50 addra = 3;
#50 addra = 6;
#50 addra = 10;
#50 $finish;
end
always begin
#10 clka = ~clka;
end
endmodule
