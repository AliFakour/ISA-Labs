module multiplier import globals ::*; (
	input wire [22:0]x,
	input wire [22:0]y,
	output wire [45:0]product );

	wire [45:0]PP[9];	// partial product matrix
	// results of the reduction tree
	wire [31:0]C;				
	wire [31:0]S;

	PPG partial_products(.x(x), .y(y), .PP(PP)); 

	daddaTree reduction_tree(.PP(PP), .C(C), .S(S));

	assign{product} = C + S;

endmodule


