module spi_top (

    input  wire       clk, reset, start,

    input  wire [7:0] master_tx,

    output wire [7:0] master_rx,

    input  wire [7:0] slave_tx,

    output wire [7:0] slave_rx

);



    wire mosi_signal;

    wire miso_signal;

    wire sclk_signal;

    wire ss_signal;



    spi_master master (

        .clk(clk),

        .reset(reset),

        .start(start),

        .tx_data(master_tx),

        .rx_data(master_rx),

        .mosi(mosi_signal),

        .miso(miso_signal),

        .sclk(sclk_signal),

        .ss(ss_signal)

    );



    spi_slave slave (

        .sclk(sclk_signal),

        .ss(ss_signal),

        .mosi(mosi_signal),

        .miso(miso_signal),

        .tx_data(slave_tx),

        .rx_data(slave_rx)

    );



endmodule

