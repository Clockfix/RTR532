///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - clock divider module for counter
//
// Detailed module description:
//
// This module devide FPGA input clock 
// by DIVIDER. Result is 50% duty cicle 
// pulses.
//
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////


module clock_divider #(
    parameter DIVIDER =2,
    parameter WIDTH =2
) (
    input clk,
    output clk_out);

reg state=1'b0, next_state=1'b1;
reg [WIDTH-1:0] counter = DIVIDER-1 ; 

always@(posedge clk)begin
    state <= next_state;
    if ( counter == 0) begin
        next_state <= ~next_state;
        counter <= DIVIDER-1;
    end
    else if (counter >= 0 )
        counter <= counter - 1;
end

assign clk_out = state;

endmodule