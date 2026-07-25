`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
////////// for small size of memory Vivado by default select DRAM 

//module Memory_def(
//    input clk, wr,
//    input [5:0] addr,
//    input [7:0] din,
//    output reg [7:0] dout
//    );
    
//reg [7:0] mem[0:63];
//always@(posedge clk)
//begin
//    if(wr)
//        begin
//            mem[addr]<= din;
//        end
//    else
//        begin
//            dout<= mem[addr];
//        end
//end
//endmodule

//////////// for large size of memory Vivado by default select BRAM 

//module Memory_def(
//    input clk, wr,
//    input [9:0] addr,
//    input [31:0] din,
//    output reg [31:0] dout
//    );
//reg [31:0] mem[0:1023];
//always@(posedge clk)
//begin
//    if(wr)
//        begin
//            mem[addr]<= din;
//        end
//    else
//        begin
//            dout<= mem[addr];
//        end
//end
//endmodule
////////// Using attributes user can define which memory will use BRAM or DRAM 

module Memory_def(
    input clk, wr,
    input [9:0] addr,
    input [31:0] din,
    output reg [31:0] dout
    );
 (* ram_style = "block" *)
 // (* ram_style = "distributed" *)
reg [31:0] mem[0:1023];
always@(posedge clk)
begin
    if(wr)
        begin
            mem[addr]<= din;
        end
    else
        begin
            dout<= mem[addr];
        end
end
endmodule
