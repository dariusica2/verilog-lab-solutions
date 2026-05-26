`timescale 1ns / 1ps

`define COLOR_NONE 3'b000
`define COLOR_RED 3'b100
`define COLOR_YELLOW 3'b110
`define COLOR_GREEN 3'b010

module ex3_bonus(
    output [2:0] o_r_rgb_cars,
    output [2:0] o_r_rgb_peds,
    input i_w_button,
    input i_w_reset,
    input i_w_clk
);

    // STATES
    localparam STATE_INITIAL   = 0;
    localparam STATE_00        = 1; // cars green
    localparam STATE_01        = 2; // cars yellow
    localparam STATE_02        = 3; // pedestrians green
    localparam STATE_BLINK_ON  = 4;
    localparam STATE_BLINK_OFF = 5;

    reg l_r_button_pressed;
    wire l_w_button_debounced;
    debouncer l_m_db(l_w_button_debounced, i_w_clk, i_w_reset, i_w_button);

    reg [31:0] l_r_count;
    reg [31:0] l_r_count_blink;
    reg [2:0]  l_r_currentState;
    reg [2:0]  l_r_nextState;

    reg [2:0] l_r_cars;
    reg [2:0] l_r_pedestrians;

    reg [2:0] blink_cycles; // counts how many blinks done

    always @(posedge i_w_clk) begin
        if (i_w_reset) begin
            l_r_currentState <= STATE_INITIAL;
            l_r_nextState <= STATE_INITIAL;
            l_r_button_pressed <= 0;
            l_r_count <= 0;
            l_r_count_blink <= 0;
            blink_cycles <= 0;
            l_r_cars <= `COLOR_NONE;
            l_r_pedestrians <= `COLOR_NONE;
        end else begin
            l_r_currentState <= l_r_nextState;

            // debounce button
            if (l_w_button_debounced) begin
                l_r_button_pressed <= 1;
                l_r_count <= 0;
            end

            case (l_r_currentState)

                STATE_INITIAL: begin
                    l_r_nextState <= STATE_00;
                end

                // CARS GREEN
                STATE_00: begin
                    l_r_cars <= `COLOR_GREEN;
                    l_r_pedestrians <= `COLOR_RED;

                    if (l_r_button_pressed) begin
                        l_r_count <= l_r_count + 1;
                        if (l_r_count == 100000000) begin
                            l_r_button_pressed <= 0;
                            l_r_count <= 0;
                            l_r_nextState <= STATE_01;
                        end
                    end
                end

                // CARS YELLOW
                STATE_01: begin
                    l_r_cars <= `COLOR_YELLOW;
                    l_r_pedestrians <= `COLOR_RED;

                    l_r_count <= l_r_count + 1;
                    if (l_r_count == 100000000) begin
                        l_r_count <= 0;
                        l_r_nextState <= STATE_02;
                    end
                end

                // PEDESTRIANS GREEN
                STATE_02: begin
                    l_r_cars <= `COLOR_RED;
                    l_r_pedestrians <= `COLOR_GREEN;

                    l_r_count <= l_r_count + 1;
                    if (l_r_count == 300000000) begin
                        l_r_count <= 0;
                        l_r_count_blink <= 0;
                        blink_cycles <= 0;
                        l_r_nextState <= STATE_BLINK_OFF;
                    end
                end

                // BLINK OFF
                STATE_BLINK_OFF: begin
                    l_r_cars <= `COLOR_RED;
                    l_r_pedestrians <= `COLOR_NONE;

                    l_r_count_blink <= l_r_count_blink + 1;
                    if (l_r_count_blink == 100000000) begin
                        l_r_count_blink <= 0;
                        l_r_nextState <= STATE_BLINK_ON;
                    end
                end

                // BLINK ON
                STATE_BLINK_ON: begin
                    l_r_cars <= `COLOR_RED;
                    l_r_pedestrians <= `COLOR_GREEN;

                    l_r_count_blink <= l_r_count_blink + 1;
                    if (l_r_count_blink == 100000000) begin
                        l_r_count_blink <= 0;
                        blink_cycles <= blink_cycles + 1;

                        if (blink_cycles == 3) begin
                            l_r_nextState <= STATE_00; // back to normal
                        end else begin
                            l_r_nextState <= STATE_BLINK_OFF;
                        end
                    end
                end

            endcase
        end
    end

    // PWM modules
    rgb_pwm l_m_cars (
        .o_r_out(o_r_rgb_cars),
        .i_w_in(l_r_cars),
        .i_w_clk(i_w_clk)
    );

    rgb_pwm l_m_pedestrians (
        .o_r_out(o_r_rgb_peds),
        .i_w_in(l_r_pedestrians),
        .i_w_clk(i_w_clk)
    );

endmodule