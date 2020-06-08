///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - Testbench fot top module of counter
//
// Detailed module description:
//
// Top module test bench
//
// Code:
//     iverilog -o output.vvp top_tb.v && vvp output.vvp
//     gtkwave -f wave.vcd
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////

// 100MHz clock on Basys3 -> 10ns period
// 50% duty cycle 5ns HIGH and 5ns LOW
//`timescale [time unit] / [time precision]
`timescale 10 ns / 1ns

//sub modules
`include "clock_divider.v"
`include "7segment.v"
`include "debounce_switch.v"
`include "counter.v"
`include "sr_latch.v"
`include "flip_flop.v"


//top module
`include "top.v"

module top_tb();

reg clk = 1'b0;
reg reset = 1'b0;
reg [3:0]  sw = 4'b0001;
reg start = 1'b1;
reg up = 1'b0;

// 50% duty cycle clock
always #0.5 clk <= ~clk;

top Test_Unit(
    .clk(clk),
    .sw(sw),
    .btnU(up),
    .btnD(),
    .btnL(start),
    .btnC(reset)
);

initial begin
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    start = 1'b0;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    #1_000_000;
    $display("*");
    $display(" ");
    $display("Use this command to open timing diagram:");
    $display("gtkwave -f wave.vcd");
    $display("----------------------------------------------");
    $finish();
end

initial 
  begin 
    $display(" ");
    $display("----------------------------------------------");
    $display("          Starting Testbench...");
    $dumpfile("wave.vcd");
    $dumpvars(0);
end

endmodule