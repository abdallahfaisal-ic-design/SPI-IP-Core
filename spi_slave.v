
module spi_slave (

    input  wire       sclk, ss, mosi,

    output reg        miso,

    input  wire [7:0] tx_data,

    output reg  [7:0] rx_data

);



    reg [2:0] bit_count;

    reg [7:0] shift_reg;



    always @(posedge sclk or posedge ss) begin

        if (ss) begin

            bit_count <= 0;

        end else begin

            shift_reg <= {shift_reg[6:0], mosi};

            if (bit_count == 7) begin

                rx_data   <= {shift_reg[6:0], mosi};

                bit_count <= 0;

            end else begin

                bit_count <= bit_count + 1;

            end

        end

    end



    always @(negedge sclk or posedge ss) begin

        if (ss) begin

            miso <= tx_data[7];

        end else begin

            miso <= shift_reg[7];

        end

    end



endmodule

