
module spi_master (

    input  wire       clk, start, reset,

    input  wire [7:0] tx_data,

    output reg  [7:0] rx_data,

    output reg        mosi,

    input  wire       miso,

    output reg        sclk, ss

);



    reg [2:0] bit_count;

    reg [7:0] shift_reg;

    reg [1:0] state;



    parameter IDLE  = 2'b00;

    parameter SEND  = 2'b01;

    parameter FINSH = 2'b10;



    always @(posedge clk or posedge reset) begin

        if (reset) begin

            state     <= IDLE;

            ss        <= 1'b1;

            sclk      <= 1'b0;

            bit_count <= 0;

            mosi      <= 1'b0;

            rx_data   <= 8'h00; 

            shift_reg <= 8'h00;

        end else begin

            case (state)

                IDLE: begin

                    ss   <= 1'b1;

                    sclk <= 1'b0;

                 

                    rx_data <= rx_data; 

                    if (start) begin

                        shift_reg <= tx_data;

                        mosi      <= tx_data[7]; 

                        state     <= SEND;

                        bit_count <= 0;

                        ss        <= 1'b0;

                    end

                end



                SEND: begin

                    sclk <= ~sclk;

                 

                    rx_data <= rx_data; 

                    

                    if (sclk == 1'b0) begin

                        shift_reg <= {shift_reg[6:0], miso};

                    end 

                    else begin

                        if (bit_count == 7) begin

                            state <= FINSH;

                        end else begin

                            bit_count <= bit_count + 1;

                            mosi      <= shift_reg[7];

                        end

                    end

                end



                FINSH: begin

                    ss      <= 1'b1;

                    sclk    <= 1'b0;

                    rx_data <= shift_reg; 

                    state   <= IDLE;

                end



                default: state <= IDLE;

            endcase

        end

    end



endmodule

