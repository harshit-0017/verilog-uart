`timescale 1ns / 1ps
module tb_uart_top;
reg clk, rst;
reg [7:0] tx_data;
reg tx_start;

wire tx_line, rx_rdy, tx_busy;
wire [7:0] rx_data;
wire rx_line;

assign rx_line = tx_line;

uart_top dut (
    .clk(clk), 
    .rst(rst), 
    .rx(rx_line),      
    .tx_data(tx_data), 
    .tx_start(tx_start), 
    .tx(tx_line), 
    .rx_data(rx_data), 
    .rx_rdy(rx_rdy), 
    .tx_busy(tx_busy)
);

initial begin
    $dumpfile("waveform.fst"); 
    $dumpvars(0, tb_uart_top);
    {clk, rst, tx_data, tx_start} = 0;
    rst = 1;
    #100 rst = 0;
end

always #10 clk = ~clk;

task send_byte(input [7:0] din);
begin
    @(negedge clk);
    tx_data = din;
    tx_start = 1'b1;
    @(negedge clk) tx_start = 0;
end
endtask

initial begin
    #1000;
    send_byte(8'h41);

    wait(rx_rdy);
    $display("received data is %h", rx_data);

    #1000;

    send_byte(8'h51);

    wait(rx_rdy);
    $display("received data is %h", rx_data);

    #1000 $finish;
end
endmodule   