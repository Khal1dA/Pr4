module alu(ar, clk, select, a, b, sign, signA, signB, f_out, a_mag, b_mag);
	input ar, clk;
	input [1:0] select;
	input signed [3:0] a, b;
	wire signed [7:0] a_extendo, b_extendo;
	output wire sign, signA, signB;
	reg signed [7:0] f;
	output wire [7:0] f_out;
	output wire [3:0] a_mag, b_mag;
	
	assign a_extendo = a;
	assign b_extendo = b;
	
	always @ (negedge ar or posedge clk)
		if (~ar)
			f = 8'b0;
		else
			begin
				if (select == 2'b00)
				begin
					f = a_extendo + b_extendo;
				end
				else if (select == 2'b01)
				begin
					f = a_extendo - b_extendo;
				end
				else if (select == 2'b10)
				begin
					f = a_extendo * b_extendo;
				end
			end
		
	wire signed [7:0] f_complement;
	wire signed [3:0] a_complement;
	wire signed [3:0] b_complement;
	
	assign f_complement = ~f + 1'b1;
	assign a_complement = ~a + 1'b1;
	assign b_complement = ~b + 1'b1;
	
	assign sign = f[7];
	assign signA = a_extendo[7];
	assign signB = b_extendo[7];
	
	assign f_out = sign ? f_complement : f;
	assign a_mag = signA ? a_complement : a;
	assign b_mag = signB ? b_complement : b;
endmodule