module uart_clock_divider (
    input wire clk_in,      // 25 MHz System Clock
    input wire reset,       // Asynchronous Reset
    output reg clk_out      // 115200 baud clock
);

    parameter DIV_VALUE = 217;  // 25MHz / 115200
    reg [7:0] counter;          // 8-bit counter

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter >= (DIV_VALUE - 1)) begin
                counter <= 0;
                clk_out <= ~clk_out;  // Toggle output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
