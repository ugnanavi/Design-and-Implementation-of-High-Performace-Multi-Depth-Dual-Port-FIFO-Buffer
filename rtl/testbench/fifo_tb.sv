module tb_multi_depth_dual_port_fifo();

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    parameter DEPTH = 16;

    // Signals
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] wr_data;
    wire [DATA_WIDTH-1:0] rd_data;
    wire full;
    wire empty;

    // Instantiate the FIFO
    multi_depth_dual_port_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH(DEPTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        wr_en = 0;
        rd_en = 0;
        wr_data = 0;

        // Set up the VCD file for waveform dumping
        $dumpfile("dump.vcd");   // Specify the VCD file
        $dumpvars(0, tb_multi_depth_dual_port_fifo); // Dump all variables

        // Reset FIFO
        $display("Starting FIFO test...");
        rst = 1;
        #10 rst = 0;

        // Write data into FIFO
        $display("Writing data to FIFO...");
        repeat (10) begin
            @(posedge clk);
            wr_en = 1;
            wr_data = $random; // Generate random data
            $display("Written data: %h", wr_data);
        end
        wr_en = 0;

        // Read data from FIFO
        $display("Reading data from FIFO...");
        repeat (10) begin
            @(posedge clk);
            rd_en = 1;
            $display("Read data: %h", rd_data);
        end
        rd_en = 0;

        // Check FIFO full/empty
        $display("FIFO Full: %b, FIFO Empty: %b", full, empty);
        #20;
        $finish;
    end

endmodule
