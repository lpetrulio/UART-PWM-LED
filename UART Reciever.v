module uart_receiver (
    input wire clk,         // 115200 baud clock
    input wire reset,       // Reset
    input wire rx,          // UART RX line (Serial Input)
    output reg [7:0] data,  // Received byte
    output reg data_ready   // High when data is valid
);

    reg [3:0] bit_index = 0;
    reg [7:0] shift_reg = 0;
    reg receiving = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_index <= 0;
            data_ready <= 0;
            receiving <= 0;
        end else begin
            if (!receiving && rx == 0) begin  // Start bit detected
                receiving <= 1;
                bit_index <= 0;
            end else if (receiving) begin
                shift_reg[bit_index] <= rx;
                bit_index <= bit_index + 1;

                if (bit_index == 7) begin
                    data <= shift_reg;
                    data_ready <= 1;
                    receiving <= 0;
                end
            end else begin
                data_ready <= 0;
            end
        end
    end
endmodule
