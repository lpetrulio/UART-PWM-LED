# UART-Controlled PWM LED Brightness on FPGA
### FPGA Project Using Verilog & UART

This project allows an **FPGA** to control LED brightness using **UART commands** sent from a PC. A Python script sends commands such as `b50` to set the LED to **50% brightness**, `b90` for **90% brightness**, and `r` to **reset**. 

---

## Project Status: **Currently Being Debugged**
🔹 **Current Issue:** Testing & debugging UART reception and PWM functionality.  
🔹 **Last Debug Step:** Running Verilog testbenches to verify UART reception and command parsing.  
🔹 **Next Steps:** Fix any issues in `uart_receiver.v`, `command_parser.v`, or testbench syntax.

---

## Features
**Receive UART data from PC (115200 baud)**  
**Parse ASCII commands (`b50`, `b90`, `r`) to adjust brightness**  
**Generate PWM signal based on received duty cycle**  
**Python script to send UART commands (`pyserial`)**  

---

## Project Components
### 🔹 FPGA Design (Verilog)
- **`uart_clock_divider.v`** → Generates 115200 baud clock from 25 MHz FPGA clock.
- **`uart_receiver.v`** → Receives UART data, outputs received byte.
- **`command_parser.v`** → Converts ASCII commands to `duty_cycle` values.
- **`pwm_generator.v`** → Generates PWM signal based on `duty_cycle`.
- **`top_uart_pwm_system.v`** → Integrates all modules.

### 🔹 Software (Python)
- **`uart_send.py`** → Sends UART commands (`b50`, `b90`, `r`) to FPGA.

---

## How to Run (Once Debugged)
1. **Flash the FPGA with `top_uart_pwm_system.v`**.
2. **Run Python script to send commands:**
3. 
   python uart_send.py
