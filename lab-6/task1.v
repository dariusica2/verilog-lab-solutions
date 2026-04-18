`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task1
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task1(
		output wire o_w_sum,
		output wire o_w_carry_out,
		input wire i_w_bit_A,
		input wire i_w_bit_B,
		input wire i_w_carry_in
    );
	
	// TODO 1.b: Implement a full-adder using the half-adder
	// Declare temporary values
	wire l_w_sum_tmp;
	wire l_w_carry_tmp_0, l_w_carry_tmp_1;
	
	// First half adder with inputs: bit A and bit B
	task0 half_adder_0(
	    .o_w_sum(l_w_sum_tmp),
	    .o_w_carry(l_w_carry_tmp_0),
	    .i_w_bit_A(i_w_bit_A),
	    .i_w_bit_B(i_w_bit_B)
	);

	// Second half adder with inputs: sum output from first half adder
	// and carry from input
	task0 half_adder_1(
	    .o_w_sum(o_w_sum),
	    .o_w_carry(l_w_carry_tmp_1),
	    .i_w_bit_A(l_w_sum_tmp),
	    .i_w_bit_B(i_w_carry_in)
	);

	// Output carry
	or(o_w_carry_out, l_w_carry_tmp_0, l_w_carry_tmp_1);

endmodule
