// Project 4 top-level module for ECE 441
// pr4_topleveldesign.v
// Created by: Adam Duvendack & Khalid Alzubaidi
// Dec. 6, 2021

`timescale 1 ns / 1 ns

module pr4 (select, clk, ar, a, b, aSign, bSign, bothSign, sev_segs1, sev_segs2, sev_segsA, sev_segsB,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,VGA_BLANK,VGA_SYNC,VGA_CLK);
input clk; // 50 MHz clock
input ar; // asynchronous reset
	input [1:0] select;
	input [3:0] a, b; // 4-bit signed a and b input
	
output [7:0] VGA_R, VGA_G, VGA_B;
output VGA_HS;   // Output horizontal synch
output VGA_VS;   // Output vertical synch
output VGA_BLANK, VGA_SYNC;
output VGA_CLK;


	output aSign, bSign, bothSign; // signs of output number
	output [6:0] sev_segs1, sev_segs2, sev_segsA, sev_segsB; // 7-segment LED outputs

	wire [7:0] f_out;
	wire [3:0] a_out;
	wire [3:0] b_out;
	
	alu alu1(.ar(ar), .clk(clk), .select(select), .a(a), .b(b), .sign(bothSign), .signA(aSign), .signB(bSign), .f_out(f_out), .a_mag(a_out), .b_mag(b_out));

	wire [3:0] b2b_outputH, b2b_outputT, b2b_outputO;
	
	bin2bcd b2b(.binary(f_out), .hundreds(b2b_outputH), .tens(b2b_outputT), .ones(b2b_outputO));
	
	sevseg_dec seg_1(.x_in(b2b_outputT), .segs(sev_segs1));
	sevseg_dec seg_2(.x_in(b2b_outputO), .segs(sev_segs2));
	sevseg_dec seg_3(.x_in(a_out), .segs(sev_segsA));
	sevseg_dec seg_4(.x_in(b_out), .segs(sev_segsB));
	
	vga_rom VGA(.x_in1(f_out), .x_in2(b2b_outputT),.x_in3(b2b_outputO),.x_in4(a_out),.Op(b_out), .CLOCK_50(clk), .ar(ar), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_BLANK(VGA_BLANK), .VGA_SYNC(VGA_SYNC), .VGA_CLK(VGA_CLK));
endmodule



