///////////////////////////////////////////////////////////////// 
// Author - Imants Pulkstenis
// Date - 01.04.2020
// Project name - PS04
// Module name - test bench of DDS (direct digital synthesis)
//
// Detailed module description:
// This module generete clk signal for 
// top module of dds_vhdl project
// The test is executed using Icarus Verilog!
// 
// The result can be evaluated in GTKwave application.  
// Code:
//     iverilog -o output.vvp dds_vhdl_tb.v && vvp output.vvp
//     gtkwave -f wave.vcd
//
// Revision:
// A - initial design
// B - 
// C - 
//
///////////////////////////////////////////////////////////////////

//sub modules
`include "lookuptable.v"
//top module
`include "dds_vhdl.v"

// 100MHz clock input from top module
// 50% duty cycle 5ns HIGH and 5ns LOW
//`timescale [time unit] / [time precision]
`timescale 10 ns / 1ns

//define module and connections to outside
module dds_vhdl_tb #( parameter
    phase_width = 4,
	data_width	= 8
)();

//define inside use signals
	
reg clk = 1'b0;
reg rst = 1'b0;
reg [1:0]   r_control = 'd3;
reg [phase_width - 1:0] r_phase_incr = 'd1;

//---------Test script----------------
// 50% duty cycle clock
always #0.5 clk <= ~clk;

//-----Unit Under test---------------
dds_vhdl #(
        .data_width(8)
) unit_under_test (
        .clk(clk),
        .rst(rst),
        .control(r_control),
        .phase_incr(r_phase_incr),
        .phase_out(),
        .signal_out()
);


//---------Test--------------------
initial begin
    rst = 1;
    #10;
    rst = 0;
    #100
    r_control = 2;
    #100
    r_control = 1;
    #100
    r_control = 0;
    #100
    r_phase_incr = 'd2;
    r_control = 3;
    #100
    r_control = 2;
    #100
    r_control = 1;
    #100
    r_control = 0;
    #100
    $finish();
end
    
initial begin 
    $display(" ");
    $display("----------------------------------------------");
    $display("          Starting Testbench...");
    $dumpfile("wave.vcd");
    $dumpvars(0);
    $display("----------------------------------------------");
    $display(" ");
end



endmodule