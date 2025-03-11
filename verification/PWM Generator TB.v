`timescale 1ns / 1ps

module pwm_generator_tb;

  // Testbench signals
  reg clk = 0;
  reg reset;
  reg [7:0] duty;
  wire pwm_out;

  // Instantiate the PWM generator module
  pwm_generator uut (
    .clk(clk),
    .reset(reset),
    .duty(duty),
    .pwm_out(pwm_out)
  );

  // Generate a 100Hz clock (10ms period -> 5ms high, 5ms low)
  always #50000 clk = ~clk;  // 50,000 ns = 50 µs half-period for 100Hz

  // Test sequence
  initial begin
    // Reset the system
    reset = 1;
    duty = 0;
    #100000;  // Hold reset for a while
    reset = 0;
    
    // Test 0% Duty Cycle (pwm_out should always be 0)
    duty = 0;
    #1000000;  // Wait 1 full PWM cycle
    $display("Test 0%% Duty Cycle: pwm_out =
