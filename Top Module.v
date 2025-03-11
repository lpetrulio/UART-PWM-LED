module uart_pwm_top(
    input  wire clk_100MHz,   // System clock input
    input  wire rst,          // Reset signal
    input  wire uart_rx,      // UART receive data
    output wire pwm_out       // PWM output signal
);

    // Clock signals
    wire clk_25MHz;
    wire clk_100Hz;
    wire clk_locked;

    // UART RX signals
    wire rx_valid;
    wire [7:0] rx_data;

    // Duty cycle control
    wire [6:0] duty_cycle;

    // Clock Wizard Instance (100MHz -> 25MHz)
    clk_wiz_0 clk_wiz_inst (
        .clk_out1(clk_25MHz),
        .reset(rst),
        .locked(clk_locked),
        .clk_in1(clk_100MHz)
    );

    // UART Receiver Instance (115200 baud)
    UART_RX #(.CLKS_PER_BIT(217)) uart_rx_inst (
        .i_Clock(clk_25MHz),
        .i_RX_Serial(uart_rx),
        .o_RX_DV(rx_valid),
        .o_RX_Byte(rx_data)
    );

    // Command Parser Instance (Converts received ASCII to duty cycle)
    command_parser cmd_parser_inst (
        .clk(clk_25MHz),
        .rst(rst),
        .rx_data(rx_data),
        .rx_valid(rx_valid),
        .duty_cycle(duty_cycle)
    );

    // Clock Divider Instance (25MHz -> 100Hz)
    clock_divider clk_div_inst (
        .clk(clk_25MHz),
        .rst(rst),
        .slow_clk(clk_100Hz)
    );

    // PWM Generator Instance
    pwm_generator pwm_inst (
        .clk(clk_100Hz),
        .rst(rst),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)
    );

endmodule
    );

endmodule
