`timescale 1ns / 1ps
module task0(
    output reg o_w_out,
    input wire[1:0] i_w_sel,
    input wire i_w_in1,
    input wire i_w_in2,
    input wire i_w_clk,
    input wire i_w_reset
);
    
    always @(i_w_clk) begin
        case (i_w_sel)
            2'b00: o_w_out = i_w_in1 ^ i_w_in2;
            2'b01: o_w_out = i_w_in1 & i_w_in2;
            2'b10: o_w_out = ~(i_w_in1 | i_w_in2);
            2'b11: o_w_out = i_w_in1 ^~ i_w_in2;
            default: o_w_out = 1'b0;
        endcase
    end
   
endmodule
