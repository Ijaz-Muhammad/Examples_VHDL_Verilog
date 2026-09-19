`timescale 1ns / 1ps

module AsyncFifo_manual #(
    parameter DATA_WIDTH = 8,
    parameter ADD_WIDTH  = 4
)(
    input  clk_wr,                      // Write clock
    input  clk_rd,                      // Read clock

    input  wr_rstn,                     // Write reset, active low
    input  rd_rstn,                     // Read reset, active low

    input  wr_en,                       // Write enable
    input  rd_en,                       // Read enable

    input  [DATA_WIDTH-1:0] wr_data,    // Write data
    output reg [DATA_WIDTH-1:0] rd_data,// Read data

    output fifo_empty,                  // FIFO empty
    output fifo_full                    // FIFO full
);

    // FIFO depth
localparam FIFO_DEPTH = 2 ** ADD_WIDTH;  // 2 power 4(addr_width) = 16(depth); 

    // FIFO memory
    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];

    //========================================================
    // Write Pointer
    //========================================================

    reg [ADD_WIDTH:0] wr_ptr_bin;
    reg [ADD_WIDTH:0] wr_ptr_gray;

    //========================================================
    // Read Pointer
    //========================================================

    reg [ADD_WIDTH:0] rd_ptr_bin;
    reg [ADD_WIDTH:0] rd_ptr_gray;

    //========================================================
    // Synchronized Write Pointer in Read Clock Domain
    //========================================================

    reg [ADD_WIDTH:0] wr_ptr_gray_sync1;
    reg [ADD_WIDTH:0] wr_ptr_gray_sync2;

    //========================================================
    // Synchronized Read Pointer in Write Clock Domain
    //========================================================

    reg [ADD_WIDTH:0] rd_ptr_gray_sync1;
    reg [ADD_WIDTH:0] rd_ptr_gray_sync2;


    //========================================================
    // Binary to Gray Conversion
    //========================================================

    function [ADD_WIDTH:0] bin2gray;
        input [ADD_WIDTH:0] bin;

        begin
            bin2gray = bin ^ (bin >> 1);
        end
    endfunction


    //========================================================
    // Synchronize Write Pointer into Read Clock Domain
    //========================================================

    always @(posedge clk_rd or negedge rd_rstn)
    begin
        if (!rd_rstn)
        begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
        end
        else
        begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end


    //========================================================
    // Synchronize Read Pointer into Write Clock Domain
    //========================================================

    always @(posedge clk_wr or negedge wr_rstn)
    begin
        if (!wr_rstn)
        begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
        end
        else
        begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end


    //========================================================
    // Write Pointer Logic
    //========================================================

    always @(posedge clk_wr or negedge wr_rstn)
    begin
        if (!wr_rstn)
        begin
            wr_ptr_bin  <= 0;
            wr_ptr_gray <= 0;
        end
        else if (wr_en && !fifo_full)
        begin
            // Write data into FIFO memory
            fifo_mem[wr_ptr_bin[ADD_WIDTH-1:0]] <= wr_data;

            // Increment binary pointer
            wr_ptr_bin <= wr_ptr_bin + 1'b1;

            // Convert next binary pointer to Gray
            wr_ptr_gray <= bin2gray(wr_ptr_bin + 1'b1);
        end
    end


    //========================================================
    // Read Pointer Logic
    //========================================================

    always @(posedge clk_rd or negedge rd_rstn)
    begin
        if (!rd_rstn)
        begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
            rd_data     <= 0;
        end
        else if (rd_en && !fifo_empty)
        begin
            // Read data from FIFO memory
            rd_data <= fifo_mem[rd_ptr_bin[ADD_WIDTH-1:0]];

            // Increment binary pointer
            rd_ptr_bin <= rd_ptr_bin + 1'b1;

            // Convert next binary pointer to Gray
            rd_ptr_gray <= bin2gray(rd_ptr_bin + 1'b1);
        end
    end


    //========================================================
    // FIFO Empty
    //========================================================

    assign fifo_empty = (rd_ptr_gray == wr_ptr_gray_sync2);


    //========================================================
    // FIFO Full
    //========================================================

    assign fifo_full =
        (wr_ptr_gray ==
        {
            ~rd_ptr_gray_sync2[ADD_WIDTH:ADD_WIDTH-1],
             rd_ptr_gray_sync2[ADD_WIDTH-2:0]
        });

endmodule