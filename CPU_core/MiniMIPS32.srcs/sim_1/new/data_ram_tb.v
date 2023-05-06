`timescale 1ns / 1ps
module data_ram_tb;

reg clka, ena;
reg [3:0] wea;
reg [10:0] addra;
reg [31:0] dina;
wire [31:0] douta;

data_ram uut (
.clka(clka), // input wire clka
.ena(ena), // input wire ena
.wea(wea), // input wire [3 : 0] wea
.addra(addra), // input wire [10 : 0] addra
.dina(dina), // input wire [31 : 0] dina
.douta(douta) // output wire [31 : 0] douta
);
initial begin
clka = 0; ena = 0;
#100 ena = 1; wea = 4'b1111; addra = 0; dina = 32'h12345678;
#100 wea = 4'b1001; addra = 0; dina = 32'habcdef90;
#100 wea = 4'b0000; addra = 0;
end
always #10 clka = ~clka;
endmodule