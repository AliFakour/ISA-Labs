module ha(

	input wire x1,
	input wire x2,

	output wire S,
	output wire C );

	assign{C} = x1 & x2;
	assign{S} = x1 ^ x2;

endmodule
