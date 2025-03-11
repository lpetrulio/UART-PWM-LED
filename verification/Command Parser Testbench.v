`timescale 1ns / 1ps

module command_parser_tb;

  // Testbench signals
  reg clk = 0;
  reg rst = 0;
  reg [7:0] rx_data;
  reg rx_valid;
  wire [6:0] duty_cycle;

  // Instantiate the command_parser module
  command_parser uut (
    .clk(clk),
    .rst(rst),
    .rx_data(rx_data),
    .rx_valid(rx_valid),
    .duty_cycle(duty_cycle)
  );

  // Clock generation (10ns period, 100MHz)
  always #5 clk = ~clk;

  // Task to send a character
  task send_char;
    input [7:0] char;
    begin
      rx_data = char;
      rx_valid = 1;
      #10; // Wait one clock cycle
      rx_valid = 0;
      #10; // Wait to simulate delay between characters
    end
  endtask

  // Test sequence
  initial begin
    // Reset the system
    rst = 1;
    #20;
    rst = 0;
    
    // Send '0' (should set duty_cycle to 0)
    send_char("0");
    #20;
    if (duty_cycle == 0)
      $display("Test Passed: '0' -> duty_cycle = 0");
    else
      $display("Test Failed: '0' -> duty_cycle = %d", duty_cycle);

    // Send '5' (should set duty_cycle to 50)
    send_char("5");
    #20;
    if (duty_cycle == 50)
      $display("Test Passed: '5' -> duty_cycle = 50");
    else
      $display("Test Failed: '5' -> duty_cycle = %d", duty_cycle);

    // Send '9' (should set duty_cycle to 90)
    send_char("9");
    #20;
    if (duty_cycle == 90)
      $display("Test Passed: '9' -> duty_cycle = 90");
    else
      $display("Test Failed: '9' -> duty_cycle = %d", duty_cycle);

    // Send an invalid character ('A'), should not change duty_cycle
    send_char("A");
    #20;
    if (duty_cycle == 90)
      $display("Test Passed: 'A' ignored, duty_cycle unchanged");
    else
      $display("Test Failed: 'A' altered duty_cycle to %d", duty_cycle);

    // End simulation
    #50;
    $stop;
  end

endmodule
