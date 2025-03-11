`timescale 1ns / 1ps

module clock_divider_tb;

  // Testbench signals
  reg clk = 0;
  reg rst;
  wire slow_clk;

  // Instantiate the clock divider module
  clock_divider uut (
    .clk(clk),
    .rst(rst),
    .slow_clk(slow_clk)
  );

  // Generate a 25MHz clock (40ns period)
  always #20 clk = ~clk;

  // Test sequence
  initial begin
    // Reset the system
    rst = 1;
    #100; // Hold reset for a while
    rst = 0;
    
    // Wait for a few cycles to observe slow clock toggles
    $display("Waiting for slow_clk to toggle...");
    
    // Monitor slow clock toggling
    repeat (10) begin
      @(posedge slow_clk);
      $display("slow_clk toggled at time %t", $time);
    end

    // End simulation
    $display("Test completed.");
    $stop;
  end

endmodule
