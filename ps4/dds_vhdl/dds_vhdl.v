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



reg [phase_width - 1:0]  r_phase_incr = 'd0;
reg [phase_width - 1:0]  r_phase_out = 'd0;


// Phase increment – determines output frequency
always@(posedge clk)begin
	if (rst) begin
		r_phase_incr <= 0; end
	else begin 
			r_phase_incr <= phase_incr; end
end

// Phase accumulator – the «counter»
always@(posedge clk)begin
	if (rst) begin
		r_phase_out <= 0; end
	else begin 
		r_phase_out <= phase_out + phase_incr; end
end

// Look-up table – memory where waveform is stored
lookuptable lookuptable (
	.phase( // mux
			(control== 0) ? 4'b0 : 
			(control== 1) ? {2'b0, phase_out[phase_width - 3:0] } : 
			(control== 2) ? {1'b0, phase_out[phase_width - 2:0] } : 
			phase_out  
			// end of MUX
			),
	.sin(signal_out),
	.cos());

assign phase_out = r_phase_out;

endmodule