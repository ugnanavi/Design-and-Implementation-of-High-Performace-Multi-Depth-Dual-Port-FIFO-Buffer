module multi_depth_dual_port_fifo #(
    parameter DATA_WIDTH = 8,      // Data width in bits
    parameter ADDR_WIDTH = 4,      // Address width (log2(depth))
    parameter DEPTH = 16           // Depth of FIFO (should be a power of 2)
)(
    input wire clk,                     // Clock signal
    input wire rst,                     // Reset signal
    input wire wr_en,                   // Write enable
    input wire rd_en,                   // Read enable
    input wire [DATA_WIDTH-1:0] wr_data, // Data to write
    output reg [DATA_WIDTH-1:0] rd_data, // Data to read
    output wire full,                   // FIFO full flag
    output wire empty                   // FIFO empty flag
);

    // Internal signals
    reg [DATA_WIDTH-1:0] fifo_mem [0:DEPTH-1]; // FIFO memory
    reg [ADDR_WIDTH-1:0] wr_ptr = 0, rd_ptr = 0; // Write and Read pointers
    reg [ADDR_WIDTH:0] fifo_count = 0;           // FIFO element count

    // Full and empty flags
    assign full = (fifo_count == DEPTH);
    assign empty = (fifo_count == 0);

    // Write and Read logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            fifo_count <= 0;
            rd_data <= 0;
        end else begin
            // Write data
            if (wr_en && !full) begin
                fifo_mem[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1;
                fifo_count <= fifo_count + 1;
            end

            // Read data
            if (rd_en && !empty) begin
                rd_data <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                fifo_count <= fifo_count - 1;
            end
        end
    end

endmodule

