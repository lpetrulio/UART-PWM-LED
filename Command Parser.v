module command_parser (
    input wire clk,           // System clock
    input wire rst,           // Reset signal
    input wire [7:0] rx_data, // Data received from UART (ASCII character)
    input wire rx_valid,      // High when new UART data is available
    output reg [6:0] duty_cycle // Duty cycle (0-100) for PWM generator
);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            duty_cycle <= 0; // Reset duty cycle to 0%
        end else if (rx_valid) begin
            // Check if the received byte is within ASCII range for '0' - '9'
            if (rx_data >= "0" && rx_data <= "9") begin
                duty_cycle <= (rx_data - "0") * 10;  // Convert ASCII '0'-'9' to duty cycle (0-100)
            end
        end
    end
endmodule
