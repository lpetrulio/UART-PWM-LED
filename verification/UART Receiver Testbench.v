`timescale 1ns / 1ps

module UART_RX_tb;

  // Testbench parameters
  parameter CLKS_PER_BIT = 217;  // Adjust to match your setup
  parameter BIT_PERIOD = CLKS_PER_BIT * 10;  // Assuming 10ns clock cycle

  // Testbench signals
  reg r_Clock = 0;
  reg r_RX_Serial = 1; // Default idle state
  wire w_RX_DV;
  wire [7:0] w_RX_Byte;

  // Instantiate UART_RX module
  UART_RX #(.CLKS_PER_BIT(CLKS_PER_BIT)) uut (
    .i_Clock(r_Clock),
    .i_RX_Serial(r_RX_Serial),
    .o_RX_DV(w_RX_DV),
    .o_RX_Byte(w_RX_Byte)
  );

  // Generate clock (assume 10ns period, 100MHz)
  always #5 r_Clock = ~r_Clock;

  // Task to send a UART byte
  task UART_Write_Byte;
    input [7:0] i_Data;
    integer i;
    begin
      // Send Start Bit (Low)
      r_RX_Serial <= 0;
      #(BIT_PERIOD);

      // Send Data Bits (LSB first)
      for (i = 0; i < 8; i = i + 1) begin
        r_RX_Serial <= i_Data[i];
        #(BIT_PERIOD);
      end

      // Send Stop Bit (High)
      r_RX_Serial <= 1;
      #(BIT_PERIOD);
    end
  endtask

  // Test sequence
  initial begin
    // Wait a bit before starting
    #(BIT_PERIOD * 2);

    // Send a test byte (e.g., 8'h55 = 0b01010101)
    UART_Write_Byte(8'h55);

    // Wait for reception
    #(BIT_PERIOD * 2);

    // Check received byte
    if (w_RX_DV && w_RX_Byte == 8'h55)
      $display("Test Passed: Received byte correctly.");
    else
      $display("Test Failed: Incorrect byte received.");

    // End simulation
    #100;
    $stop;
  end

endmodule
