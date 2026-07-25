`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2026 14:38:01
// Design Name: 
// Module Name: Moore_3Process
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Moore_1Process(
    input clk, rst, din,
    output reg dout
    );
 localparam 
 S0 =0,
 S1 =1;
reg state_reg;
// reset logic 
always@(posedge clk)
begin
    if(rst)
       state_reg <= S0;
    else
        case(state_reg)
        S0:
            begin
            dout <=0;
             if(din)
               state_reg <= S1;
            end 
        S1:
            begin
            dout<=1;            
             if(din)
              state_reg <= S0;
            end 
        default:
            begin 
                dout <=0;
                state_reg <= S0;
            end 
    endcase
end

endmodule
