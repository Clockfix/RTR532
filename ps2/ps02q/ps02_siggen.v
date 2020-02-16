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

    reg [data_width - 1 : 0] A_list [15:0] = 
	{
		-'d15, //sub
		-'d14, //add
		'h0000DEAD, //nand
		'h0000BEEF, //and
		'h0000ABCD, //or
		'h0000EFAD, //nor
		'h00001279, //xor
		'h00000310, //not a
		'h00003010, //not b
		-'d1,//incr B
		'd0,//incr A
		'd0,//sub A
		'd0,//sub B
		'h00000F0F,//sll A
		'h00000000,//sll B
		'h00001234//noop
    };


	reg [data_width - 1 : 0] V_list [15:0] = 
	{
		'd37, //sub
		-'d999, //add
		'h00001221, //nand
		'h00000FF0, //and
		'h0000F00F, //or
		'h00008754, //nor
		'h0000ADBF, //xor
		'h0000FECD, //not a
		'h0000CCDC, //not b
		'd0,//incr B
		-'d1,//incr A
		'd0,//sub A
		'd0,//sub B
		'h0000F0F0,//sll A
		'h0000ABAB,//sll B
		'h00004321 //noop
	};
	

	//define the operation of the module!

assign	A = A_list(op_cnt);
assign	B = B_list(op_cnt);
		
always@(posedge clk)
	begin
			if (rst == 1)  
				op_cnt <= 'b0; //zero counter on rst
			else
				op_cnt <= op_cnt + 1;
	end 


endmodule





