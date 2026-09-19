`timescale 1ns / 1ps

module Async_fifo_xpm #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)
(
    input  wire                  wr_clk,
    input  wire                  rd_clk,

    input  wire                  wr_rstn,
    input  wire                  rd_rstn,

    input  wire                  wr_en,
    input  wire                  rd_en,

    input  wire [DATA_WIDTH-1:0] wr_data,
    output reg  [DATA_WIDTH-1:0] rd_data,

    output wire                  fifo_full,
    output wire                  fifo_empty
);

    // ---------------------------------------------------------
    // FIFO depth
    // ---------------------------------------------------------
    localparam FIFO_DEPTH = 2 ** ADDR_WIDTH;


    // ---------------------------------------------------------
    // FIFO memory
    // ---------------------------------------------------------
    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];


    // ---------------------------------------------------------
    // Write and read pointers
    //
    // ADDR_WIDTH bits  -> memory address
    // 1 extra bit      -> wrap/cycle information
    // ---------------------------------------------------------
    reg [ADDR_WIDTH:0] wr_ptr_bin;
    reg [ADDR_WIDTH:0] rd_ptr_bin;


    // ---------------------------------------------------------
    // Synchronized pointers
    //
    // Write pointer synchronized into read clock domain
    // Read pointer synchronized into write clock domain
    // ---------------------------------------------------------
    wire [ADDR_WIDTH:0] wr_ptr_bin_sync_rd;
    wire [ADDR_WIDTH:0] rd_ptr_bin_sync_wr;


    // ---------------------------------------------------------
    // Next write/read pointers
    // ---------------------------------------------------------
    wire [ADDR_WIDTH:0] wr_ptr_bin_next;
    wire [ADDR_WIDTH:0] rd_ptr_bin_next;


    // =========================================================
    // WRITE POINTER
    // =========================================================

    assign wr_ptr_bin_next =
        wr_ptr_bin + ((wr_en && !fifo_full) ? 1'b1 : 1'b0);


    always @(posedge wr_clk or negedge wr_rstn)
    begin
        if (!wr_rstn)
        begin
            wr_ptr_bin <= 0;
        end
        else
        begin
            if (wr_en && !fifo_full)
            begin
                fifo_mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
            end

            wr_ptr_bin <= wr_ptr_bin_next;
        end
    end


    // =========================================================
    // READ POINTER
    // =========================================================

    assign rd_ptr_bin_next =
        rd_ptr_bin + ((rd_en && !fifo_empty) ? 1'b1 : 1'b0);


    always @(posedge rd_clk or negedge rd_rstn)
    begin
        if (!rd_rstn)
        begin
            rd_ptr_bin <= 0;
            rd_data    <= 0;
        end
        else
        begin
            if (rd_en && !fifo_empty)
            begin
                rd_data <= fifo_mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
            end

            rd_ptr_bin <= rd_ptr_bin_next;
        end
    end


    // =========================================================
    // XPM CDC
    //
    // Write pointer:
    // WRITE clock domain --> READ clock domain
    //
    // xpm_cdc_gray internally:
    // binary -> Gray -> synchronize -> binary
    // =========================================================

    xpm_cdc_gray #(
        .DEST_SYNC_FF(4),
        .INIT_SYNC_FF(0),
        .REG_OUTPUT(0),
        .SIM_ASSERT_CHK(1),
        .SIM_LOSSLESS_GRAY_CHK(1),
        .WIDTH(ADDR_WIDTH + 1)
    )
    xpm_wr_to_rd
    (
        .src_clk     (wr_clk),
        .src_in_bin  (wr_ptr_bin),
        .dest_clk    (rd_clk),
        .dest_out_bin(wr_ptr_bin_sync_rd)
    );


    // =========================================================
    // XPM CDC
    //
    // Read pointer:
    // READ clock domain --> WRITE clock domain
    //
    // binary -> Gray -> synchronize -> binary
    // =========================================================

    xpm_cdc_gray #(
        .DEST_SYNC_FF(4),
        .INIT_SYNC_FF(0),
        .REG_OUTPUT(0),
        .SIM_ASSERT_CHK(1),
        .SIM_LOSSLESS_GRAY_CHK(1),
        .WIDTH(ADDR_WIDTH + 1)
    )
    xpm_rd_to_wr
    (
        .src_clk     (rd_clk),
        .src_in_bin  (rd_ptr_bin),
        .dest_clk    (wr_clk),
        .dest_out_bin(rd_ptr_bin_sync_wr)
    );


    // =========================================================
    // FIFO EMPTY
    //
    // FIFO is empty when:
    //
    // read pointer == synchronized write pointer
    // =========================================================

    assign fifo_empty =
        (rd_ptr_bin == wr_ptr_bin_sync_rd);


    // =========================================================
    // FIFO FULL
    //
    // FIFO is full when the NEXT write pointer is exactly
    // one FIFO depth ahead of the synchronized read pointer.
    //
    // For ADDR_WIDTH = 4:
    //
    //     rd_ptr = 00000
    //     full    when wr_ptr_next = 10000
    //
    // The MSB represents the wrap/cycle.
    // =========================================================

    assign fifo_full =
        (wr_ptr_bin_next ==
         {
             ~rd_ptr_bin_sync_wr[ADDR_WIDTH],
              rd_ptr_bin_sync_wr[ADDR_WIDTH-1:0]
         });


endmodule