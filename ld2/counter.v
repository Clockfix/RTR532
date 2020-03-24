///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - counter module
//
// Detailed module description:
//
// This module counts form 0000 to ffff
// in hex
//
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////

module counter  (
    input               clk,
    input               reset,
    output      [15:0]  counter);

always@(posedge clk) begin
    if (reset == 'b1) begin
        r_counter <= 'b0;
        end
    else begin
        r_counter <= r_counter + 1;
        end
end


reg     [15:0]      r_counter = 'b0;

assign counter = r_counter;

endmodule