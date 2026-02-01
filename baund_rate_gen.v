module baud_rate_gen(input clk, output rx_en, tx_en);

    // FIX: Initialize to 0 so they don't start as 'X'
    reg [12:0] tx_counter = 0;
    reg [10:0] rx_counter = 0;

    always @(posedge clk ) begin
        if(tx_counter == 5208)
            tx_counter <= 0;
        else
            tx_counter <= tx_counter + 1'b1;
    end

    always @(posedge clk ) begin
        if (rx_counter == 325) 
            rx_counter <= 0;
        else
            rx_counter <= rx_counter + 1'b1;
    end

    assign tx_en = (tx_counter == 0) ? 1'b1 : 1'b0;
    assign rx_en = (rx_counter == 0) ? 1'b1 : 1'b0;

endmodule