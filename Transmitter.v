module Transmitter(
    input clk, 
    input wr_en, 
    input rst, 
    input en,          // Added this: you forgot to declare 'en' as input
    input [7:0] data_in, 
    output reg tx, 
    output busy
);

    parameter idle_S  = 2'b00;
    parameter start_S = 2'b01;
    parameter data_S  = 2'b10;
    parameter stop_S  = 2'b11;

    reg [7:0] data;
    reg [2:0] index;
    reg [1:0] state;

    assign busy = (state != idle_S);

    always @(posedge clk) begin
        if(rst) begin
            state <= idle_S;
            tx    <= 1'b1;     // when no working then high
            index <= 3'h0;
            data  <= 8'h00;
        end
        else begin
            case (state)
                idle_S: begin
                    tx <= 1'b1; // Keep line high when idle
                    if (wr_en) begin
                        state <= start_S;
                        data  <= data_in;
                        index <= 3'h0;
                    end
                end

                start_S: begin
                    if (en) begin
                        tx    <= 1'b0; // start bit
                        state <= data_S;
                    end
                end

                data_S: begin
                    if (en) begin
                        tx <= data[index];
                        if(index == 3'h7) begin
                            state <= stop_S;
                        end
                        else begin
                            index <= index + 3'h1;
                        end
                    end
                end

                stop_S: begin
                    if (en) begin
                        tx    <= 1'b1; // stop bit
                        state <= idle_S;
                    end
                end

                default: begin
                    state <= idle_S;
                end
            endcase
        end
    end

endmodule