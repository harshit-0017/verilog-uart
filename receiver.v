module receiver(
    input clk, rst, rx, rdy_clr, clk_en,
    output reg rdy, 
    output reg [7:0] data_out
);
    parameter start_S = 2'b00;
    parameter data_S = 2'b01;
    parameter stop_S = 2'b10;

    reg [1:0] state = start_S;
    reg [3:0] sample = 0;
    reg [3:0] index = 0;
    reg [7:0] temp_reg = 8'b0;

    always @(posedge clk) begin
        if(rst) begin
            rdy <= 0;
            data_out <= 0;
            state <= start_S;
            sample <= 0;
            index <= 0;
        end
        else begin
            if(rdy_clr) rdy <= 0;

            if (clk_en) begin
                case (state)
                    start_S: begin
                        if (rx == 0 || sample != 0) begin
                            sample <= sample + 1'b1;
                        end
                        if (sample == 15) begin
                            state <= data_S;
                            sample <= 0;
                            index <= 0;
                            temp_reg <= 0;
                        end
                    end
                    data_S: begin
                        sample <= sample + 1'b1;
                        if (sample == 4'h8) begin
                            temp_reg[index] <= rx;
                            index <= index + 1'b1;
                        end
                        if (index == 8 && sample == 15) begin
                            state <= stop_S;
                            sample <= 0;
                        end
                    end
                    stop_S: begin
                        if (sample == 15) begin
                            state <= start_S;
                            data_out <= temp_reg;
                            rdy <= 1'b1;
                            sample <= 0;
                        end
                        else begin
                            sample <= sample + 1'b1;
                        end
                    end
                    default: state <= start_S;
                endcase
            end
        end
    end
endmodule




