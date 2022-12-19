module PPG import globals::*; (	//x*y
	input wire [22:0]x,
	input wire [22:0]y,
	output wire [45:0]PP[9]);

	// x-signal computation, separated to save bit
	wire [24:0] _x, _nx, _2x, _n2x, _3x, _n3x, _4x, _n4x;
	wire [7:0]not_msb_pp;
	logic [45:0]partial_p[8];

	wire [24:0]yExt;					// y input considering the "-1 dummy bit"

	booth_selection_type [0:7]sel;		// multiplexer selection signals

	genvar i;

	assign yExt = y << 1;	// dummy bit = 0

	// partial encoded product generation
	assign _x = x;			 	// x
	assign _2x = _x << 1; 		// 2*x
	assign _3x = (_2x + _x);	// 3*x
	assign _4x = _x << 2;		// 4*x
	
	assign _nx = ~(x); 			// 1'c of x
	assign _n2x = ~(_2x); 		// 1'c of (2*x)
	assign _n3x = ~(_3x); 		// 1'c of (3*x)
	assign _n4x = ~(_4x); 		// 1'c of (4*x)

	// generation of the booth LUTs
	generate
		for(i = 0; i < $size(sel); i++) begin : BE_i
			booth_encoder BE (.dIn(yExt[(3+(i*3)):(i*3)]), .sel(sel[i]) );	
		end
	endgenerate

	// multiplexer instantiation
	always_comb
	foreach(sel[i]) 
		case (sel[i])
			zero : partial_p[i] = '0;

			_y :  partial_p[i] = x;
			_2y : partial_p[i] = _2x;
			_3y : partial_p[i] = _3x;
			_4y : partial_p[i] = _4x;
		
			_n4y : partial_p[i] = _n4x;
			_n3y : partial_p[i] = _n3x;
			_n2y : partial_p[i] = _n2x;
			_ny : partial_p[i] = _nx;
		
			default : partial_p[i] = '0;
		endcase

	assign [0]not_msb_pp = ~([24]partial_p[0]);
	assign [1]not_msb_pp = ~partial_p[24][1];
	assign not_msb_pp[2] = ~partial_p[24][2];
	assign not_msb_pp[3] = ~partial_p[24][3];
	assign not_msb_pp[4] = ~partial_p[24][4];
	assign not_msb_pp[5] = ~partial_p[24][5];
	assign not_msb_pp[6] = ~partial_p[24][6];
	assign not_msb_pp[7] = ~partial_p[24][7];

	// add the S bit to the partial products and the extensions
	assign PP[0] = {~partial_p[24][0], partial_p[24][0], partial_p[0]};
	assign PP[1] = {2'b11, ~partial_p[24][1]};
	assign PP[2] = {2'b11, ~partial_p[24][2], partial_p[2], 2'b00, yExt[6], 3'b000};
	assign PP[3] = {2'b11, ~partial_p[24][3], partial_p[3], 2'b00, yExt[9], 6'b000000};
	assign PP[4] = {2'b11, ~partial_p[24][4], partial_p[4], 2'b00, yExt[12], 9'b000000000};
	assign PP[5] = {2'b11, ~partial_p[24][5], partial_p[5], 2'b00, yExt[15], 12'b000000000000};
	assign PP[6] = {2'b11, ~partial_p[24][6], partial_p[6], 2'b00, yExt[18], 15'b000000000000000};
	assign PP[7] = {2'b11, ~(partial_p[24][7]), partial_p[7], yExt[21], 18'b000000000000000000}; 
	assign PP[8] = {yExt[24], 21'b000000000000000000000};

endmodule

