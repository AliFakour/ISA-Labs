module fa(

	input wire Cin, 
	input wire x1,
	input wire x2,

	output wire S,
	output wire C );

	assign{C} = (x1 & x2) | ((x1 ^ x2) & Cin);
	assign{S} = (x1 ^ x2) ^ Cin;

endmodule
