///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - SR latch module for counter
//
// Detailed module description:
//
// This is SR latch for swiching
// between UP or DOWN counting
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////
module sr_latch(
        input wire clk, up, down,
        output wire out
    );

reg r_out = 1'b0;

always@(posedge clk) begin
    case ({up,down})
        2'b01 :  r_out <= 0;
        2'b10 :  r_out <= 1;
        default : r_out <= r_out;
    endcase
end
assign out = r_out;

endmodule
