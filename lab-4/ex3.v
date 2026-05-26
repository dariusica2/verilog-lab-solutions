`timescale 1ns / 1ps

// HINT: Folositi urmatoarele constante pentru
//       a atribui culoarea LED-ului
`define COLOR_NONE 3'b000
`define COLOR_RED 3'b100
`define COLOR_YELLOW 3'b110
`define COLOR_GREEN 3'b010

module ex3(
    output [2:0] o_r_rgb_cars,  // Semnal cu PWM aplicat
    input i_w_button,
    input i_w_reset,
    input i_w_clk
);

    // TODO: Definiti starile automatului
    localparam STATE_INITIAL = 0; // EMPTY
    localparam STATE_00 = 1; // GREEN
    localparam STATE_01 = 2; // YELLOW
    localparam STATE_02 = 3; // RED
    
    // Modul de debounce pentru butonul de pietoni
    reg l_r_button_pressed;
    wire l_w_button_debounced;
    debouncer l_m_db(l_w_button_debounced, i_w_clk, i_w_reset, i_w_button);
    
    reg [31:0]  l_r_count;
    reg [1:0]   l_r_currentState;
    reg [1:0]   l_r_nextState;
    
    // INFO: Blocul always va gestiona atat logica iesirilor si a tranzitiilor,
    //       cat si efectuarea tranzitiilor cu delay-urile aferente.
    //       Asadar, va trebui sa setati atat valoarea iesirii, cat si
    //       valoarea starii urmatoare l_r_nextState la momentul potrivit.
    
    // Registrul pe care il veti folosi pentru culorile semaforului
    reg [2:0]   l_r_cars;
    
    always @(posedge i_w_clk) begin
        if (i_w_reset == 1) begin
            // Setati starea si culoarea initiala
             l_r_button_pressed <= 0;
             l_r_count <= 0;
             l_r_cars <= `COLOR_NONE;
        end else begin
            l_r_currentState <= l_r_nextState;
            
            if (l_w_button_debounced == 1) begin
                // Daca este apasat butonul, marcati acest lucru folosind
                // flag-ul l_r_button_pressed si initializati timer-ul.
                l_r_button_pressed <= 1;
                l_r_count <= 0;
            end
            
            case(l_r_currentState)
                STATE_INITIAL: begin
                    l_r_nextState <= STATE_00;
                end
                
                STATE_00: begin
                    l_r_cars <= `COLOR_GREEN;
                    if (l_r_button_pressed == 1) begin
                        l_r_count <= l_r_count + 1;
                        if (l_r_count == 100000000) begin
                            l_r_count <= 0;
                            l_r_button_pressed <= 0;
                            l_r_nextState <= STATE_01;
                        end
                    end
                end
                
                STATE_01: begin
                    l_r_cars <= `COLOR_YELLOW;
                    l_r_count <= l_r_count + 1;
                    if (l_r_count == 100000000) begin
                        l_r_count <= 0;
                        l_r_nextState <= STATE_02;
                    end
                end
                
                STATE_02: begin
                    l_r_cars <= `COLOR_RED;
                    l_r_count <= l_r_count + 1;
                    if (l_r_count == 300000000) begin
                        l_r_count <= 0;
                        l_r_nextState <= STATE_00;
                    end
                end
            endcase
        end
    end
    
    // Diminuam intensitatea LED-ului
    rgb_pwm l_m_cars (
        .o_r_out(o_r_rgb_cars),
        .i_w_in(l_r_cars),
        .i_w_clk(i_w_clk)
    );
endmodule