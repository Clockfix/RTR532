///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - Testbench for 7-segment module
//
// Detailed module description:
//
// This module inputs slowly incrementing 
// numbers in 7-segment module
//
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////
`include "7segment.v"

module bin_7segment_tb();

reg           clk   = 1'b0;
reg   [15:0]  in    = 'b0;
wire  [6:0]   seg;
wire  [3:0]   an;
wire          dp;

always #1 clk <= ~clk; 

always #40 in <= in + 1;

  initial
  begin
    #1000;
    $finish();
  end
    
  initial 
  begin 
    $display(" ");
    $display("----------------------------------------------");
    $display("          Starting Testbench...");
    $dumpfile("wave.vcd");
    $dumpvars(0);
    $display("----------------------------------------------");
    $display(" ");
  end

bin_7segment test_unit1(
    .clk(clk),
    .in(in),
    .seg(seg),
    .an(an),
    .dp(dp)
);



endmodule