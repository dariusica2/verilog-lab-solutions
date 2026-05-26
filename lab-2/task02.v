`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: SOC Team @ UPB
//
// Design Name: Demultiplexer 1:4
// Module Name: task02
// Project Name: Laborator 2
// Target Devices: XC7A100T-1CSG324C
// Tool Versions: 2017.4
// Description: ex2 / lab02
// 
// Dependencies: 
// 
// Revision:
// Revision 2023.03.10 - File Created
//////////////////////////////////////////////////////////////////////////////////

module task02(
    // TODO: declarati aici intrarile si iesirile modulului
    output reg [3:0] out,
    input in,
    input [1:0] sel
    );

    // TODO: implementati un Demultiplexor 1:4
    //  a. la nivel structural
//    wire s1;
//    buf(s1, sel[1]);
    
//    wire s0;
//    buf(s0, sel[0]);
    
//    wire nots1;
//    not(nots1, sel[1]);
    
//    wire nots0;
//    not(nots0, sel[0]);
    
//    and(out[0], in, nots1, nots0);  // 1000 daca sel = 00
//    and(out[1], in, nots1, s0);     // 0100 daca sel = 01
//    and(out[2], in, s1, nots0);     // 0010 daca sel = 10
//    and(out[3], in, s1, s0);        // 0001 daca sel = 11
    
    //  b. la nivel procedural
    always @(*) begin
        out = { in & sel[1] & sel[0],
                in & sel[1] & ~sel[0],
                in & ~sel[1] & sel[0],
                in & ~sel[1] & ~sel[0] };
    end

endmodule
