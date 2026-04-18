`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Organization and Architecture
//  
// Module Name:  		task4
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 7
//////////////////////////////////////////////////////////////////////////////////

module task4(
    output wire [7:0] o_w_result,
    input  wire [7:0] i_w_a,
    input  wire [7:0] i_w_b,
    input  wire [2:0] i_w_op_sel
);
    // TODO 1: Instantiate task2 and task3 for ADD and SUB
    // Values for sum and difference
    wire [7:0] l_w_result_sum;
    wire [7:0] l_w_result_diff;
    // Instantiate adder module
    task2 adder(
        .o_w_sum(l_w_result_sum),
        .i_w_A(i_w_a),
        .i_w_B(i_w_b),
        .i_w_carry_in(0)
    );
    // Instantiate subtractor module
    task3 subtractor(
        .o_w_diff(l_w_result_diff),
        .i_w_A(i_w_a),
        .i_w_B(i_w_b),
        .i_w_borrow(0)
    );

    // TODO 2: Define a result reg and implement the logic to run the operation from op_sel on a and b
    reg[7:0] l_r_result;
  
    always @(*) begin
        case(i_w_op_sel)
            // AND
            3'd0:
                l_r_result = i_w_a & i_w_b;
            // XOR
            3'd1:
                l_r_result = i_w_a ^ i_w_b;
            // OR
            3'd2:
                l_r_result = i_w_a | i_w_b;
            // ADD
            3'd3:
                l_r_result = l_w_result_sum;
            // SUB
            3'd4:
                l_r_result = l_w_result_diff;
            default:
                l_r_result = 8'd0;
        endcase
    end

    // TODO 3: Assign o_w_result to result
    assign o_w_result = l_r_result;

endmodule
