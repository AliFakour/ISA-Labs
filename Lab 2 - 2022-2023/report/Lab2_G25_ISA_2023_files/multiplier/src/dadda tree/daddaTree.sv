module daddaTree import globals ::*; (
	input wire [45:0]PP[0:8],
	output wire [31:0]C,
	output wire [31:0]S );

	// layers of the reduction tree
	wire [45:0][8]l3;
	wire [45:0][5]l2;
	wire [45:0][3]l1;
	wire [45:0][2]l0;

	wire [21]Tout_l3;
	wire [25]Tout_l2;

	genvar i;

	// zero paffing of the inputs partial products
	assign l3[0] = PP[0];
	assign l3[1] = PP[1];
	assign l3[2] = PP[2];
	assign l3[3] = PP[3];
	assign l3[4] = PP[4];
	assign l3[5] = PP[5];
	assign l3[6] = PP[6];
	assign l3[7] = PP[7] ;	// MSB for carry of the layer

	// component instantiation
		// reduction layer 3, from 8 partial product to 5
			// 2 to 2 compressors (HA)
			ha ha_c5(.x1(l3[5][0]), .x2(l3[5][1]), .S(l2[5][0]), .C(l2[6][1]));
			ha ha_c7(.x1(l3[7][4]), .x2(l3[7][5]), .S(l2[7][2]), .C(l2[8][3]));
			ha ha_c25(.x1(l3[25][5]), .x2(l3[25][6]), .S(l2[25][2]), .C(l2[26][3]));

			// 3 to 2 compressors (FA)
			fa fa_c27(.Cin(l3[27][3]), .x1(l3[27][4]), .x2(l3[27][5]), .S(l2[27][0]), .C(l2[28][1]));
			generate
				for(i = 8; i < 25; i++) begin : FA_i_l3
					fa FA_l3(.x1(l3[i][4]), .x2(l3[i][5]), .Cin(l3[i][6]), .S(l2[i][2]), .C(l2[i+1][3]));
				end
			endgenerate

			// 4 to 2 compressors (2FA)
			cmpr_4_2 cmpr_4_2_c6_l3(.Tin(1'b0), .x1(l3[6][0]), .x2(l3[6][1]), .x3(l3[6][2]), .x4(l3[6][3]), .Tout(Tout_l3[0]), .S(l2[6][0]), .C(l2[7][1]));	// first Tin = 0
			generate
				for(i = 0; i < 19; i++) begin : cmpr_4_2_i_l3
					cmpr_4_2 cmpr_4_2_l3(.Tin(Tout_l3[i]), .x1(l3[i+7][0]), .x2(l3[i+7][1]), .x3(l3[i+7][2]), .x4(l3[i+7][3]), .Tout(Tout_l3[i+1]), .S(l2[i+7][0]), .C(l2[i+8][1]));
				end
			endgenerate
		
		// reduction layer 2, from 5 partial product to 3
			// 2 to 2 compressors (HA)
			ha ha_c3(.x1(l2[3][0]), .x2(l2[3][1]), .S(l1[3][0]), .C(l1[4][1]));

			// 3 to 2 compressors (FA)
			fa fa_c29(.Cin(l2[29][0]), .x1(l2[29][1]), .x2(l2[29][2]), .S(l1[29][0]), .C(l2[30][1]));

			// 4 to 2 compressors (2FA)
			cmpr_4_2 cmpr_4_2_c4_l2(.Tin(1'b0), .x1(l2[4][0]), .x2(l2[4][1]), .x3(l2[4][2]), .x4(l2[4][3]), .Tout(Tout_l2[0]), .S(l1[4][0]), .C(l1[5][1]));	// first Tin = 0
			generate
				for(i = 0; i < 23; i++) begin : cmpr_4_2_i_l2
					cmpr_4_2 cmpr_4_2_l2(.Tin(Tout_l2[i]), .x1(l2[i+5][0]), .x2(l2[i+5][1]), .x3(l2[i+5][2]), .x4(l2[i+5][3]), .Tout(Tout_l2[i+1]), .S(l1[i+5][0]), .C(l1[i+6][1]));
				end
			endgenerate
		
		// reduction layer 0, from 3 partial product to 2
			// 2 to 2 compressors (HA)
			ha ha_c2(.x1(l1[2][0]), .x2(l1[2][1]), .S(l0[2][0]), .C(l0[3][1]));

			// 3 to 2 compressors (FA)
			generate
				for(i = 3; i < 31; i++) begin : FA_i_l0
					fa fa_l0(.x1(l1[i][0]), .x2(l1[i][1]), .Cin(l1[i][2]), .S(l0[i][0]), .C(l0[i+1][1]));
				end
			endgenerate

	// bit without compression
		// layer 3
		assign l2[0][0] = l3[0][0];	// c0

		assign l2[1][0] = l3[1][0];	// c1
		assign l2[1][1] = l3[1][1];
	
		assign l2[2][0] = l3[2][0];	// c2
		assign l2[2][1] = l3[2][1];
		assign l2[2][2] = l3[2][2];

		assign l2[3][0] = l3[3][0];	// c3
		assign l2[3][1] = l3[3][1];
		assign l2[3][2] = l3[3][2];
		assign l2[3][3] = l3[3][3];
	
		assign l2[4][0] = l3[4][0];	// c4
		assign l2[4][1] = l3[4][1];
		assign l2[4][2] = l3[4][2];
		assign l2[4][3] = l3[4][3];
		assign l2[4][4] = l3[4][4];

		assign l2[5][1] = l3[5][2];	// c5
		assign l2[5][2] = l3[5][3];
		assign l2[5][3] = l3[5][4];
		assign l2[5][4] = l3[5][5];	

		assign l2[6][2] = l3[6][4];	// c6
		assign l2[6][3] = l3[6][5];
		assign l2[6][4] = l3[6][6];

		assign l2[7][3] = l3[7][6];	// c7
		assign l2[7][4] = l3[7][7];

		assign l2[8][4] = l3[8][7];	// c8
		assign l2[9][4] = l3[9][7];	// c9
		assign l2[10][4] = l3[10][7];	// c10
		assign l2[11][4] = l3[11][7];	// c11
		assign l2[12][4] = l3[12][7];	// c12
		assign l2[13][4] = l3[13][7];	// c13
		assign l2[14][4] = l3[14][7];	// c14
		assign l2[15][4] = l3[15][7];	// c15
		assign l2[16][4] = l3[16][7];	// c16
		assign l2[17][4] = l3[17][7];	// c17
		assign l2[18][4] = l3[18][7];	// c18
		assign l2[19][4] = l3[19][7];	// c19
		assign l2[20][4] = l3[20][7];	// c20
		assign l2[21][4] = l3[21][7];	// c21
		assign l2[22][4] = l3[22][7];	// c22
		assign l2[23][4] = l3[23][7];	// c23
		assign l2[24][4] = l3[24][7];	// c24

		assign l2[25][4] = l3[25][7];	// c25

		assign l2[26][2] = l3[26][6];	// c26
		assign l2[26][4] = l3[26][7];	

		assign l2[27][2] = Tout_l3[20];
		assign l2[27][3] = l3[27][6];	// c27
		assign l2[27][4] = l3[27][7];

		assign l2[28][0] = l3[28][4];	// c28
		assign l2[28][2] = l3[28][5];
		assign l2[28][3] = l3[28][6];
		assign l2[28][4] = l3[28][7];

		assign l2[29][0] = l3[29][5];	// c29
		assign l2[29][1] = l3[29][6];
		assign l2[29][2] = l3[29][7];

		assign l2[30][0] = l3[30][6];	// c30
		assign l2[30][1] = l3[30][7];	

		assign l2[31][0] = l3[31][7];	// c31

		// layer 2
		assign l1[0][0] = l2[0][0];	// c0

		assign l1[1][0] = l2[1][0];	// c1
		assign l1[1][1] = l2[1][1];
		
		assign l1[2][0] = l2[2][0];	// c2
		assign l1[2][1] = l2[2][1];	
		assign l1[2][2] = l2[2][2];	

		assign l1[3][1] = l2[3][2];	// c3
		assign l1[3][2] = l2[3][3];

		assign l1[4][2] = l2[4][4];	// c4
		assign l1[5][2] = l2[5][4];	// c5
		assign l1[6][2] = l2[6][4];	// c6
		assign l1[7][2] = l2[7][4];	// c7
		assign l1[8][2] = l2[8][4];	// c8
		assign l1[9][2] = l2[9][4];	// c9
		assign l1[10][2] = l2[10][4];	// c10
		assign l1[11][2] = l2[11][4];	// c11
		assign l1[12][2] = l2[12][4];	// c12
		assign l1[13][2] = l2[13][4];	// c13
		assign l1[14][2] = l2[14][4];	// c14
		assign l1[15][2] = l2[15][4];	// c15
		assign l1[16][2] = l2[16][4];	// c16
		assign l1[17][2] = l2[17][4];	// c17
		assign l1[18][2] = l2[18][4];	// c18
		assign l1[19][2] = l2[19][4];	// c19
		assign l1[20][2] = l2[20][4];	// c20
		assign l1[21][2] = l2[21][4];	// c21
		assign l1[22][2] = l2[22][4];	// c22
		assign l1[23][2] = l2[23][4];	// c23
		assign l1[24][2] = l2[24][4];	// c24
		assign l1[25][2] = l2[25][4];	// c25
		assign l1[26][2] = l2[26][4];	// c26
		assign l1[27][2] = l2[27][4];	// c27
		assign l1[28][2] = l2[28][4];	// c28

		assign l1[29][2] = Tout_l2[24];	// c29

		assign l1[30][0] = l2[30][0];	// c30
		assign l1[30][2] = l2[30][1];

		assign l1[31][0] = l2[31][0];	// c31

		// layer 1
		assign l0[0][0] = l1[0][0];	// c0

		assign l0[1][0] = l1[1][0];	// c1
		assign l0[1][1] = l1[1][1];

		assign l0[31][0] = l1[31][0];	// c31

	assign C = l0[1];
	assign S = l0[0];

endmodule


