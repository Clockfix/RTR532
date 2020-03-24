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
// B - 
// 
//
/////////////////////////////

module top (
    input           clk,
    output  [15:0]  led,
    // 7 segment
    output  [6:0]   seg, 
    output  [3:0]   an, 
    output          dp,  
    input   [15:0]   sw,
    input           btnC     // reset
    );

//------internal wires and registers--------
 
wire  clk16Hz, clk1kHz, w_reset;    
wire    [15:0]  w_counter;

//------assign outputs----------------------
assign led = w_counter;

//-----sub modules--------------------------

counter counter(
    .clk(clk16Hz),
    .reset(w_reset),
    .counter(w_counter)
);

clock_divider #(
    .DIVIDER(1_000),
    .WIDTH(24)
) clock_1kHz_gen (
    .clk(clk),
    .clk_out(clk1kHz)
);

clock_divider #(
    .DIVIDER(5_000*625),
    .WIDTH(22)
) clock_16Hz_gen (
    .clk(clk),
    .clk_out(clk16Hz)
);


debounce_switch debounce_switch_reset(
    .clk(clk),
    .i_switch(btnC),
    .o_switch(w_reset)
);

bin_7segment bin_7segment(
    .clk(clk1kHz),   // clock working with 10kHz
    .in(w_counter),        // input
    .seg(seg),      // individual segments of number
    .an(an),        // anode to select character
    .dp(dp)         // dot on 7segment display
    );

//-------------------------------------------------


endmodule