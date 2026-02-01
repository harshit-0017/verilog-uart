module uart_top (
    input clk, rst,
    input rx,
    input [7:0] tx_data,
    input tx_start,
    output tx,
    output [7:0] rx_data,
    output rx_rdy,
    output tx_busy
);

wire rx_tick;
wire tx_tick;

baud_rate_gen br_gen (
    .clk(clk),
    .rx_en(rx_tick),
    .tx_en(tx_tick)
);

Transmitter transmitter_unit (
    .clk(clk),
    .wr_en(tx_start),
    .rst(rst),
    .en(tx_tick),
    .data_in(tx_data),
    .tx(tx),
    .busy(tx_busy)
);

receiver receiver_unit (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rdy_clr(rx_rdy),
    .clk_en(rx_tick),
    .rdy(rx_rdy),
    .data_out(rx_data)
);

endmodule