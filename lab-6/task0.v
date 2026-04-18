`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 06:39:25 PM
// Design Name: 
// Module Name: task0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module task0(
		output wire o_w_sum,
		output wire o_w_carry,
		input wire i_w_bit_A,
		input wire i_w_bit_B
    );

	// TODO 1.a: Implement a half-adder
	assign o_w_sum = i_w_bit_A ^ i_w_bit_B;
	assign o_w_carry = i_w_bit_A & i_w_bit_B;

endmodule
