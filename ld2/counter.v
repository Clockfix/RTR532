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
    input       [3:0]   max,
    output      [15:0]   counter);

always@(posedge clk) begin
    if (reset == 'b1) begin
            r_adder <= 'b0;
        end
    else begin
            if (r_adder >= max )begin
                r_counter <= r_counter + 1;
                r_adder <= 0;
            end 
            else begin
                r_adder <= r_adder + 1;
            end
        end
end

reg     [15:0]       r_adder = 'b0;
reg     [15:0]       r_counter = 'b0;

assign counter = r_counter;

endmodule