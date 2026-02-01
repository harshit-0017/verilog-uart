# verilog-uart
# UART Transceiver with 16x Oversampling (Verilog)

![Language](https://img.shields.io/badge/Language-Verilog-blue) ![Tools](https://img.shields.io/badge/Tools-Icarus%20Verilog%20%7C%20GTKWave-green) ![Status](https://img.shields.io/badge/Status-Verified-brightgreen)

## 📌 Overview
This repository contains a fully synthesizable **Universal Asynchronous Receiver-Transmitter (UART)** designed in Verilog HDL. 

Unlike basic implementations, this design features **16x Oversampling** in the receiver to ensure robust data integrity and noise immunity. The project allows full-duplex communication and has been verified using a loopback testbench.

## ⚙️ Architecture

```mermaid
graph TD
    subgraph UART_TOP [UART Top Module]
        direction LR
        BRG[Baud Rate Generator]
        TX_UNIT[Transmitter Unit]
        RX_UNIT[Receiver Unit]

        BRG -- "tx_en (1x Tick)" --> TX_UNIT
        BRG -- "rx_en (16x Tick)" --> RX_UNIT

        INPUT_DATA([tx_data]) --> TX_UNIT
        START([tx_start]) --> TX_UNIT
        TX_UNIT -- "tx (Serial Data)" --> TX_OUT([tx Pin])
        TX_UNIT -- busy --> BUSY([tx_busy])

        RX_IN([rx Pin]) -- "rx (Serial Data)" --> RX_UNIT
        RX_UNIT -- "rx_data (8-bit)" --> DATA_OUT([rx_data])
        RX_UNIT -- ready --> RDY([rx_rdy])
    end
    
    CLK((clk)) --> BRG & TX_UNIT & RX_UNIT
    RST((rst)) --> BRG & TX_UNIT & RX_UNIT

    style BRG fill:#f9f,stroke:#333,stroke-width:2px
    style TX_UNIT fill:#bbf,stroke:#333,stroke-width:2px
    style RX_UNIT fill:#bfb,stroke:#333,stroke-width:2px



    🚀 Key Features
Robust Receiver: Implements 16x Oversampling logic. Instead of a single check, it samples the incoming data 16 times per bit period and captures the value at the exact center (Tick 7/15), minimizing errors due to clock drift or noise.

FSM-Based Control: Utilizes efficient Finite State Machines (FSM) (Idle → Start → Data → Stop) for reliable operation.

Baud Rate Generator: Configurable Mod-N counter to generate precise baud ticks (Standard 9600 baud at 50MHz clock).

Synthesizable: Written using standard non-blocking assignments (<=) and synchronous resets.📊 Simulation Results
The design was verified using Icarus Verilog and GTKWave. Data sent by the Transmitter (0x41 -> 'A', 0x51 -> 'Q') is looped back to the Receiver correctly.

🛠️ How to Run
git clone [https://github.com/harshit-0017/verilog-uart.git](https://github.com/harshit-0017/verilog-uart.git)
cd verilog-uart
iverilog -o sim_result tb_uart_top.v uart_top.v Transmitter.v receiver.v baund_rate_gen.v
vvp sim_result
gtkwave waveform.vcd
Yeh raha wo Pura Content jo tumhe apni README.md file mein likhna hai.

Isme maine Block Diagram aur Waveform Image ka code bhi set kar diya hai.

Step 1: Copy this Code
Niche diye gaye box mein se sab kuch copy kar lo:

Markdown
# UART Transceiver with 16x Oversampling (Verilog)

![Language](https://img.shields.io/badge/Language-Verilog-blue) ![Tools](https://img.shields.io/badge/Tools-Icarus%20Verilog%20%7C%20GTKWave-green) ![Status](https://img.shields.io/badge/Status-Verified-brightgreen)

## 📌 Overview
This repository contains a fully synthesizable **Universal Asynchronous Receiver-Transmitter (UART)** designed in Verilog HDL. 

Unlike basic implementations, this design features **16x Oversampling** in the receiver to ensure robust data integrity and noise immunity. The project allows full-duplex communication and has been verified using a loopback testbench.

## ⚙️ Architecture

```mermaid
graph TD
    subgraph UART_TOP [UART Top Module]
        direction LR
        BRG[Baud Rate Generator]
        TX_UNIT[Transmitter Unit]
        RX_UNIT[Receiver Unit]

        BRG -- "tx_en (1x Tick)" --> TX_UNIT
        BRG -- "rx_en (16x Tick)" --> RX_UNIT

        INPUT_DATA([tx_data]) --> TX_UNIT
        START([tx_start]) --> TX_UNIT
        TX_UNIT -- "tx (Serial Data)" --> TX_OUT([tx Pin])
        TX_UNIT -- busy --> BUSY([tx_busy])

        RX_IN([rx Pin]) -- "rx (Serial Data)" --> RX_UNIT
        RX_UNIT -- "rx_data (8-bit)" --> DATA_OUT([rx_data])
        RX_UNIT -- ready --> RDY([rx_rdy])
    end
    
    CLK((clk)) --> BRG & TX_UNIT & RX_UNIT
    RST((rst)) --> BRG & TX_UNIT & RX_UNIT

    style BRG fill:#f9f,stroke:#333,stroke-width:2px
    style TX_UNIT fill:#bbf,stroke:#333,stroke-width:2px
    style RX_UNIT fill:#bfb,stroke:#333,stroke-width:2px

🚀 Key Features
Robust Receiver: Implements 16x Oversampling logic. Instead of a single check, it samples the incoming data 16 times per bit period and captures the value at the exact center (Tick 7/15), minimizing errors due to clock drift or noise.

FSM-Based Control: Utilizes efficient Finite State Machines (FSM) (Idle → Start → Data → Stop) for reliable operation.

Baud Rate Generator: Configurable Mod-N counter to generate precise baud ticks (Standard 9600 baud at 50MHz clock).

Synthesizable: Written using standard non-blocking assignments (<=) and synchronous resets.

📊 Simulation Results
The design was verified using Icarus Verilog and GTKWave. Data sent by the Transmitter (0x41 -> 'A', 0x51 -> 'Q') is looped back to the Receiver correctly.

🛠️ How to Run
Clone the repository:

Bash
git clone [https://github.com/harshit-0017/verilog-uart.git](https://github.com/harshit-0017/verilog-uart.git)
cd verilog-uart
Compile the design:

Bash
iverilog -o sim_result tb_uart_top.v uart_top.v Transmitter.v receiver.v baund_rate_gen.v
Run simulation:

Bash
vvp sim_result
View Waveform:

Bash
gtkwave waveform.vcd
📂 File Structure
uart_top.v: Top-level module (connects TX, RX, and Baud Gen).

Transmitter.v: Serializing logic with FSM.

receiver.v: Deserializing logic with 16x Oversampling.

baund_rate_gen.v: Generates clock ticks.

tb_uart_top.v: Loopback Testbench.

Author: Harshit | IIIT Bhopal

