`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task2
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task2(
		output wire o_w_carry_out,
		output wire [7:0] o_w_sum,
		input wire [7:0] i_w_A,
		input wire [7:0] i_w_B,
		input wire i_w_carry_in
    );
	
	// TODO 2: Implement an 8-bit ripple-carry adder using the full-adder
	// Using an array for temporary carry values
	wire [8:0] l_w_carry_tmp;
	// First carry value is the input carry
	assign l_w_carry_tmp[0] = i_w_carry_in;
	
	// Declare a temporary loop variable to be used during generation
	genvar i;
	// Generate for loop to instantiate full adders 8 times
	for (i = 0; i < 8; i = i + 1) begin
	    task1 full_adder(o_w_sum[i], l_w_carry_tmp[i + 1], i_w_A[i], i_w_B[i], l_w_carry_tmp[i]);
	end
	
	// Last carry value of the array is the output carry value
	assign o_w_carry_out = l_w_carry_tmp[8];

endmodule
