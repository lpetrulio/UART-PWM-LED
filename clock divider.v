module clock_divider(
    input clk,          // 25MHz input clock
    input rst,          // Reset signal
    output reg slow_clk // 100Hz output clock
);
    reg [17:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            slow_clk <= 0;
        end else if (count == 124999) begin
            count <= 0;
            slow_clk <= ~slow_clk; // Toggle every 10ms (100Hz)
        end else begin
            count <= count + 1;
        end
    end
endmodule