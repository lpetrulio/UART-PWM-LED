module top_uart_pwm_system (
    input wire clk,       // 25 MHz system clock
    input wire reset,     // Reset button
    input wire rx,        // UART RX line (Serial Input)
    output wire pwm_out   // LED output
);

    wire clk_uart;        // 115200 baud clock
    wire [7:0] uart_data; // Received UART data
    wire data_ready;      // Data valid flag
    wire [7:0] duty_cycle; // Parsed duty cycle value

    // Instantiate UART Clock Divider
    uart_clock_divider clk_div (
        .clk_in(clk),
        .reset(reset),
        .clk_out(clk_uart)
    );

    // Instantiate UART Receiver
    uart_receiver uart_rx (
        .clk(clk_uart),
        .reset(reset),
        .rx(rx),
        .data(uart_data),
        .data_ready(data_ready)
    );

    // Instantiate Command Parser
    command_parser cmd_parser (
        .clk(clk),
        .reset(reset),
        .uart_data(uart_data),
        .data_ready(data_ready),
        .duty_cycle(duty_cycle)
    );

    // Instantiate PWM Generator
    pwm_generator pwm_gen (
        .clk(clk_uart),
        .reset(reset),
        .duty(duty_cycle),
        .pwm_out(pwm_out)
    );

endmodule
