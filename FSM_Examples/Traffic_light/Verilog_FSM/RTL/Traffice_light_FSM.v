`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Traffice_light_FSM(
   input clk, rst,
   output r,g,y
    );
    
localparam [1:0]
    idle    = 0,
    red     = 1,
    green   = 2,
    yellow  = 3;
reg r_next, r_reg;
reg g_next, g_reg;
reg y_next, y_reg;
reg [4:0] counter_reg,counter_next;
reg [1:0] state_next, state_reg;

// reset logic;
always@(posedge clk)
begin
    if(rst)
        begin
        r_reg <= 0;
        g_reg <= 0;
        y_reg <= 0;
        state_reg <= idle;
        counter_reg <=0;
        end 
    else
        begin
         r_reg <= r_next;
         g_reg <= g_next;
         y_reg <= y_next;
         counter_reg <= counter_next;
         state_reg <= state_next;
        end
end
/// out logic and next state logic 

always@(*)
begin
    state_next = state_reg;
    r_next  = r_reg;
    g_next  = g_reg;
    y_next  = y_reg;
    counter_next  = counter_reg;
    
    case(state_reg)
    idle: 
        begin
            counter_next  =0;
            r_next =0;
            g_next =0;
            y_next =0;
            state_next = red;
        end
    red: 
        begin
        
            r_next =1;
            g_next =0;
            y_next =0;
          if(counter_reg < 9)
          begin
            state_next = red;
            counter_next = counter_reg +1;
          end
          else
          begin
            state_next =green;
            counter_next =0;
          end
        end
     green:
        begin
        
            r_next =0;
            g_next =1;
            y_next =0;
          if(counter_reg < 9)
            begin
            state_next = green;
            counter_next = counter_reg +1;
            end
          else
            begin
            state_next =yellow;
            counter_next = 0;
            end
        end 
     yellow:
        begin 
        
            r_next =0;
            g_next =0;
            y_next =1;
          if(counter_reg < 9)
            begin
            state_next = yellow;
            counter_next = counter_reg +1;
            end
          else
            begin
            state_next =red;
            counter_next = 0;
            end
        
        end 
     default:
        begin 
            state_next = idle;
            r_next =0;
            g_next =0;
            y_next =0;
            counter_next =0;
        end  
     endcase
end

assign r = r_reg;
assign g = g_reg;
assign y = y_reg;
endmodule
