`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2026 18:35:25
// Design Name: 
// Module Name: TB_Traffic_light
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


module TB_Traffic_light( );

reg clk, rst;
wire r,g,y;
Traffice_light_FSM uut (
    .clk(clk),
    .rst(rst),
    .r(r),
    .g(g),
    .y(y)
);

always 
begin
clk = ~clk;
#5;
end

initial
begin
clk =0;
rst =1;
#100;
rst =0;
end
endmodule
