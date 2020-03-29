///////////////////////////////////////////////////////////////// 
// Author - Imants Pulkstenis
// Date - 29.03.2020
// Project name - PS04
// Module name - DDS (direct digital synthesis)
//
// Detailed module description:
// Aim of this problem set – to practice Direct Digital Synthesis in FPGA
//
// Revision:
// A - initial design
// B - 
// C - 
//
///////////////////////////////////////////////////////////////////

// define connections to outside
module dds_vhdl#( parameter
    phase_width = 4,
	data_width	= 8
)(
	input                           clk,    //100mhz clock
	input                           rst,    //rst
    input   [1:0]                   control,
	input   [phase_width - 1:0]     phase_incr, //"frequency"
	output  [phase_width - 1:0]     phase_out,
	output  [data_width  - 1:0]     signal_out);

// define inside of the module
lookuptable lookuptable (
	.in(),
	.out());




endmodule