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
    input start,
    output out);

reg r_out = 1'b0;

always@(posedge start) begin
    r_out <= ~r_out;
end

assign out = r_out;

endmodule