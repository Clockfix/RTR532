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

reg [data_width :0] reg_R  = 'h0; // width is 33 to capture overflow or underflow                 
reg reg_flag = 'b0;
reg [data_width - 2 : 0 ] reg_max_pos = 'b1;            // maximum
//define the operation of the module! [part 5 of the VHDL file]
always@(posedge clk) begin
    case (op)        
            4'h0: begin 
                    reg_R   <= A - B;
                    if ( B > A ) begin   
                        reg_flag = 'b1;
                    end 
                    else reg_flag = 'b0;
                  end
            4'h1: begin
                    reg_R   <= A + B;
                    if ((A + B) > reg_max_pos ) begin   
                        reg_flag = 'b1;
                    end 
                    else reg_flag = 'b0;
                  end
            4'h2: begin
                    reg_R   <= ~(A & B);
                    reg_flag = 'b0;
                  end
            4'h3: begin
                    reg_R   <= A & B;
                    reg_flag = 'b0;
                  end
            4'h4: begin
                    reg_R   <= A | B;
                    reg_flag = 'b0;
                  end
            4'h5: begin
                    reg_R   <= ~(A | B);
                    reg_flag = 'b0;
                  end
            4'h6: begin
                    reg_R   <= A ^ B;
                    reg_flag = 'b0;
                  end
            4'h7: begin
                    reg_R   <= ~A;
                    reg_flag = 'b0;
                  end
            4'h8: begin
                    reg_R   <= ~B;
                    reg_flag = 'b0;
                  end
            4'h9: begin 
                    reg_R   <= B + 1;
                    if ( B == reg_max_pos ) reg_flag = 'b1;
                  end
            4'ha: begin 
                    reg_R   <= A + 1;
                    if (  reg_max_pos ) reg_flag = 'b1;
                  end
            4'hb: begin 
                    reg_R   <= A - 1;
                    if ( A == {1'b1, ~reg_max_pos } ) reg_flag = 'b1;
                  end
            4'hc: begin
                    reg_R   <= B - 1;     
                    if ( B == {1'b1, ~reg_max_pos }  ) reg_flag = 'b1;
                  end  
            4'hd: begin
                    reg_R   <= A << 1;    // <<	Shift Left, Logical (fill with zero)
                    reg_flag = 'b0;       // <<< Shift Left, Arithmetic (keep sign)
                  end
            4'he: begin 
                    reg_R   <= A >> 1;    // >>	Shift Right, Logical (fill with zero)
                    reg_flag = 'b0;       // >>> Shift Right, Arithmetic (keep sign)
                  end
            4'hf: begin
                    reg_R   <= 'b0;     
                    reg_flag = 'b0;
                  end  
            default: begin
                    reg_R   <= 'b0;     
                    reg_flag = 'b0;
                  end
    endcase
end

assign R    = reg_R[data_width - 1:0];
assign flag = reg_flag; //optional

endmodule



