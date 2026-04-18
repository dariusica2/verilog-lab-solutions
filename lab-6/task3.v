`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task3
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task3(
		output wire o_w_borrow,
		output wire [7:0] o_w_diff,
		input wire [7:0] i_w_A,
		input wire [7:0] i_w_B,
		input wire i_w_borrow
    );

	// TODO 3: Implement an 8-bit ripple-carry subtractor (A - B) using the ripple-carry adder
	// Examples from simulation source
	
	// 1.
	// 64 - 25
	// 6 4 => 0110 0100
	// 2 5 => 0010 0101 => 1101 1010 => 1101 1011
	// 0110 0100 +
	// 1101 1011
	// ---------
	// 0011 1111 => 3 f
	// In this case, the carry bit is 1
	
	// 2.
	// 05 - 1e
	// 0 5 => 0000 0101
	// 1 e => 0001 1110 => 1110 0001 => 1110 0010
	// 0000 0101 +
	// 1110 0010
	// ---------
	// 1110 0111 => e 7
	// In this case, the carry bit is 0
    
	// Borrow bit must be 1 if A is smaller than B
	// Borrow bit will become the negated carry bit
    	wire l_w_carry_tmp;
	
	// Negative B in binary form is (~B + 1)
	// If borrow is 0, 1 needs to be added to ~B
	// If borrow is 1, that means that 1 has already been subtracted
	task2 subtractor(
	    .o_w_carry_out(l_w_carry_tmp),
	    .o_w_sum(o_w_diff),
	    .i_w_A(i_w_A),
	    .i_w_B(~i_w_B),
	    .i_w_carry_in(~i_w_borrow)
	);
	
	assign o_w_borrow = ~l_w_carry_tmp;
	
endmodule
