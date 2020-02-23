///////////////////////////////////////////////////////////////// 
// Author - Imants Pulkstenis
// Date - 23.02.2020
// Project name - PS03
// Module name - Testbench for Smart traffic light controler
//
// Detailed module description:
//
// Generating the stimulation 
// Clk - Generate the 1GHz clock input 
// Rst - generate both high and low reset to ensure correct start up, per Required functionality 
// MR_cars - generate multiple values to simulate real world traffic situation (e.g. at night some 
// cars arrive once per 60nanoseconds, in day – more cars) and verify that smart traffic light controller is working correctly. 
//
// The test can be executed using Icarus Verilog!
// The result can be evaluated in GTKwave application.  
// Code:
//     iverilog -o output.vvp tlc_tb.v && vvp output.vvp
//     gtkwave -f wave.vcd
//
// Revision:
// A - initial design
// B - 
// C - 
//
///////////////////////////////////////////////////////////////////

//UUT module
`include "traffic_light_controller.v"

// 1GHz clock -> 1ns period
// 50% duty cycle 0.5ns HIGH and 0.5ns LOW
// `timescale [time unit] / [time precision]
`timescale 1ns / 100ps

//define module 
module tlc_tb ();

//define inside use signals
reg         clk     = 1'b0;
reg         rst     = 1'b1;
reg [7:0]   MR_cars = 'b0;

integer ii=0;

//---------Test script----------------
// 50% duty cycle clock
always #0.5 clk <= ~clk;

//-----Unit Under test---------------
traffic_light_controller #(
        .PARAMETER(45)
) unit_under_test (
        .clk(clk),
        .rst(rst),
        .MR_cars(MR_cars),
        .MR_ctl(),
	    .SR_ctl());

//---------Reset Test--------------------
initial begin
    rst = 0;
    #10;
    rst = 1;
    #200
    rst = 0;
    #100;
    rst = 1;
    
end


initial
    begin
    //---------Daytime traffic Test--------------------
      for (ii=0; ii<50; ii=ii+1)
        begin
          MR_cars = ii;
          #10;
        end
      MR_cars = 0;
      #100;
      //---------Nighttime traffic Test--------------------
      for (ii=0; ii<50; ii=ii+1)
        begin
          MR_cars = ii;
          #60;
        end
      #100;
      $finish();
    end

// just print text 
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