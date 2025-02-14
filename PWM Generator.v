module pwm_generator (
    input wire clk,        // 100 Hz clock
    input wire reset,      // Reset
    input wire [7:0] duty, // Duty cycle (0-100)
    output reg pwm_out     // LED output
);

    parameter PWM_PERIOD = 100;  // 100 steps for 1% resolution
    reg [7:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            counter <= counter + 1;
            if (counter >= PWM_PERIOD) counter <= 0;
            pwm_out <= (counter < duty) ? 1 : 0;
        end
    end
endmodule
