module lookuptable(
	input               [7 :0]  in,
	output     reg      [7 :0]  out);
reg [7 :0]      out  = 8'h0;    
always@* begin
case (in)
	8'd0 : out <= 8'b00000000;
	8'd1 : out <= 8'b00011001;
	8'd2 : out <= 8'b00101101;
	8'd3 : out <= 8'b00111011;
	8'd4 : out <= 8'b01000000;
	8'd5 : out <= 8'b00111011;
	8'd6 : out <= 8'b00101101;
	8'd7 : out <= 8'b00011001;
	8'd8 : out <= 8'b00000000;
	8'd9 : out <= 8'b11101000;
	8'd10 : out <= 8'b11010011;
	8'd11 : out <= 8'b11000101;
	8'd12 : out <= 8'b11000000;
	8'd13 : out <= 8'b11000101;
	8'd14 : out <= 8'b11010011;
	8'd15 : out <= 8'b11101000;
	default   : out <= 8'b00000000;
 endcase
end
endmodule