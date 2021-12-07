
// 4-bit synchronous BCD counter with asynchronous reset
// ctr4.v
// Don M. Gruenbacher
// Feb. 4, 2000

`timescale 100 ns / 1 ns

module ctr_bcd (clk, ar, q);
	input  clk, ar;
	output [3:0] q;
	reg    [3:0] q;


always @ (posedge clk or negedge ar)

	if(~ar)
		q = 4'b0;
	else	
	  if(q >= 4'h9)
		q = 4'b0;
	  else
		q = q + 1;

endmodule
