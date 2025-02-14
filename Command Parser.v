module command_parser (
    input wire clk,              // System clock
    input wire reset,            // Reset
    input wire [7:0] uart_data,  // Received UART byte
    input wire data_ready,       // High when new UART data is received
    output reg [7:0] duty_cycle  // Output duty cycle (0-100)
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            duty_cycle <= 0;
        end else if (data_ready) begin
            // Convert ASCII to integer
            if (uart_data >= "0" && uart_data <= "9") begin
                duty_cycle <= (uart_data - "0") * 10;  // Convert 'b50' → 50
            end
        end
    end
endmodule
