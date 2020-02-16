/////////////////////////////
// Author - Imants Pulkstenis
// Date - 16.02.2020
// Project name - PS02
// Module name - Top module for PS02
//
// Detailed module description:
//
// Includes an existing (my or somebody else’s) 
// design entity (another vhdl or verlilog file) 
// in other design entity
//
//
//
//
// Revision:
// A - initial design
// B - VHDL code are replaced with Verilog
//
/////////////////////////////


//define connections to outside
module ps02 #( parameter
	data_width = 32
)(
	input                               clk, 
	input                               rst,
	output signed [data_width - 1:0]    R,
	output                              flag
);

    //define inside of the module
	 //define inside use signals
	wire signed     [data_width - 1:0]      A;
	wire signed     [data_width - 1:0]      B;
	wire    			 [3:0]                   op;
	
    //component declaration for A, B, op signal generator
    //port map for A, B, op signal generator
ps02_siggen #(
        .data_width(data_width)
    ) name_of_unit (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .op(op)
);

    //component declaration for alu  (TASK 1)
    //port map for ALU (TASK 1)
alu #(
        .data_width(data_width)
    ) name_of_alu_unit (
        .clk(clk),
        .A(A),
        .B(B),
        .op(op),
        .R(R),
        .flag(flag)
);
	

endmodule

