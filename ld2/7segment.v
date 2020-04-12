///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - bin_7segment module for counter
//
// Detailed module description:
//
// This module 16bit input transforms 
// in 7-segment display induvidual segments
// as outputs. Input clock is 1kHz and it 
// drives common anode for 7-segment display
//
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////
module bin_7segment(
    input           clk,  // clock working with 1kHz
    input   [15:0]  in,   // input
    output  [6:0]   seg,  // individual segments of number
    output  [3:0]   an,   // anode to select character
    output          dp    // dot on 7segment display
    );

//-------------Internal Constants---------------------------
parameter SIZE = 2;
parameter [SIZE-1:0]    ONE     = 2'b00,
                        TWO     = 2'b01,
                        THREE   = 2'b10,
                        FOUR    = 2'b11;

reg [SIZE-1:0] state=ONE, next=TWO;
reg [6:0] r_nibble = 'b0 ;
reg [3:0] r_an = 'b0 ;

//---------State register sequential always block-----------
always @(posedge clk ) begin
    state <= next;
end
//----Next state & outputs, combinational always block------

always@(posedge clk)begin
  case(state)
    ONE : begin 
        next <= TWO; 
		r_an <= 4'b0001;
        case (in[3:0]) 
			4'h0 : r_nibble <= 7'b0111111;
			4'h1 : r_nibble <= 7'b0000110;
			4'h2 : r_nibble <= 7'b1011011;
			4'h3 : r_nibble <= 7'b1001111;
			4'h4 : r_nibble <= 7'b1100110;
			4'h5 : r_nibble <= 7'b1101101;
			4'h6 : r_nibble <= 7'b1111101;
			4'h7 : r_nibble <= 7'b0000111;
			4'h8 : r_nibble <= 7'b1111111;
			4'h9 : r_nibble <= 7'b1101111;
			4'ha : r_nibble <= 7'b1110111;
			4'hb : r_nibble <= 7'b1111100;
			4'hc : r_nibble <= 7'b0111001;
			4'hd : r_nibble <= 7'b1011110;
			4'he : r_nibble <= 7'b1111001;
			4'hf : r_nibble <= 7'b1110001;
		endcase
    end
    TWO : begin
        next <= THREE;
		r_an <= 4'b0010;
        case (in[7:4]) 
			4'h0 : r_nibble <= 7'b0111111;
			4'h1 : r_nibble <= 7'b0000110;
			4'h2 : r_nibble <= 7'b1011011;
			4'h3 : r_nibble <= 7'b1001111;
			4'h4 : r_nibble <= 7'b1100110;
			4'h5 : r_nibble <= 7'b1101101;
			4'h6 : r_nibble <= 7'b1111101;
			4'h7 : r_nibble <= 7'b0000111;
			4'h8 : r_nibble <= 7'b1111111;
			4'h9 : r_nibble <= 7'b1101111;
			4'ha : r_nibble <= 7'b1110111;
			4'hb : r_nibble <= 7'b1111100;
			4'hc : r_nibble <= 7'b0111001;
			4'hd : r_nibble <= 7'b1011110;
			4'he : r_nibble <= 7'b1111001;
			4'hf : r_nibble <= 7'b1110001;
		endcase
    end
    THREE : begin 
        next <= FOUR;
		r_an <= 4'b0100;
        case (in[11:8]) 
			4'h0 : r_nibble <= 7'b0111111;
			4'h1 : r_nibble <= 7'b0000110;
			4'h2 : r_nibble <= 7'b1011011;
			4'h3 : r_nibble <= 7'b1001111;
			4'h4 : r_nibble <= 7'b1100110;
			4'h5 : r_nibble <= 7'b1101101;
			4'h6 : r_nibble <= 7'b1111101;
			4'h7 : r_nibble <= 7'b0000111;
			4'h8 : r_nibble <= 7'b1111111;
			4'h9 : r_nibble <= 7'b1101111;
			4'ha : r_nibble <= 7'b1110111;
			4'hb : r_nibble <= 7'b1111100;
			4'hc : r_nibble <= 7'b0111001;
			4'hd : r_nibble <= 7'b1011110;
			4'he : r_nibble <= 7'b1111001;
			4'hf : r_nibble <= 7'b1110001;
		endcase
    end
    FOUR : begin 
        next <= ONE;
		r_an <= 4'b1000;
        case (in[15:12]) 
			4'h0 : r_nibble <= 7'b0111111;
			4'h1 : r_nibble <= 7'b0000110;
			4'h2 : r_nibble <= 7'b1011011;
			4'h3 : r_nibble <= 7'b1001111;
			4'h4 : r_nibble <= 7'b1100110;
			4'h5 : r_nibble <= 7'b1101101;
			4'h6 : r_nibble <= 7'b1111101;
			4'h7 : r_nibble <= 7'b0000111;
			4'h8 : r_nibble <= 7'b1111111;
			4'h9 : r_nibble <= 7'b1101111;
			4'ha : r_nibble <= 7'b1110111;
			4'hb : r_nibble <= 7'b1111100;
			4'hc : r_nibble <= 7'b0111001;
			4'hd : r_nibble <= 7'b1011110;
			4'he : r_nibble <= 7'b1111001;
			4'hf : r_nibble <= 7'b1110001;
		endcase
    end
  endcase
end

  assign seg = ~r_nibble;	// inverse active LOW
  assign dp = 1'b1;         //dot
  assign an = ~r_an;		// inverse active LOW
  
endmodule