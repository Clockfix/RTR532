/////////////////////////////
// Author - Imants Pulkstenis
// Date - 16.02.2020
// Project name - PS02
// Module name - Test bench for PS02 project Top module 
//
// Detailed module description:
//
// This module generete clk signal for 
// for tom podule of ps02 project
// The test is executed using Icarus Verilog!
// 
// The result can be evaluated in GTKwave application.  
// Code:
//     iverilog -o output.vvp ps02_tb.v && vvp output.vvp
//     gtkwave -f wave.vcd
//
// Revision:
// A - initial design
// 
//
/////////////////////////////

//sub modules
`include "alu.v"
`include "ps02_siggen.v"
//top module
`include "ps02.v"


//define module and connections to outside
module ps02_tb ();

//define inside use signals
	
reg clk = 1'b0;
reg rst = 1'b0;

//---------Test script----------------
// 50% duty cycle clock
always #0.5 clk <= ~clk;

//-----Unit Under test---------------
ps02 #(
        .data_width(32)
) unit_under_test (
        .clk(clk),
        .rst(rst),
        .R(),
        .flag()
);

//---------Test--------------------
initial
  begin
    rst = 1;
    #10;
    rst = 0;
    #100
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



endmodule





