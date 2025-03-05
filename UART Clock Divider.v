module uart_clock_divider (
    input wire clk_in,      // 100 MHz System Clock
    input wire reset,       // Asynchronous Reset
    output reg clk_out      // 9600 baud clock
);

    parameter DIV_VALUE = 5208;  // 100MHz / (9600 * 2)
    reg [12:0] counter;          // 13-bit counter (log2(5208) ≈ 13)

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

