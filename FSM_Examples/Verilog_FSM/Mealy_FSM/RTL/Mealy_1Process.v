`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////


module Mealy_1Process(
    input clk, rst,
    input din,
    output reg dout
    );

localparam 
    S0 = 0,
    S1 = 1;
reg  state_reg;

// reset logic process  
always@(posedge clk)
begin
    if(rst)
        state_reg <=S0;
    else
            case(state_reg)
    S0: 
        begin
         if (din)
            begin
            dout <=0;
            state_reg <= S1;
            end
         else
            begin
            dout <=0;
            state_reg <= S0;
            end
        end
    S1:
        begin
          if(din)
            begin
            dout <=1;
            state_reg <=S0;
            end
          else
            begin
            dout <=0;
            state_reg <=S1; 
           end
        end
    default:
        begin
            state_reg <=S0;
            dout <=0;
        end
    endcase
end

endmodule
