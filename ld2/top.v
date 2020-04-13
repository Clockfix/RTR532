///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - Top module for counter
//
// Detailed module description:
//
// This module count and displays result on 
// 7-segment display and LEDs
//
//
//
// Revision:
// A - initial design
// B - Correct timmers and 7-segment display.
//     Added UP/DOWN and START/STOP function
// 
//
/////////////////////////////

module top (
    input           clk,
    output  [15:0]   led,
    // 7 segment
    output  [6:0]   seg, 
    output  [3:0]   an, 
    output          dp,  
    input   [3:0]   sw,
    input           btnC,     // reset
    input           btnU,     // UP counting
    input           btnD,     // DOWN counting
    input           btnL      // start/stop 
    );

//------internal wires and registers--------
 
wire    clk16Hz, clk1kHz, 
        w_reset, w_up, 
        w_down, w_direction, 
        w_start, w_enable;  
wire    [15:0]  w_counter;


//------assign outputs----------------------
assign led = w_counter;

//-----sub modules--------------------------

counter counter(
    .clk(clk16Hz),
    .reset(w_reset),
    .direction(w_direction),
    .enable(w_enable),
    .max(sw),
    .counter(w_counter)
);

clock_divider #(
    .DIVIDER(50_000),  // 50000 * 10ns = 500us
    .WIDTH(24)
) clock_1kHz_gen (
    .clk(clk),
    .clk_out(clk1kHz)
);

clock_divider #(
    .DIVIDER(3_125_000),  // 3125000 * 10ns =  31.25ms
    .WIDTH(24)
) clock_16Hz_gen (
    .clk(clk),
    .clk_out(clk16Hz)
);

debounce_switch debounce_switch_reset(
    .clk(clk),
    .i_switch(btnC),
    .o_switch(w_reset)
);

debounce_switch debounce_up(
    .clk(clk),
    .i_switch(btnU),
    .o_switch(w_up)
);

debounce_switch debounce_down(
    .clk(clk),
    .i_switch(btnD),
    .o_switch(w_down)
);

debounce_switch debounce_start(
    .clk(clk),
    .i_switch(btnL),
    .o_switch(w_start)
);

sr_latch up_down_latch(
    .clk(clk),
    .up(~w_up),
    .down(~w_down),
    .out(w_direction)
);

flip_flop start_stop_flipflop(
    .start(w_start),
    .out(w_enable)
);

bin_7segment bin_7segment(
    .clk(clk1kHz),  // clock working with 10kHz
    .in(w_counter), // input
    .seg(seg),      // individual segments of number
    .an(an),        // anode to select character
    .dp(dp)         // dot on 7segment display
    );

//-------------------------------------------------


endmodule