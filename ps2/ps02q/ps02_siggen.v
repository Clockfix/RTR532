// -----------------------------
// -- Author - Kriss Osmanis 
// -- Date - 2017-02-25; 2019-02-20
// -- Project name - PS02
// -- Module name - PS02 signal generator
// --
// -- Detailed module description
// -- generates values for A, B, op
// --
// --
// -- Revision:
// -- A - initial design
// -- B - modified op seq
// -- C - converted to Verilog code
// -----------------------------

//define connections to outside
module ps02_siggen #( parameter
	data_width = 32
)(
	input                       clk,
	input                       rst,
	output [data_width - 1:0]   A,
	output [data_width - 1:0]   B,
	output  [3:0]               op);


//define inside of the module

	//define inside use signals
	
	reg [3:0]  op_cnt = 'h0;
    reg [data_width - 1:0]   reg_A = 'h0;
    reg [data_width - 1:0]   reg_B = 'h0;

always@* begin
    case(op_cnt)
        4'h0: reg_A <= -'d15; //sub
		4'h1: reg_A <= -'d14; //add
		4'h2: reg_A <= 'h0000DEAD; //nand
		4'h3: reg_A <= 'h0000BEEF; //and
		4'h4: reg_A <= 'h0000ABCD; //or
		4'h5: reg_A <= 'h0000EFAD; //nor
		4'h6: reg_A <= 'h00001279; //xor
		4'h7: reg_A <= 'h00000310; //not a
		4'h8: reg_A <= 'h00003010; //not b
		4'h9: reg_A <= -'d1;//incr B
		4'hA: reg_A <= 'd0;//incr A
		4'hb: reg_A <= 'd0;//sub A
		4'hc: reg_A <= 'd0;//sub B
		4'hd: reg_A <= 'h00000F0F;//sll A
		4'he: reg_A <= 'h00000000;//sll B
		4'hf: reg_A <= 'h00001234;//noop
    endcase

    case(op_cnt)
        4'h0: reg_B <= 'd37; //sub
		4'h1: reg_B <= -'d999; //add
		4'h2: reg_B <= 'h00001221; //nand
		4'h3: reg_B <= 'h00000FF0; //and
		4'h4: reg_B <= 'h0000F00F; //or
		4'h5: reg_B <= 'h00008754; //nor
		4'h6: reg_B <= 'h0000ADBF; //xor
		4'h7: reg_B <= 'h0000FECD; //not a
		4'h8: reg_B <= 'h0000CCDC; //not b
		4'h9: reg_B <= 'd0;//incr B
		4'ha: reg_B <= -'d1;//incr A
		4'hb: reg_B <= 'd0;//sub A
		4'hc: reg_B <= 'd0;//sub B
		4'hd: reg_B <= 'h0000F0F0;//sll A
		4'he: reg_B <= 'h0000ABAB;//sll B
		4'hf: reg_B <= 'h00004321; //noop
    endcase

end
	

	//define the operation of the module!

assign	A = reg_A;
assign	B = reg_B;
assign  op = op_cnt;
		
always@(posedge clk)
	begin
			if (rst == 1)  
				op_cnt <= 'b0; //zero counter on rst
			else
				op_cnt <= op_cnt + 1;
	end 


endmodule





