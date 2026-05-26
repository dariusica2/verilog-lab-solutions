`timescale 1ns / 1ps
module ex1(
	output reg o_r_out,
	input wire i_w_reset,
	input wire i_w_clk
);

	localparam STATE_INITIAL = 0;
	localparam STATE_T00 = 1;

	reg [31:0]  l_r_count;
	reg         l_r_currentState;
	reg         l_r_nextState;

	always @(posedge i_w_clk) begin
		if (i_w_reset == 1) begin
			// TODO: Ce se intampla daca este apasat butonul de resetare
			//       in timpul functionarii automatului?
			l_r_currentState <= STATE_INITIAL;
			l_r_count <= 0;
		end else begin
			// TODO: Tranzitia de la l_r_currentState la l_r_nextState
		    //       dupa 1 secunda.
		    l_r_count <= l_r_count + 1;
		    if (l_r_count == 50000000) begin
		        l_r_currentState <= l_r_nextState;
		        l_r_count <= 0;
		    end
		end
	end

	always @(*) begin
	    l_r_nextState = l_r_currentState;
	    o_r_out = (l_r_currentState == STATE_T00);
	    
		case (l_r_currentState)
			// TODO: Pentru fiecare stare stabiliti valoare iesirii (pe model Moore)
			//       si tranzitiile in stari ulterioare.
			STATE_INITIAL: begin
			    l_r_nextState <= STATE_T00;
			end
			STATE_T00: begin
			    l_r_nextState <= STATE_INITIAL;
			end
			
		endcase
	end
endmodule
