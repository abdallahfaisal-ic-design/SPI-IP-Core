
`timescale 1ns / 1ps



module spi_top_tb;



    // Parameters

    parameter CLK_PERIOD = 20; // Main Clock = 50MHz



    
    reg        clk;

    reg        reset;

    reg        start;

    reg  [7:0] master_tx;

    wire [7:0] master_rx;

    reg  [7:0] slave_tx;

    wire [7:0] slave_rx;



    // Instantiate UUT (Unit Under Test)

    spi_top uut (

        .clk(clk),

        .reset(reset),

        .start(start),

        .master_tx(master_tx),

        .master_rx(master_rx),

        .slave_tx(slave_tx),

        .slave_rx(slave_rx)

    );



    // Clock Generation

    always begin

        #(CLK_PERIOD / 2) clk = ~clk;

    end



    // Main Test Stimulus

    initial begin


        clk       = 0;

        reset     = 1;

        start     = 0;

        master_tx = 8'h00;

        slave_tx  = 8'h00;

        #(CLK_PERIOD * 5);

        reset = 0;

        #(CLK_PERIOD * 2);



        // ============================================================

        // --- Test Case 1: Master = 8'hD4, Slave = 8'h3E ---

        // ============================================================

        $display("[TB] --- Test Case 1 Start ---");

        

        @(posedge clk);

        master_tx = 8'hD4;

        slave_tx  = 8'h3E;

        start     = 1'b1;    

        

        @(posedge clk);

        start     = 1'b0;     




        #(CLK_PERIOD * 40);

        

      

        $display("[TB] Checking Case 1 Results...");

        if (master_rx == 8'h3E && slave_rx == 8'hD4) begin

            $display("[TB] SUCCESS: Case 1 Passed!");

        end else begin

            $display("[TB] WARNING: Data Mismatch in Case 1!");

        end

        $display("[TB] Master Received: 8'h%h (Expected: 8'h3E)", master_rx);

        $display("[TB] Slave Received:  8'h%h (Expected: 8'hD4)", slave_rx);



        #(CLK_PERIOD * 10);

        // ============================================================

        // --- Test Case 2: Master = 8'hA5, Slave = 8'h5A ---

        // ============================================================

        $display("\n[TB] --- Test Case 2 Start ---");

        

        @(posedge clk);

        master_tx = 8'hA5;

        slave_tx  = 8'h5A;

        start     = 1'b1;

        

        @(posedge clk);

        start     = 1'b0;




        #(CLK_PERIOD * 40);




        $display("[TB] Checking Case 2 Results...");

        if (master_rx == 8'h5A && slave_rx == 8'hA5) begin

            $display("[TB] SUCCESS: Case 2 Passed!");

        end else begin

            $display("[TB] WARNING: Data Mismatch in Case 2!");

        end

        $display("[TB] Master Received: 8'h%h (Expected: 8'h5A)", master_rx);

        $display("[TB] Slave Received:  8'h%h (Expected: 8'hA5)", slave_rx);




        #(CLK_PERIOD * 20);

        $display("\n[TB] All SPI Tests Finished Successfully!");

        $stop;

    end



endmodule

