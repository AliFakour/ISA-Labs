module tb_mul ();

   localparam int unsigned WIDTH        = 32;
   localparam int unsigned NUM_OPERANDS = 2;
   
   wire clk_i;
   wire rst_ni;
   wire [NUM_OPERANDS-1:0][WIDTH-1:0] operands_i;
   wire [32:0]res;
   wire [22:0]in1;
   wire [22:0]in2;
      		     
   clk_gen CG(.END_SIM(end_sim),
              .CLK(clk_i),
              .RST_n(rst_ni));

   data_gen DG(.CLK(clk_i),
	       .RST_n(rst_ni),
	       .D0(operands_i[0]),
	       .D1(operands_i[1]),
	       .D2(),
	       .RDY(in_ready_o),
	       .VOUT(in_valid_i),
	       .END_SIM(end_sim));  		    
	       

   assign in1 = operands_i[0];
   assign in2 = operands_i[1];

   multiplier UUT(.x(in1), .y(in2) , .product(res));		 
   
endmodule
   
