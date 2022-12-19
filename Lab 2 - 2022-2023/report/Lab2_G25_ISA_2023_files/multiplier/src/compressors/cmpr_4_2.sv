module cmpr_4_2(

	input wire Tin, 
	input wire x1,
	input wire x2,
	input wire x3,
	input wire x4,

	output wire Tout,
	output wire S,
	output wire C );

	assign{Tout} = (x2 & x3) | ((x2 ^ x3) & x4);
	assign{S} = ((x2 ^ x3) ^ x4) ^ x1 ^ Tin;
	assign{C} = (Tin & x1) | ((Tin ^ x1) & ((x2 ^ x3) ^ x4));

endmodule
