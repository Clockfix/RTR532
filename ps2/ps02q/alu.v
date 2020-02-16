///////////////////////////// info header [part 1 of the Verliog file]
// Author - Imants Pulkstenis
// Date - 16.02.2020
// Project name - PS02
// Module name - alu
//
// Detailed module description:
//
// Arithmetic Logic Unit for PS02 project
//
//
//
//
// Revision:
// A - initial design
// B - VHDL code are replaced with Verilog
// C - ALU logic defined in module
//
/////////////////////////////

//no need for libraries [part 2 of the Verilog file]


//Entity declaration [part 3 of the Verilog file].
module alu #( parameter
	data_width = 32
)(
	input                                   clk,
	input               [data_width - 1:0]  A,
	input               [data_width - 1:0]  B,
	input               [3:0]               op,
	output              [data_width - 1:0]  R,
	output                                  flag);


//define inside of the module
//define inside use signals and components [part 4 of the VHDL file]

reg [data_width -1 :0]      reg_R  = 'h0;                
//define the operation of the module! [part 5 of the VHDL file]
always@(posedge clk) begin
    case (op)        
            4'h0: reg_R   <= (A - B);
            4'h1: reg_R   <= (A + B);

            4'h2: reg_R[data_width - 1:0]   <= (A ~& B);
            4'h3: reg_R[data_width - 1:0]   <= (A & B);
            4'h4: reg_R[data_width - 1:0]   <= (A | B);
            4'h5: reg_R[data_width - 1:0]   <= (A ~| B);
            4'h6: reg_R[data_width - 1:0]   <= (A ^ B);
            4'h7: reg_R[data_width - 1:0]   <= ~A;
            4'h8: reg_R[data_width - 1:0]   <= ~B;
            4'h9: reg_R   <= B + 1;
            4'ha: reg_R   <= A + 1;
            4'hb: reg_R   <= A - 1;
            4'hc: reg_R   <= B - 1;
            4'hd: reg_R[data_width - 1:0]   <= A << 1;    // <<	Shift Left, Logical (fill with zero)
                                        // <<< Shift Left, Arithmetic (keep sign)
            4'he: reg_R[data_width - 1:0]   <= A >> 1;    // >>	Shift Right, Logical (fill with zero)
                                        // >>> Shift Right, Arithmetic (keep sign)
            4'hf: reg_R[data_width - 1:0]   <= 'b0;  
            default: reg_R[data_width - 1:0]   <= 'b0;
    endcase
end

assign R    = reg_R;
assign flag = 1'b0; //optional

endmodule



