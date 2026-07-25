`timescale 1ns / 1ps
module Sequenc_detector_over(
    input clk, rst, din,
    output  SqDetected
    );
 localparam [1:0]
    S0 = 0,
    S1 = 1,
    S2 = 2,
    S3 = 3;
reg [1:0] state_next, state_reg;
reg SqDetected_next, SqDetected_reg;
// 2 process state-machine 
// reset logic 
always@(posedge clk)
begin
    if(rst)
        begin
        state_reg <= S0;
        SqDetected_reg <= 0;
        end
    else
        begin
        state_reg <=state_next;        
        SqDetected_reg <= SqDetected_next;
        end
end

always@(din, state_reg)
begin
    state_next <= state_reg;  
    SqDetected_next <=0;
    case(state_reg)
    S0:
        begin
          if(din)
            state_next <= S1;
          else
            state_next <= S0;        
        end
    S1:
        begin
          if(din)
            state_next <= S1;
          else
            state_next <= S2;        
        end
    S2:
        begin        
          if(din)
            state_next <= S3;
          else
            state_next <= S0;        
        end
    S3:
        begin
          if(din)
          begin
            SqDetected_next <=1;
            state_next <= S1;
          end
          else
            state_next <= S2;        
        end
    default:
        begin
            state_next <=S0;
        end
    endcase
end

assign SqDetected = SqDetected_reg;
endmodule
