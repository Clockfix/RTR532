///////////////////////////////////////////////////////////////// 
// Author - Imants Pulkstenis
// Date - 23.02.2020
// Project name - PS03
// Module name - Smart traffic light controler
//
// Detailed module description:
//
// Task is to develop a Smart Traffic Light Controller VHDL(Verilog) 
// module using finite state machine principle (FSM).  
// 
// Port description  
// | Port name  | Direction  | Description                                                                                                              |
// |------------|------------|--------------------------------------------------------------------------------------------------------------------------|
// | Clk        | In         | 1 GHz clock (1 ns period)                                                                                                |
// | Rst        | In         | Active low reset                                                                                                         |
// | MR_cars    | In         | An 8-bit input signal indicating the number of waiting cars at the secondary road traffic light. Interpret as unsigned.  |
// | MR_ctl     | Out        | Main road traffic light controlling signal                                                                               |
// | SR_ctl     | Out        | Secondary road traffic light controlling signal                                                                          |

// Output light mapping for MR_ctl and SR_ctl signals to be used 
// | Value (2bit binary)  | Light output                      |
// |----------------------|-----------------------------------|
// | 00                   | No light – traffic light is dark  |
// | 01                   | Red light                         |
// | 10                   | Yellow light                      |
// | 11                   | Green light                       |
//
// When rst is low, outputs should be dark, no light visible 
// When rst is high then: 
//     Minimum main road green period length should be at least 30 nanoseconds. When green period ends: 
//         If there are zero cars waiting on the secondary road, then main road starts the green state again 
//         If there are less than PARAMETER cars waiting on the secondary road, green period length is extended 
//         by 30 nanoseconds and then switches to red (and secondary to green) 
//         If there are equals/more than PARAMETER cars waiting on the secondary road, main road switches to red (and secondary to green) 
//     Secondary road green period length is 10 nanoseconds, after that, main road switches to green (and secondary to red) 
//     Each transition (red to green and green to red) should go through 3 nanoseconds yellow light. Yellow lights can happen at the same 
//     time in both traffic directions. 
// MR_ctl and SR_ctl both must not be green at the same time to avoid traffic accidents. 
// PARAMETER = 45.  
//
// Revision:
// A - initial design
// B - 
// C - 
//
///////////////////////////////////////////////////////////////////

module smart_tl_ctl #( parameter
    PARAMETER	 = 45,
    MR_GREEN_TIME = 30-1, 
    SR_GREEN_TIME = 10-1,
    YELLOW_TIME = 3-1
)(
	input                                   clk,
	input                                   rst,
	input               [7:0]               MR_cars,
	output              [1:0]               MR_ctl,
	output              [1:0]               SR_ctl);

//-------------Internal Constants---------------------------
localparam      [2:0]   IDLE            = 'h0,
                        MR_GREEN_1      = 'h1,
                        MR_GREEN_2      = 'h2,
                        MR_YELLOW       = 'h3,
                        SR_GREEN        = 'h4,
                        SR_YELLOW       = 'h5;

//-------------Internal signals and components--------------
reg [2:0]               r_state = IDLE;
reg [4:0]               r_cnt = 'b0;
reg [1:0]               r_MR_ctl  = 'b0,
                        r_SR_ctl  = 'b0;

//------------ assignning combionational logic--------------

assign MR_ctl = r_MR_ctl;
assign SR_ctl = r_SR_ctl;

//----next state & outputs, combinational always block------
always@(posedge clk) begin
    if (rst) begin
    case(r_state)
        IDLE:  begin
            r_MR_ctl <= 'b00;
            r_SR_ctl <= 'b00;
            r_state <= MR_GREEN_1;
            r_cnt <= 'd0;
        end
        MR_GREEN_1:  begin
            r_MR_ctl <= 'b11;
            r_SR_ctl <= 'b01;
            if (r_cnt >= MR_GREEN_TIME) begin   
                if (MR_cars == 0) begin
                    r_cnt <= 0;
                    r_state <= MR_GREEN_1;
                    end
                else if (MR_cars < PARAMETER) begin
                    r_cnt <= 0;
                    r_state <= MR_GREEN_2;
                    end
                else if (MR_cars >= PARAMETER) begin
                    r_cnt <= 0;
                    r_state <= MR_YELLOW;
                    end  
                end
            else begin
                r_state <= MR_GREEN_1;
                r_cnt <= r_cnt + 1;
                end
        end
        MR_GREEN_2:  begin
            r_MR_ctl <= 'b11;
            r_SR_ctl <= 'b01;
            if (r_cnt >= MR_GREEN_TIME) begin
                r_cnt <= 0;
                r_state <= MR_YELLOW;
                end
            else begin
                r_cnt <= r_cnt + 1;
                r_state <= MR_GREEN_2;
                end
        end
        MR_YELLOW:  begin
            r_MR_ctl <= 'b10;
            r_SR_ctl <= 'b10;
            if (r_cnt >= YELLOW_TIME) begin
                r_cnt <= 0;
                r_state <= SR_GREEN;
                end
            else begin
                r_cnt <= r_cnt + 1;
                r_state <= MR_YELLOW;
                end
        end
        SR_GREEN:  begin
            r_MR_ctl <= 'b01;
            r_SR_ctl <= 'b11;
            if (r_cnt >= SR_GREEN_TIME) begin
                r_cnt <= 0;
                r_state <= SR_YELLOW;
                end
            else begin
                r_cnt <= r_cnt + 1;
                r_state <= SR_GREEN;
                end
        end
        SR_YELLOW:  begin
            r_MR_ctl <= 'b10;
            r_SR_ctl <= 'b10;
            if (r_cnt >= YELLOW_TIME) begin
                r_cnt = 0;
                r_state <= MR_GREEN_1;
                end
            else begin
                r_cnt <= r_cnt + 1;
                r_state <= SR_YELLOW;
                end
        end
        default: r_state <= IDLE;         // on error
    endcase
    end
    else begin
        r_state <= IDLE;
        r_MR_ctl <= 'b00;
        r_SR_ctl <= 'b00;
        r_cnt <= 0;
    end

end

endmodule