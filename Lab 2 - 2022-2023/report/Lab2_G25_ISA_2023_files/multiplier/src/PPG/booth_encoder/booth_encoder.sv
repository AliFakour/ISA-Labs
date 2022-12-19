/* booth encoder module a LUT  that receive as input 4 bit of data 
 and as selput the selection signal between 0, A, 2A, 3A, 4A,... 
 9 total choice the selput is on 4 bit */

module booth_encoder import globals::*; (
	input wire [3:0]dIn,
	output booth_selection_type sel );
	
	always_comb
	case (dIn)
		4'b0000 : sel = zero;
		4'b0001 : sel = _y;
		4'b0010 : sel = _y;
		4'b0011 : sel = _2y;
		4'b0100 : sel = _2y;
		4'b0101 : sel = _3y; 
		4'b0110 : sel = _3y; 
		4'b0111 : sel = _4y;
		4'b1000 : sel = _n4y;
		4'b1001 : sel = _n3y;
		4'b1010 : sel = _n3y;
		4'b1011 : sel = _n2y;
		4'b1100 : sel = _n2y;
		4'b1101 : sel = _ny;
		4'b1110 : sel = _ny;
		4'b1111 : sel = zero;
		default: sel = zero;
	endcase

endmodule
