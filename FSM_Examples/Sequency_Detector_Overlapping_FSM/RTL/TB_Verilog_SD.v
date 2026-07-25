`timescale 1ns / 1ps
module TB_Verilog_SD( );

reg clk, rst, din;
wire SeqDet;//sequence detected 

Sequenc_detector_over uut1 (
    . clk (clk) ,
    . rst (rst) ,
    . din (din) ,
    . SqDetected(SeqDet)
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
    din =0;
    #100;
    rst =0;
    din =0;
    #10;
    din =1;
    #10;
    din =0;
    #10;
    din =1;
    #10;
    din =1;
    #10;
    din =1;
    #10;
    din =0;
    #10;
    din =1;
    #10;
    din =1;
    #10;
    din =1;
    #10;

end
endmodule
