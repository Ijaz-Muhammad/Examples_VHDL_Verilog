`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////


module Mealy_3Process(
    input clk, rst,
    input din,
    output reg dout
    );

localparam 
    S0 = 0,
    S1 = 1;
reg  state_next,state_reg;

// reset logic process  
always@(posedge clk)
begin
    if(rst)
        state_reg <=S0;
    else
        state_reg <= state_next;
end

// state logic process 
always@(din, state_reg)
begin
    state_next <= state_reg;
    case(state_reg)
    S0: 
        begin
         if (din)
            state_next <= S1;
         else
            state_next <= S0;
        end
    S1:
        begin
          if(din)
            state_next <=S0;
          else
            state_next <=S1; 
        end
    default:
        begin
            state_next <=S0;
        end
    endcase
end

// output logic process 
always@(din, state_reg)
begin
    case(state_reg)
    S0:
        begin
        if(din)
         dout <=0;
        else
         dout <=0;
        end 
    S1: 
        begin
        if(din)
         dout <=1;
        else
         dout <=0;
        end 
    default:
       begin
         dout <=0;
       end  
    endcase
end
endmodule
