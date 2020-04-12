///////////////////////////// 
// Author - Imants Pulkstenis
// Date - 24.03.2020
// Project name - Lab work No2 - Counter
// Module name - SR latch module for counter
//
// Detailed module description:
//
// This is SR latch for swoching
// between UP or DOWN counting
//
// Revision:
// A - initial design
// B - 
// 
//
/////////////////////////////
module sr_latch(
        input wire S, R, C,
        output reg Q, notQ
    );

always@(S, R, C, Q, notQ)
    if(C) begin
        Q <= (~R & Q) | S;
        Q <= (~S & Q) | R;
    end
endmodule
