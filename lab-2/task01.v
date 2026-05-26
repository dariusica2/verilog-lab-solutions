`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: SOC Team @ UPB
//
// Design Name: XOR Gate
// Module Name: task01
// Project Name: Laborator 2
// Target Devices: XC7A100T-1CSG324C
// Tool Versions: 2017.4
// Description: ex1 / lab02
// 
// Dependencies: 
// 
// Revision:
// Revision 2023.03.10 - File Created
//////////////////////////////////////////////////////////////////////////////////

module task01(
    // TODO: declarati aici intrarile si iesirile modulului
    // output out,
    output reg out,
    input in1,
    input in2
    );

    // TODO: implementati o poarta XOR:
    //  a. la nivel flux de date
    // assign out = in1 ^ in2;
    //  b. la nivel procedural
    always @(*) begin
        out = in1 ^ in2;
    end

endmodule