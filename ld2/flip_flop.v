///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - SR latch module for counter
//
// Detailed module description:
//
// This is Flip Flop for START/STOP function
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////

module flip_flop (   
    input clk,
    input rst,
    input t,
    output reg q);
 
always @ (posedge clk) begin
    if (!rst) 
      q <= 0;
    else if (t)
        q <= ~q;
    else
        q <= q;
  end
endmodule