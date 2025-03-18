# UART-Controlled PWM LED duty cycle on FPGA
### FPGA Project Using Verilog & UART

This project allows an FPGA to control LED duty cycle using UART commands sent from a PC. A Python script sends commands such as `b50` to set the LED to 50% duty cycle, `b90` for 90% duty cycle, and `r` to **reset. 

---

## Features
**Receive UART data from PC (115200 baud)**  
**Parse ASCII commands (`b50`, `b90`, `r`) to adjust duty cycle of LED**  
**Generate PWM signal based on received duty cycle**  
**Python script to send UART commands (`pyserial`)**  

---

## Project Components
### FPGA Design (Verilog)
- **`uart_receiver.v`** → Receives UART data, outputs received byte.
- **`command_parser.v`** → Converts ASCII commands to `duty_cycle` values.
- **`clock_divider.v`** → divides system clock (25MHz) to a 100Hz clock to be used in PWM
- **`pwm_generator.v`** → Generates PWM signal based on `duty_cycle`.
- **`top_uart_pwm_system.v`** → Integrates all modules.

### Notes
- ** I used an Arty A7 100T and vivado, so I chose to use a clock wizard (IP) found in vivado to generate the 25MHz system clock. The instantiation of this module can be found in the top module, but feel free to adjust/remove if you're using a clock wizard or not.

### Software (Python)
- **`uart_send.py`** → Sends UART commands (`b50`, `b90`, `r`) to FPGA.

---

## How to Run (Once Debugged)
1. **Flash the FPGA with `top_uart_pwm_system.v`**.
2. **Run Python script to send commands: figure out what com port you need to execute script on in device manager, also can adjust baud rate if need be**

