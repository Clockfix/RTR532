module lookuptable #( parameter    phase_width = 4,  data_width	= 8)(
	input               [phase_width - 1 :0]  phase,
	output     reg      [data_width - 1 :0]  sin,
	output     reg      [data_width - 1 :0]  cos);
always@* begin
case (phase[phase_width - 1 : 0])
	4'd0 : sin[data_width - 1 : 0] <= 8'b00000000;
	4'd1 : sin[data_width - 1 : 0] <= 8'b00011001;
	4'd2 : sin[data_width - 1 : 0] <= 8'b00101101;
	4'd3 : sin[data_width - 1 : 0] <= 8'b00111011;
	4'd4 : sin[data_width - 1 : 0] <= 8'b01000000;
	4'd5 : sin[data_width - 1 : 0] <= 8'b00111011;
	4'd6 : sin[data_width - 1 : 0] <= 8'b00101101;
	4'd7 : sin[data_width - 1 : 0] <= 8'b00011001;
	4'd8 : sin[data_width - 1 : 0] <= 8'b00000000;
	4'd9 : sin[data_width - 1 : 0] <= 8'b11101000;
	4'd10 : sin[data_width - 1 : 0] <= 8'b11010011;
	4'd11 : sin[data_width - 1 : 0] <= 8'b11000101;
	4'd12 : sin[data_width - 1 : 0] <= 8'b11000000;
	4'd13 : sin[data_width - 1 : 0] <= 8'b11000101;
	4'd14 : sin[data_width - 1 : 0] <= 8'b11010011;
	4'd15 : sin[data_width - 1 : 0] <= 8'b11101000;
	default   : sin[data_width - 1 : 0] <= 8'b00000000;
 endcase
end
 
always@* begin
case (phase[phase_width - 1 : 0])
	4'd0 : cos[data_width - 1 : 0] <= 8'b01000000;
	4'd1 : cos[data_width - 1 : 0] <= 8'b00111011;
	4'd2 : cos[data_width - 1 : 0] <= 8'b00101101;
	4'd3 : cos[data_width - 1 : 0] <= 8'b00011001;
	4'd4 : cos[data_width - 1 : 0] <= 8'b00000000;
	4'd5 : cos[data_width - 1 : 0] <= 8'b11101000;
	4'd6 : cos[data_width - 1 : 0] <= 8'b11010011;
	4'd7 : cos[data_width - 1 : 0] <= 8'b11000101;
	4'd8 : cos[data_width - 1 : 0] <= 8'b11000000;
	4'd9 : cos[data_width - 1 : 0] <= 8'b11000101;
	4'd10 : cos[data_width - 1 : 0] <= 8'b11010011;
	4'd11 : cos[data_width - 1 : 0] <= 8'b11101000;
	4'd12 : cos[data_width - 1 : 0] <= 8'b00000000;
	4'd13 : cos[data_width - 1 : 0] <= 8'b00011001;
	4'd14 : cos[data_width - 1 : 0] <= 8'b00101101;
	4'd15 : cos[data_width - 1 : 0] <= 8'b00111011;
	default   : cos[data_width - 1 : 0] <= 8'b01000000;
 endcase
end
endmodule